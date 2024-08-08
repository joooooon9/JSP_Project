<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
String rno = request.getParameter("rno");
String pageno = request.getParameter("page");
if(rno == null || rno.equals(""))
{
	response.sendRedirect("index.jsp");
	return;
}

ReplyDTO dto = new ReplyDTO();
ReplyVO  vo  = dto.Read(rno);

//로그인을 했고, 로그인 회원번호와 댓글 작성자 회원번호가 일치하면
//삭제를 처리한다.
if( login != null && login.getUserno().equals(vo.getRuserno()))
{
	dto.Delete(rno);
}

response.sendRedirect("food_view.jsp?kind=R&page="+ pageno +"&no=" + vo.getBno());
%>
<%@ include file="../include/tail.jsp" %>