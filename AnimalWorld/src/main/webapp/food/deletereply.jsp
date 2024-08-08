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

//�α����� �߰�, �α��� ȸ����ȣ�� ��� �ۼ��� ȸ����ȣ�� ��ġ�ϸ�
//������ ó���Ѵ�.
if( login != null && login.getUserno().equals(vo.getRuserno()))
{
	dto.Delete(rno);
}

response.sendRedirect("food_view.jsp?kind=R&page="+ pageno +"&no=" + vo.getBno());
%>
<%@ include file="../include/tail.jsp" %>