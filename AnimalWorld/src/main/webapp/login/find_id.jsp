<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%

%>
<script>
window.onload = function()
{
	$("#name").focus();
	
	$("#FindID").submit(function(){
		if($("#name").val().trim()== "")
		{
			alert("이름이 입력되지 않았습니다.");
			$("#name").focus();
			return false;
		}
		if($("#email").val().trim()== "")
		{
			alert("이메일이 입력되지 않았습니다.");
			$("#email").focus();
			return false;
		}
	})
}

</script>
<style>
   #FindID{
            text-align: center;
          }
</style>

        <!-- 콘텐츠 출력부분 -->
        <form id="FindID" action="find_idok.jsp" method="post">
            <h3 style="text-align: left;">▶ 아이디찾기</h3>
            <h2 style="color: deepskyblue;">아이디찾기</h2>
            이름 : <input type="text" name="name" id="name" style="width: 250px; height: 30px;" maxlength="7" size="20" placeholder="이름"><br>
            이메일 : <input type="text" name="email" id="email" style="width: 250px; height: 30px; margin-top: 5px; margin-right: 17px; margin-bottom: 20px;" 
                    size="20" placeholder="이메일 주소"><br>
            <input type="submit" value="아이디찾기" style="width: 260px; height: 40px; margin-left: 45px; background-color: aquamarine; font-size: 20px;"><br>
            <div style="margin-top: 15px; margin-bottom: 15px;">
            <a id="find1" href="find_pw.jsp">비밀번호찾기</a>
            &nbsp;&nbsp;
            <a id="find2" href="login.jsp">로그인하기</a>
            &nbsp;&nbsp;
            </div>
        </form>
    </td>
</tr>
 <!--footer 부분-->
<%@ include file="../include/tail.jsp" %>
