<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="aws.dto.UserDTO" %>
<%
// 파라메타로 넘어온 id값을 체크
String userID = request.getParameter("id");
if(userID == null || userID.equals(""))
{
	out.println("ERROR");
	return;
}
// DTO를 이용하여, id를 조회
UserDTO dto = new UserDTO();
// ERROR/DUPLICATE/NOT_DUPLICATE
if(dto.CheckID(userID)== true)
{	// id가 중복됨
	out.println("DUPLICATE");
}else
{	// id가 사용가능
	out.println("NOT_DUPLICATE");
}
%>