<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String uploadPath = request.getSession().getServletContext().getRealPath("/upload");

/*  String uploadPath = "";
switch(uploadPath)
{
case "1" :
	uploadPath = "D:\\CGC\\Project\\Animalworld\\upload";
	break;
case "2" :
	uploadPath = "Çö¿õ¾¾ Æú´õ °æ·Î";
	break;
default:
	uploadPath = "D:\\JJ\\TeamPJ\\AnimalWorld\\upload";
	break;
} */

out.println(uploadPath);
%>