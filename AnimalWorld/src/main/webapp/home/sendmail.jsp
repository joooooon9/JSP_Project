<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="aws.mail.*" %>
<%
String mail = request.getParameter("mail");
if(mail == null)
{
	out.print("올바른 메일주소가 아닙니다.");
	return;
}
SendMail sender = new SendMail();

//인증코드를 얻는다.
String code = sender.AuthCode(5);

sender.setFrom("@naver.com");
sender.setTo(mail);
sender.setAccount("id", "pw");

sender.setMail("회원가입 인증코드입니다.", "인증코드 : " + code);
if( sender.sendMail() == true )
{
	session.setAttribute("code", code);
	out.println("메일을 발송하였습니다.");
}else
{
	out.println("메일 발송에 실패하였습니다.");
}
%>