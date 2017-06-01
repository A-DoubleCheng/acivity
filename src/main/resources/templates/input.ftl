<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="format-detection" content="telephone=no" />
    <title>input</title>
    <script type="text/javascript" src="js/jquery1.11.1.min.js"></script>
    <style>
        * {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;}
        input {width: 100%;border: 1px solid #ddd;height:40px;padding:0 20px;}
        button {width: 100%;height:40px;border: none;background: #ff5500;color: #fff;font-size: 21px;margin-top:40px;}
    </style>
</head>
<body>
<input type="tel" id="inputid">
<button id="buttonl">提交</button>
<script type="text/javascript">
    $(function () {
        $("#buttonl").click(function () {
            $.ajax({
                url:"/input.html",
                type:"POST",
                data:{priceinput:$("#inputid").val()},
                dataType:"json",
                success:function (json) {
                    if(json.status == '200'){
                        alert("插入成功")
                        console.log("插入成功")
                    }else {
                        alert("处理过快")
                        console.log("处理过快")
                    }

                }
            })
        })
    })
</script>
</body>
</html>