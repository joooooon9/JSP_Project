<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="aws.util.*" %>
<%
String kind = "";
int pageno  = 1;  //���� ������ ��ȣ
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //��ü ��������
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

BoardDTO dto = new BoardDTO();
total = dto.GetTotal(kind,kwd,tag);
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<BoardVO> list = dto.GetList(pageno,kind,kwd,tag);
String en_keyword = URLEncoder.encode(kwd, "utf-8");
%>
<script type="text/javascript">
window.onload = function()
{

}
function check(){
    alert("ȸ���� �̿밡���� �����Դϴ�.");
    document.location = "../login/login.jsp";
    return;
}
</script>
<style>
.now
{
	font-weight: bold;
	color: red !important;
}
</style>
  <span style="color: black; font-weight: bold;">�����հ˻� �۸��</span><br><br><br>
  <table border="0" class="" style="margin: auto; width: 1000px; border-spacing: 0px;">
      <tr style="text-align: center; background-color: aqua;">
              <th style="width: 80px;">��ȣ</th>
              <th style="width: 120px;">����</th>
              <th style="width: 300px;">����</th>
              <th style="width: 80px;">�ۼ���</th>
              <th style="width: 60px;">�ۼ���</th>
              <th style="width: 60px;">��ȸ��</th>                       
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
    	  String btitle = item.getBtitle();
    	  btitle = btitle.replace(kwd,"<span style='color:#ff6600'>" + kwd + "</span>");
      %>
      <tr style="background-color:#f4f4f4;">
          <td style="text-align: center;"><%= seqno-- %></td>										
          <td style="text-align: center;"><%= pkind %></td>
          <td style="text-align: left;">
          <a href="<%= rink %>?no=<%=item.getBno()%>"><%= btitle %></a>
          <% if(!item.getRcount().equals("0"))
          {
        	  %><span style="color: orange;">(<%= item.getRcount() %>)</span>
        	  <%
          }
       	  %>
          </td>
          <td style="text-align: center;"><%= item.getBwdate() %></td>
          <td style="text-align: center;"><%= item.getName() %></td>										
          <td style="text-align: center;"><%= item.getBhit() %></td>					
      </tr>
      <%
      }
      %>
      	<tr>
		<td style="text-align:center; font-size: 30pt; font-weight: bolder;" colspan="5">
		<%	
		int startBlock = 0; //������ ���� �� ��ȣ
		int endBlock   = 0; //������ �� �� ��ȣ
		//���� ����ȣ�� �� �� ��ȣ ���
		startBlock = ((pageno-1) - ((pageno-1) % 10)) + 1;
		
		endBlock   = startBlock + 10 - 1;
		if(endBlock > maxpage) endBlock = maxpage;
			
		
		if(startBlock > 10)
		{
			%>
			<a href="search_list.jsp?tag=<%= tag %>&kwd=<%=en_keyword %>&kind=<%= kind %>&page=<%= startBlock - 1 %>">����</a>
			<%		
		}
		for(int p = startBlock; p <= endBlock; p++)
		{
			String css = "";
			if(p == pageno) css = "now";
			%>
			<a class="<%= css %>" href="search_list.jsp?tag=<%= tag %>&kwd=<%=en_keyword %>&kind=<%= kind %>&page=<%= p %>"><%= p %></a>
			<%
		}
		if(endBlock != maxpage)
		{
			%>
			<a href="search_list.jsp?tag=<%= tag %>&kwd=<%=en_keyword %>&kind=<%= kind %>&page=<%= endBlock + 1 %>">����</a>
			<%
		}	
		%>
		</td>
	</tr>
  </table>       
<!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
<%@ include file="../include/tail.jsp" %>