<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="./res/css/main.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>

        <div class="container-fluid" style="padding: 0px; ">
            <div id="carousel-example-generic" class="carousel slide">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <div class="carousel-inner">
                    <div class="item active">
                        <img src="/res/img/main-slide1.png" alt="First slide" class="img-fluid img-responsive main-slide" style="width: 100%; background-size: cover;"/>
                    </div>
                    <div class="item">
                        <img src="/res/img/main-slide2.png" alt="Second slide" class="img-fluid img-responsive main-slide" style="width: 100%; background-size: cover;"/>
                    </div>
                    <div class="item">
                        <img src="/res/img/main-slide3.png" alt="Third slide" class="img-fluid img-responsive main-slide" style="width: 100%; background-size: cover;"/>
                    </div>
                </div>

                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                    <img src="/res/img/left.png" class="control">
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                    <img src="/res/img/right.png" class="control">
                </a>
            </div>
        </div>
    </body>
    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>
    <script>
        var msg = "${msg}";

        $(document).ready(function() {
            var msg = "${msg}";

            if(msg != "") {
                alert(msg);
            }
        });

        $('.carousel').carousel();
    </script>
</html>