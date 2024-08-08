<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("EUC-KR");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
UserVO vo = new UserVO();
UserDTO dto = new UserDTO();

vo.setId(id);
vo.setPw(pw);
if(name != null)
{
	vo.setName(name);
}
if(dto.ChangePW(vo) == false)
{
	%>
	<script>
		alert("비밀번호 변경오류입니다.");
	</script>
	<%
}else
{
	session.removeAttribute("login");
	session.removeAttribute("username");
	%>
	<script>
		document.location = "login.jsp";
	</script>
	<%
}
%>