<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
session.removeAttribute("login");
session.removeAttribute("username");
%>
<script>
	alert("�α׾ƿ� �Ǿ����ϴ�.")
	document.location = "../home/index.jsp";
</script>