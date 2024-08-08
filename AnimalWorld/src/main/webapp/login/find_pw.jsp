<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>
window.onload = function()
{
	$("#uid").focus();
	
	$("#FindID").submit(function(){
		if($("#uid").val().trim()== "")
		{
			alert("id가 입력되지 않았습니다.");
			$("#uid").focus();
			return false;
		}
	})
}
</script>
<style>
	#FindID {
            text-align: center;
        	}
   #FindID input {
	       width: 250px; 
	       height: 30px; 
	       line-height:30px;
	       margin-bottom: 20px;
	       background-color: plum;
       		 }
</style>

        <!-- 콘텐츠 출력부분 -->
        <form id="FindID" action="find_pwcheck.jsp" method="get">
            <h3 style="text-align: left;">▶ 비밀번호찾기1</h3><br>
            <h4 style="margin: auto;">비밀번호를 찾기 위한 애니멀월드ID를 입력해주세요.</h4>
            애니멀월드ID : <input type="text" name="id" id="uid" maxlength="30" size="30" placeholder="애니멀월드ID"><br>
            <input type="submit" value="다음" style="width: 100px; height: 40px; margin: auto;
            background-color: aquamarine; font-size: 20px;"><br>
        </form>
    </td>
</tr>
<!--footer 부분-->
<%@ include file="../include/tail.jsp" %>