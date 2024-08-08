<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
session.removeAttribute("login");
session.removeAttribute("username");
%>
<script>
window.onload = function()
{
	
	$("#uid").focus();
	$("#login").submit(function(){
		// 아이디가 입력되어있는지 확인
		if($("#uid").val() == "")
		{
			alert("아이디를 입력하세요");
			$("#uid").focus();
			return false;
		}
		// 비번이 입력되어있는지 확인
		if($("#upw").val() == "")
		{
			alert("비밀번호를 입력하세요");
			$("#upw").focus();
			return false;
		}
		// 둘다 입력되어있으면 submit
		return true;
	});
}
</script>
<style>
        #login{
            text-align: center;
        }
        #login input[type=submit]{
            width: 260px; height: 40px; margin-left: 30px;
            background-color: aquamarine;
            font-size: 20px;
        }
</style>
<!-- 콘텐츠 출력부분 -->
                <h3>▶ 로그인화면</h3><br>
                <form id="login" action="loginok.jsp" method="get">
                    <h2 style="color:deepskyblue;">로그인</h2>
                    ID : <input type="text" style="width: 250px; height: 30px;" maxlength="15" size="20" placeholder="아이디를 입력해주세요." id="uid" name="uid"><br>
                    PW : <input type="password" style="width: 250px; height: 30px; margin-top: 5px; margin-right: 10px; margin-bottom: 20px;" size="20" placeholder="비밀번호를 입력해주세요." id="upw" name="upw"><br>
                    <input type="submit" value="로그인"><br>
                    <div style="margin-top: 15px; margin-bottom: 15px; margin-left: 42px;">
                        &nbsp;&nbsp;<a id="find1" href="find_id.jsp">아이디찾기</a>
                        &nbsp;&nbsp;
                        <a type=submit id="find2" href="find_pw.jsp">비밀번호찾기</a>
                        &nbsp;&nbsp;
                    </div>
                </form>
            </td>
<%@ include file="../include/tail.jsp" %>