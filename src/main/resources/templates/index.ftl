<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="format-detection" content="telephone=no" />
    <title>期货铝价竞猜</title>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/jquery1.11.1.min.js"></script>
    <script type="text/javascript" src="js/layer_mobile/layer.js"></script>
</head>
<body>
<div class="banner">
    <div class="title"></div>
</div>
<div class="today">
    <h2>今日沪铝1707开盘价</h2>
    <strong data-val="${nowprice!}"></strong>
</div>
<#if flag == 'false'>
    <div class="do">
    <em class="r">涨</em>
    <input class="t" type="tel" name="" value="" placeholder="猜猜今日收盘价" id="priceTel"/>
    <input class="b" type="button" name="" value="确认我的猜价" />
    </div>
<div class="me hide">
    <h2>我猜的今日收盘价<label class="userpriceem"></label>
        <#if userprice?? && nowprice?? && (userprice > nowprice)>
            [涨]
        <#elseif userprice?? && nowprice?? && (userprice == nowprice)>
        [平]
        <#elseif userprice?? && nowprice?? && (userprice < nowprice)>
        [跌]
        </#if>
    </h2>
    <strong data-val="${userprice!}" id="userp"></strong>
    <p>竞猜成功，请耐心等待今日15:30公布结果。</p>
</div>
<#elseif flag == 'true'>
<div class="do hide">
    <em class="r">涨</em>
    <input class="t" type="tel" name="" value="" placeholder="猜猜今日收盘价" id="priceTel"/>
    <input class="b" type="button" name="" value="确认我的猜价" />
</div>
<div class="me">
    <h2>我猜的今日收盘价<label class="userpriceem"></label>
        <#if userprice?? && nowprice?? && (userprice > nowprice)>
            [涨]
        <#elseif userprice?? && nowprice?? && (userprice == nowprice)>
            [平]
        <#elseif userprice?? && nowprice?? && (userprice < nowprice)>
            [跌]
        </#if>
    </h2>
    <strong data-val="${userprice!}" id="userp"></strong>
    <p>竞猜成功，请耐心等待今日15:30公布结果。</p>
</div>
</#if>

<div class="msg">
    <h2><strong>活动说明</strong></h2>
    <p>活动时间：2017年5月26日 13:00至15:00</p>
    <p>最终结果以2017年5月26日期货沪铝1707的收盘价为准。</p>
    <p>该活动的解释权在法律规定的范围内归铝团网所有。</p>
</div>

<script type="text/javascript">
    $(function(){

//确认按钮
        $(".do .b").on('click',function(){
            var val = parseInt($(".do .t").val());
            var nowdate = new Date().getTime();
//            var stdate = 1495000800000;//2
//            var eddate = 1495004400000;//3
            var stdate = 1495774800000;//26号13点
            var eddate = 1495782000000;//26号15点

            if(nowdate < stdate){
                layer.open({
                    content: '活动还未开始，开始时间：5月26号下午1点',
                    shadeClose: false,
                    btn: '我知道了'
                });
            }else if(nowdate > eddate){
                layer.open({
                    content: '活动已经结束',
                    shadeClose: false,
                    btn: '我知道了'
                });
            }else{
                if(!val){
                    layer.open({
                        content: '请输入您的猜价',
                        skin: 'msg',
                        time: 2
                    });
                }else{
                    layer.open({
                        content: '您的猜价为 '+val+" 点击确认后提交",
                        shadeClose: false,
                        btn: ['确认', '取消'],
                        yes: function(index){
                            layer.closeAll()
                            layer.open({type: 2,shadeClose: false,content: '正在努力提交中...'});
                            console.log("这里开始AJAX请求")

                            $.ajax({
                                url:"/pricePost",
                                type:"POST",
                                dataType:"json",
                                data:{price:$("#priceTel").val()},
                                success:function (json) {
                                    console.log(json.status)

                                    if(json.status == '200'){
                                    setTimeout(function(){
                                        layer.closeAll();
                                        $(".do").hide();
                                        $(".me").show();
                                        layer.open({content: '提交猜价成功啦！',shadeClose: false,btn: '确定'});
                                        $("#userp").data("val", json.userprice);
                                        $(".userpriceem").text(json.statusguess);

                                        $("#userp").html(numsplit($("#userp").data('val').toString()))

                                    },2000)
                                    }else if(json.status == '500'){
                                        layer.closeAll()
                                        layer.open({content: json.info,shadeClose: false,btn: '确定'});
                                    }

                                }
                            })


                        }
                    });
                }
            }



        });





        $("[data-val]").each(function(i,e){
            $(this).html(numsplit($(this).data('val').toString()))
        })

        $(".do .t").bind('input propertychange', function() {


            var inputT = parseInt($(this).val());
            var val = parseInt($(".today strong").data('val'));



            if(inputT || inputT == 0){
                $(".do em").attr("class","");
                $(".do em").show();
                if(inputT < val){
                    $(".do em").addClass("g")
                    $(".do em").html("跌")
                }else if(inputT == val){
                    $(".do em").addClass("p")
                    $(".do em").html("平")
                }else if(inputT > val){
                    $(".do em").addClass("r")
                    $(".do em").html("涨")
                }
            }else{
                $(".do em").hide();
            }
        });

//分割函数
        function numsplit(str){
            var strs = [];
            strs = str.split('');
            var newstr = '';
            for (i=0;i<strs.length ;i++ ) {
                newstr += '<em>'+strs[i]+'</em>'
            }
            return newstr;
        }



    });

    document.cookie='userphone=${cookie!}'
</script>
</body>
</html>