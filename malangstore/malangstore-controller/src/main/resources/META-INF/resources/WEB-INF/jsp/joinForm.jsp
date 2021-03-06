<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- bootstrap -->
        <link href="./res/fonts/fonts.css" rel="stylesheet">
        <link href="./res/css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>

        <div class="container">
            <div class="row">
                <div class="col-md-offset-1 col-md-10" style="padding: 50px 0px 50px 0px; border: 0.25px solid #dddddd; ">
                    <div class="col-md-offset-2 col-md-8">
                        <h1 class="text-header">회원가입</h1>

                        <div class="row">
                            <span class="col-md-3 input-title">
                                <b class="join-header">아이디</b>
                            </span>
                            <span class="col-md-7">
                                <input id="user-id" class="inputBox" type="text" placeholder="아이디 입력 (영문, 숫자 혼합 4~12자 입력)" onkeyup="checkId()"/>
                                <span id="user-id-msg" class="warn">　</span>
                            </span>
                            <span class="col-md-2" style="padding-left: 0px;">
                                <button class="btn-custom" onclick="isDuplicate()">중복 확인</button>
                            </span>
                        </div>

                        <div class="row">
                            <span class="col-md-3 input-title">
                                <b class="join-header">비밀번호</b>
                            </span>
                            <span class="col-md-9">
                                <input id="user-pw" class="inputBox" type="password" placeholder="비밀번호 입력 (영문, 숫자, 특수문자 혼합 6~15자 입력)" onkeyup="checkPw()"/>
                                <span id="user-pw-msg" class="warn">　</span>
                            </span>
                        </div>

                        <div class="row">
                            <span class="col-md-3 input-title">
                                <b class="join-header">비밀번호 재확인</b>
                            </span>
                            <span class="col-md-9">
                                <input id="user-pw-confirm" class="inputBox" type="password" placeholder="비밀번호 재입력" onkeyup="checkPwConfirm()"/>
                                <span id="user-pw-confirm-msg" class="warn">　</span>
                            </span>
                        </div>

                        <div class="row">
                            <span class="col-md-3 input-title">
                                <b class="join-header">이름</b>
                            </span>
                            <span class="col-md-9">
                                <input id="user-name" class="inputBox" type="text" placeholder="이름 입력" onkeyup="checkName()"/>
                                <span id="user-name-msg" class="warn">　</span>
                            </span>
                        </div>

                        <div class="row">
                            <span class="col-md-3 input-title">
                                <b class="join-header">이메일</b>
                            </span>
                            <span class="col-md-9">
                                <input id="user-email" class="inputBox" type="text" placeholder="이메일 입력" onkeyup="checkEmail()"/>
                                <span id="user-email-msg" class="warn">　</span>
                            </span>
                        </div>
                        <br/>

                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn-custom" onclick="join()">회원가입</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var msg = "${msg}";         // 메시지
		var idCheck = false;        // ID 유효성 여부
		var duplicateCheck = true;  // 중복 여부
        var pwCheck = false;        // 비밀번호 유효성 여부
        var pwConfirmCheck = false; // 비밀번호 확인 유효성 여부
        var nameCheck = false;      // 이름 유효성 여부
        var emailCheck = false;     // 이메일 유효성 여부


        if(msg != "") {
            alert(msg);
            msg = "";
        }


        /* ID 유효성 검사 */
        function checkId() {
            var userId = $("#user-id").val();
            var msg = $("#user-id-msg");
            var idReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/;
            duplicateCheck = true;
            idCheck = false;

            if(userId == "") {
                msg.html("아이디를 입력해주세요.");
                msg.css("color", "red");
            } else if(!idReg.test(userId)){
                msg.html("4~12자리 영문, 숫자 혼합만 가능합니다.");
                msg.css("color", "red");
            } else {
                msg.html("아이디 중복 확인을 해주세요.");
                msg.css("color", "red");
                idCheck = true;
            }
        }


        /* ID 중복 체크 */
        function isDuplicate() {
            if(idCheck == true) {
	            var userId = $("#user-id").val();
	            var msg = $("#user-id-msg");

	            $.ajax({
	                type : "post",
	                url : "./isDuplicate",
	                data : { id : userId },
	                dataType : "json",
	                success : function(data) {
	                    console.log(data);
	                    duplicateCheck = data.isDuplicate;

	                    if(duplicateCheck) {
	                        msg.html("중복된 아이디입니다.");
	                        msg.css("color", "red");
	                        alert("중복된 아이디입니다.");
	                    } else {
	                        msg.html("사용 가능한 아이디입니다.");
	                        msg.css("color", "green");
	                        alert("사용 가능한 아이디입니다.");
	                    }
	                },
	                error : function(error) {
	                    console.log(error);
	                }
	            });
            } else {
				alert("아이디가 올바르지 않습니다. 다시 입력해주세요.");
            }
        }


        /* 비밀번호 유효성 검사 */
        function checkPw(){
            var userPw = $("#user-pw").val();
            var msg = $("#user-pw-msg");
            var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,15}$/;
            pwCheck = false;

            if (userPw == "") {
                msg.html("비밀번호를 입력해주세요.");
                msg.css("color", "red");
            } else if(userPw.length < 6 || userPw.length > 15) {
                msg.html("비밀번호 6~15자리를 입력해주세요.");
                msg.css("color", "red");
            } else if(!pwReg.test(userPw)) {
                msg.html("영문, 숫자, 특수문자를 혼합해 6~15자를 입력해주세요.");
                msg.css("color", "red");
            } else {
                msg.html("사용 가능한 비밀번호입니다.");
                msg.css("color", "green");
                pwCheck = true;
            }
        }


        /* 비밀번호 확인 유효성 검사 */
        function checkPwConfirm(){
            var userPw = $("#user-pw").val();
            var userPwConfirm = $("#user-pw-confirm").val();
            var msg = $("#user-pw-confirm-msg");
            pwConfirmCheck = false;

            if (userPw != userPwConfirm){
                msg.html("비밀번호가 일치하지 않습니다.");
                msg.css("color", "red");
            } else {
                msg.html("비밀번호가 일치합니다.");
                msg.css("color", "green");
                pwConfirmCheck = true;
            }
        }


        /* 이름 유효성 검사 */
        function checkName() {
            var userName = $("#user-name").val();
            var nameReg = /^[가-힣]+$/;
            var msg = $("#user-name-msg");
            nameCheck = false;

            if(userName == "") {
                msg.html("이름을 입력해주세요.");
                msg.css("color", "red");
            } else if(!nameReg.test(userName)) {
                msg.html("이름은 한글만 입력할 수 있습니다.");
                msg.css("color", "red");
            } else if(userName.length < 2 || userName.length > 50) {
                msg.html("2~50자를 입력해주세요.");
                msg.css("color", "red");
            } else {
                msg.html("올바른 이름입니다.");
                msg.css("color", "green");
                nameCheck = true;
            }
        }


        /* 이메일 체크 */
        function checkEmail() {
            var email = $("#user-email").val();
            var msg = $("#user-email-msg");
            var emailReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
            emailCheck = false;

            if(!emailReg.test(email)) {
                msg.html("이메일 형식이 올바르지 않습니다.");
                msg.css("color", "red");
            } else {
                msg.html("올바른 이메일 형식입니다.");
                msg.css("color", "green");
                emailCheck = true;
            }
        }


        /* 회원가입 */
        function join() {
            if(!idCheck) {
                alert("아이디가 올바르지 않습니다.");
                $("#user-id").focus();
            } else if(duplicateCheck) {
                alert("아이디 중복 체크를 해주세요.");
                $("#user-id").focus();
            } else if(!pwCheck) {
                alert("비밀번호가 올바르지 않습니다.");
                $("#user-pw").focus();
            } else if(!pwConfirmCheck) {
                alert("비밀번호 확인이 올바르지 않습니다.");
                $("#user-pw-confirm").focus();
            } else if(!nameCheck) {
                alert("이름이 올바르지 않습니다.");
                $("#user-name").focus();
            } else if(!emailCheck) {
                alert("이메일이 올바르지 않습니다.");
                $("#user-email").focus();
            } else {
                $.ajax({
                    type : "post",
                    url : "./join",
                    data : {
                        id : $("#user-id").val(),
                        pw : $("#user-pw").val(),
                        email : $("#user-email").val(),
                        name : $("#user-name").val()
                    },
                    dataType : "json",
                    success : function(data) {
                        if(data.success > 0){
                            alert("회원가입에 성공했습니다.");
                            location.href="./loginForm";
                        } else {
                            alert("회원가입에 실패했습니다.");
                        }
                    },
                    error : function(error) {
                        console.log(error);
                    }
                });
            }
        }
    </script>
</html>