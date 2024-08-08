<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="aws.dto.UserDTO"%>
<%@page import="aws.vo.UserVO"%>
<%@ page import="aws.mail.*" %>
<%
//request.setCharacterEncoding("euc-kr");

String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("mail");

System.out.println(name);

UserVO vo = new UserVO();
UserDTO dto = new UserDTO();
vo = dto.FindPW(id, email, name);
if(vo == null)
{
	%>
	아이디또는 이메일이 잘못된 정보입니다.
	<%
	return;
}
SendMail sender = new SendMail();

//인증코드를 얻는다.
String code = sender.AuthCode(5);

sender.setFrom("cnrhcjs10@naver.com");
sender.setTo("cnrhcjs10@naver.com");
sender.setAccount("cnrhcjs10", "1124rhcjs@");

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