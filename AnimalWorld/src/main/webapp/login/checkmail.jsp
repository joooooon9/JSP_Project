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
	���̵�Ǵ� �̸����� �߸��� �����Դϴ�.
	<%
	return;
}
SendMail sender = new SendMail();

//�����ڵ带 ��´�.
String code = sender.AuthCode(5);

sender.setFrom("cnrhcjs10@naver.com");
sender.setTo("cnrhcjs10@naver.com");
sender.setAccount("cnrhcjs10", "1124rhcjs@");

sender.setMail("ȸ������ �����ڵ��Դϴ�.", "�����ڵ� : " + code);
if( sender.sendMail() == true )
{
	session.setAttribute("code", code);
	out.println("������ �߼��Ͽ����ϴ�.");
}else
{
	out.println("���� �߼ۿ� �����Ͽ����ϴ�.");
}
%>