<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@page import="java.util.ArrayList"%>
<%
String kind = request.getParameter("kind");
if(kind == null) kind = "";

int pageno  = 1;  //���� ������ ��ȣ
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //��ü ��������
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

BoardDTO dto = new BoardDTO();
total = dto.GetTotal();
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<BoardVO> list = dto.GetList(pageno);
%>
<!-- ������ ��ºκ� -->
<h3>
<p style="text-align:center;" class="font-size">
    <strong style="color: rgb(255, 195, 74);">Animal Worlds</strong>�� ���Ű� ȯ���մϴ�~!<br>
    ����� �ݷ������� �����ִ� ��θ� ���� �������� ����Ʈ�Դϴ�.<br>
    ���� ���ɰ� �̿��Ź�帳�ϴ�~^^<br><br></p>
</h3>
<div class="img_main" style="text-align: center;">
    <img src="../img/main.png" style="width:80%;" alt="�����̹���" ><br>
</div>
<table border="0" style="width: 100%;">
<tr>
    <td>
        <span style="color: black; font-weight: bold; margin-left: 10%;">�ֱٰԽù�</span><br><br> 
        <!-- ���Խ��� ���� ��¥�������� �ֽż� 5�� ��� -->
    </td>
    <table border="0" style="width: 80%; margin-left: auto; margin-right: auto;border-spacing: 0px;">
    <tr>
        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
            �Խ���
        </td>
        <td style="text-align: center; width: 200px; background-color:#00BFFF;">
            ����
        </td>
        <td style="text-align: center; width: 80px; background-color:#00BFFF;">
            �ۼ���
        </td>
        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
            �ۼ���
        </td>
        <td style="text-align: center; width: 50px; background-color:#00BFFF;">
            ��ȸ��
        </td>
    </tr>
<%
    //��� ��ȣ ��� = (��ü ����) - (��������ȣ - 1) * 10
	int seqno = total - (pageno -1 ) * 10;
      
    for(BoardVO item : list)
    {
  	  String pkind = item.getBkind();
  	  String rink = "";
  	  switch(pkind)
  	  {
  	  case "F" : 
  		  pkind = "�����Խ���";
  		  rink = "../free/free_view.jsp";
  		  break;
  	  case "R" : 
  		  pkind = "��ǰ��õ�Խ���";
  		  rink = "../food/food_view.jsp";
  		  break;
  	  case "S" : 
  		  pkind = "�����Խ���";
  		  rink = "../share/share_view.jsp";
  		  break;
  	  case "I" : 
  		  pkind = "�̹���������";
  		  rink = "../imge/imge_view.jsp";
  		  break;
  	  case "Q" : 
  		  pkind = "QnA";
  		  rink = "../qna/qna_view.jsp";
  		  break;
  	  }
%>
	<tr style="background-color:#f4f4f4;">
		<td style="text-align: center;"><%= pkind %></td>										
		<td style="text-align: left;">
		<a href="<%= rink %>?kind=<%= item.getBkind() %>&page=<%= pageno %>&no=<%=item.getBno()%>"><%= item.getBtitle() %></a>
		<% if(!item.getRcount().equals("0"))
		{
		%><span style="color: orange;">(<%= item.getRcount() %>)</span>
		<%
		}
		%>
		</td>
		<td style="text-align: center;"><%= item.getName() %></td>
		<td style="text-align: center;"><%= item.getBwdate() %></td>
		<td style="text-align: center;"><%= item.getBhit() %></td>					
	</tr>
	<%
	}
	%>
	</table><br>
</tr>
</td>
<!--footer �κ�-->
<%@ include file="../include/tail.jsp" %>