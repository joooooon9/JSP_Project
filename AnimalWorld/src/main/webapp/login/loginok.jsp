<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>session.removeAttribute
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("uid");
String pw = request.getParameter("upw");

if(id == null || pw == null || id.equals("") || pw.equals(""))
{
	response.sendRedirect("login.jsp");
	return;
}
UserVO vo = new UserVO();
UserDTO dto = new UserDTO();

vo = dto.Login(id, pw);
if(vo == null)
{
	%>
	<script>
		alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		document.location = "login.jsp";
	</script>
	<%
}else
{
	System.out.println(vo.getName());
	
	session.setAttribute("login", vo);
	session.setAttribute("username", vo.getName());
	
	response.sendRedirect("../home/index.jsp");
}
%>