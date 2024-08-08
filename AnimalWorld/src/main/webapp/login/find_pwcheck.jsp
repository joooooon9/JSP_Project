<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
String id = request.getParameter("id");

UserVO vo = new UserVO();
UserDTO dto = new UserDTO();

vo = dto.FindPW(id);

if(vo == null)
{
	%>
	<script>
		alert("일치하는 회원정보가 없습니다.");
		document.location = "../login/find_pw.jsp";
	</script>
	
	<%
	return;
}
%>
<script type="text/javascript">
function DoCheck()
{
	if( $("#uid").val() == "")
	{
		alert("아이디를 입력해주세요.");
		$("#uid").focus();
		return;
	}
	if( $("#uname").val() == "")
	{
		alert("이름을 입력해주세요.");
		$("#uname").focus();
		return;
	}
	if( $("#mail").val() == "")
	{
		alert("메일 주소를 입력해주세요.");
		$("#mail").focus();
		return;
	}
	console.log($("#uname").val());
	$.ajax({
		type    : "post",
		url     : "checkmail.jsp",
		data 	: {
			'name':$("#uname").val(),
			'id': $("#uid").val(),
			'mail' : $("#mail").val()
			},		
		dataType: "html",
		contentType: 'application/x-www-form-urlencoded;charset=euc-kr',
		success : function(result) 
		{
			result = result.trim();
			alert(result);
		}			
	});
}
function CodeCheck()
{
	$.ajax({
		type : "get",
		url: "checkcode.jsp",
		dataType: "html",
		success : function(result) 
		{
			result = result.trim();
			if($("#code").val() == result)
			{
				$("#findpw").submit();		
			}
			else if($("#code").val() == "")
			{
				alert("인증코드가 입력되지 않았습니다.");
				$("#code").focus();
			}
			else
			{
				alert("인증코드가 올바르지 않습니다.");
				$("#code").focus();
			}
		}			
	});	
}
</script>
       <!-- 콘텐츠 출력부분 -->
       <h3>▶ 비밀번호찾기2</h3><br>
       <form action="find_newpw.jsp" method="get" id="findpw">
       <table border="0" id="bor_" style="margin-left: auto; margin-right: auto;">
           <tr>
               <td colspan="2">
                   <h4 style="margin: auto;">이름, 이메일주소 확인 후 이메일로 인증번호가 발송됩니다.</h4>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   아이디 &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                   <input type="text" maxlength="10" size="20" placeholder="아이디" style="background-color: plum" readonly value="<%=vo.getId() %>" name="id" id="uid"><br>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   이름 &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                   <input type="text" maxlength="10" size="20" placeholder="이름" style="background-color: plum" name="name" id="uname"><br>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   이메일주소 &nbsp;&nbsp;: &nbsp; 
               </td>
               <td>
                   <input type="text" maxlength="30" size="20" placeholder="이메일주소" style="background-color: plum;" name="mail" id="mail"> <input type="button" onclick="DoCheck();" value="인증코드 발송">
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   인증코드확인 &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                    <input type="text" maxlength="8" size="20" placeholder="인증코드를 입력해주세요." style="background-color: plum;" id="code" name="code">
               </td>
           </tr>
           <tr>
               <td colspan="2" style="text-align: center;">
                   <button type="button" onclick="location.href='find_pw.jsp'" style="width: 100px; height: 40px; margin: auto;
                   background-color: aquamarine; font-size: 20px;">이전</button>
                   <input type="button" onclick="CodeCheck();" style="width: 100px; height: 40px; margin: auto;
                   background-color: aquamarine; font-size: 20px;" value="다음"><br>
                </td>  
            </tr>
        </table>
       </form>
    </td>
</tr>
<!--footer 부분-->
<%@ include file="../include/tail.jsp" %>