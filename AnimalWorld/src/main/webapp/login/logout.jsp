<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
session.removeAttribute("login");
session.removeAttribute("username");
%>
<script>
	alert("로그아웃 되었습니다.")
	document.location = "../home/index.jsp";
</script>