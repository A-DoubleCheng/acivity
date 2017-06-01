package com.activity.controller;

import com.activity.method.StartMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/5/16.
 */
@Controller
public class StratController {

    @Autowired
    StartMethod startMethod;
    @Autowired
    HttpServletRequest httpServletRequest;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String toIndex(@CookieValue(value = "userphone",required = false) String userphone, Model model){
        Cookie [] cookies = httpServletRequest.getCookies();

        List<HashMap> Phone = new ArrayList<>();
        if(!("").equals(userphone) || userphone != null) {
            Phone = startMethod.searchUserPhone(userphone);
        }
       if(Phone.size() == 0){
           model.addAttribute("flag","false");
       }else {
           model.addAttribute("flag", "true");
           model.addAttribute("userprice",Phone.get(0).get("price"));
       }

       List<HashMap> price = startMethod.searchNowPrice();
       if(price.size() > 0){
           model.addAttribute("nowprice",price.get(0).get("price"));
       }

       model.addAttribute("cookie",userphone);


        return "index";
    }

    @RequestMapping(value = "/pricePost",method = RequestMethod.POST)
    @ResponseBody
    public Map doPost(@CookieValue(value = "userphone",required = false) String userphone, String price){
        HashMap hashMap = new HashMap();
        if(!isNumeric(price)){
            hashMap.put("status","500");
            hashMap.put("info","输入格式不正确");
            return hashMap;
        }
        if(userphone == null || ("").equals(userphone)){
            hashMap.put("status","500");
            hashMap.put("info","用户未登录");
            return hashMap;
        }else{
            startMethod.setPrice(userphone,price);
            hashMap.put("status","200");
            hashMap.put("info","success");
            List<HashMap> Phone =  startMethod.searchUserPhone(userphone);
            hashMap.put("userprice", Phone.get(0).get("price"));
            List<HashMap> nowprice = startMethod.searchNowPrice();
            if(nowprice.size() > 0){
                if((Integer)nowprice.get(0).get("price") > Integer.valueOf(price)){
                    hashMap.put("statusguess", " [跌]");
                }else if((Integer)nowprice.get(0).get("price") < Integer.valueOf(price)){
                    hashMap.put("statusguess", " [涨]");
                }else if((Integer)nowprice.get(0).get("price") == Integer.valueOf(price)){
                    hashMap.put("statusguess", " [平]");
                }
            }
        }

        return hashMap;
    }

    @RequestMapping(value = "/main.html", method = RequestMethod.GET)
    public String toMain(){

        return "main";
    }

    @RequestMapping(value = "/mainFunc", method = RequestMethod.POST)
    @ResponseBody
    public Map doFunc(){
       HashMap hashMap = new HashMap();
       hashMap = startMethod.toSearchNum();

       return hashMap;
    }

    @RequestMapping(value = "/input.html",method = RequestMethod.POST)
    @ResponseBody
    public Map doInput(String priceinput){
        HashMap hashMap = new HashMap();
        startMethod.setPriceOnly(priceinput);

        hashMap.put("status","200");
        hashMap.put("info","success");

        return hashMap;
    }

    @RequestMapping(value = "/input.html",method = RequestMethod.GET)
    public String toInput(){

        return "input";
    }

    public boolean isNumeric(String str){
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(str);
        if( !isNum.matches() ){
            return false;
        }
        return true;
    }

}
