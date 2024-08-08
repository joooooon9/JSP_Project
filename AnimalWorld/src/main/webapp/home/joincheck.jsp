<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("EUC-KR");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String gender = request.getParameter("gender");
String email = request.getParameter("email");

//파라메타로 넘어온 데이터의 유효성을 검사합니다
if( id == null || pw == null || name == null || email == null ||
	id.equals("") || pw.equals("") || name.equals("") || email.equals("") )
{ // 데이터에 문제가 있을경우 가입 페이지로 되돌립니다
	response.sendRedirect("join.jsp");
	return;
}

UserDTO dto = new UserDTO();

if(dto.CheckID(id) == true)
{
	response.sendRedirect("join.jsp");
	return;
}

UserVO vo = new UserVO();
vo.setId(id);
vo.setPw(pw);
vo.setName(name);
vo.setGender(gender);
vo.setEmail(email);
if(dto.Join(vo) == false)
{
	%>
	<script>
		alert("회원가입중 오류가 발생했습니다");
		document.location = "join.jsp";
	</script>
	<%
}else
{
	%>
		<script>
		alert("회원가입이 완료되었습니다");
		document.location = "joinOK.jsp";
		</script>
	<%
}
%>

