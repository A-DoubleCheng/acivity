<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="format-detection" content="telephone=no" />
    <title>期货铝价竞猜</title>
    <link rel="stylesheet" href="css/style1.css">
    <script type="text/javascript" src="js/jquery1.11.1.min.js"></script>
</head>
<body>

<div class="main">

    <div class="main_ad">
        <h2>下载<strong>铝圈APP</strong></h2>
        <h3>参加猜铝价活动</h3>
        <img src="images/ewm.jpg" alt="" title="">
        <p>使用微信或其他二维码扫描</p>
        <p>支持IOS和安卓手机</p>
    </div>



    <div class="title">
        <h2><strong>竞猜动态</strong></h2>
        <h3><span>参与人数：</span><strong><em>0</em></strong><em>人</em></h3>
    </div>

    <div class="chartbox">
        <div class="name">
            <strong>价格</strong>
            <ul>
                <li>15001 以上</li>
                <li>14501-15000</li>
                <li>14001-14500</li>
                <li>13501-14000</li>
                <li>13500 以下</li>
            </ul>
        </div>
        <div class="chart">
            <ul>
                <li class="c1"><div><span><strong>0</strong>人<span></div></li>
                <li class="c2"><div><span><strong>0</strong>人<span></div></li>
                <li class="c3"><div><span><strong>0</strong>人<span></div></li>
                <li class="c4"><div><span><strong>0</strong>人<span></div></li>
                <li class="c5"><div><span><strong>0</strong>人<span></div></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">


    $(function(){


//按键控制
        $(document).keydown(function(event){
            if(event.keyCode == 90){
                //按下Z 输出假数据，
                //var user = [300,300,300,300,300];
                //showchart(user)
            }else if(event.keyCode == 88){
                //按下X 显示或隐藏二维码
                var l = $(".main_ad").css("left");
                if(l=="0px"){
                    $(".main_ad").css("left","1050px");
                }else{
                    $(".main_ad").css("left","0px");
                }
            }else if(event.keyCode == 67){
                //按下C
            }
        });




//每隔1秒请求数据
        setInterval(function(){
            console.log("开始请求")
            var user = new Array();
            $.ajax({
                url:"/mainFunc",
                type:"POST",
                dataType:"JSON",
                success:function (json) {
                    user[0] = json.count1
                    user[1] = json.count2
                    user[2] = json.count3
                    user[3] = json.count4
                    user[4] = json.count5
                    showchart(user);
                    console.log(user)
                }
            })
//             = [3,58,195,71,30];
        },"1000");


//重构图表
        function showchart(arr){
            var allnum = 0;
            $(".chart li div").each(function(i,e){
                $(this).find("span strong").html(arr[i]);
                $(this).css("width",arr[i]*2);
                allnum += arr[i];
            })
            $(".title h3 strong").html(numsplit(allnum.toString()))
        };

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
</script>
</body>
</html>