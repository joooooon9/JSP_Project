<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
String bno = request.getParameter("no");
if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.Read(bno, false);
//�α����� �߰�, �α��� ȸ����ȣ�� �Խù� �ۼ��� ȸ����ȣ�� ��ġ�ϸ�
//������ ó���Ѵ�.
if( login != null && login.getUserno().equals(vo.getUserno()))
{
	dto.Delete(bno);
	out.println("���� �����Ǿ����ϴ�.");
}else
{
	out.println("�� ���� ������ �����ϴ�.");
}
%>
<!-- ������ ��� �Ǵ°� -------------------------- -->
<br>
<%
  String pkind = vo.getBkind();
  String link = "";
  switch(pkind)
  {
  case "F" : 
	  pkind = "�����Խ���";
	  link = "../free/free_list.jsp";
	  break;
  case "R" : 
	  pkind = "��ǰ��õ�Խ���";
	  link = "../food/food_list.jsp";
	  break;
  case "S" : 
	  pkind = "�����Խ���";
	  link = "../share/share_list.jsp";
	  break;
  case "I" : 
	  pkind = "�̹���������";
	  link = "../imge/imge_list.jsp";
	  break;
  case "Q" : 
	  pkind = "QnA";
	  link = "../qna/qna_list.jsp";
	  break;
  }
%>
<a href="<%= link %>">������� ���ư���</a>
<!-- ������ ��� �Ǵ°� -------------------------- -->
<%@ include file="../include/tail.jsp" %>