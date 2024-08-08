<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="aws.util.*" %>
<%
String kind = request.getParameter("kind");
if(kind == null) kind = "R";
int pageno  = 1;  //���� ������ ��ȣ
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //��ü ��������
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

BoardDTO dto = new BoardDTO();
total = dto.GetTotal(kind,keyword,tag);
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<BoardVO> list = dto.GetList(pageno,kind,keyword,tag);
String en_keyword = URLEncoder.encode(keyword, "utf-8");
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
  <span style="color: black; font-weight: bold;">����ǰ�Խ��� �۸��</span><br><br><br>
  <table border="0" class="" style="margin: auto; width: 1000px; border-spacing: 0px;">
      <tr style="text-align: center; background-color: aqua;">
              <th style="width: 80px;">��ȣ</th>
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
      %>
      <tr style="background-color:#f4f4f4;">
          <td style="text-align: center;"><%= seqno-- %></td>										
          <td style="text-align: left;">
          <a href="food_view.jsp?kind=<%= kind %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>&no=<%=item.getBno()%>"><%= item.getBtitle() %></a>
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
      	<td colspan="5" style="text-align: right; height: 60px;">
  			<%
  	if(login != null)
  	{
  %>
  <p><button type="button" style="width: 95px; height: 30px;" onclick="location.href='food_write.jsp'">�۾���</button></p>
  <%
  	}else
  	{
  		%>
<p><input type="button" style="width: 95px; height: 30px;" onclick="check()" value="�۾���"></p> 							              		
  		<% 	
  	}
  %>    	
      	</td>
      </tr>
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
			<a href="food_list.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= startBlock - 1 %>">����</a>
			<%		
		}
		for(int p = startBlock; p <= endBlock; p++)
		{
			String css = "";
			if(p == pageno) css = "now";
			%>
			<a class="<%= css %>" href="food_list.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= p %>"><%= p %></a>
			<%
		}
		if(endBlock != maxpage)
		{
			%>
			<a href="food_list.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= endBlock + 1 %>">����</a>
			<%
		}	
		%>
		</td>
	</tr>
  </table>
          <table  border="0" class="pull-right" style="margin-left:auto;margin-right:auto; width: 1200px;">
              <tr>
                  <td>
                      <form method="get" name="search" action="food_list.jsp" style="text-align: center;" accept-charset="utf-8">
                          <select class="tag" name="tag" id="tag" style="height: 34px;">
                              <option value="">��ü</option>
                              <option value="title"<%= tag.equals("title") ? "selected" : "" %>>����</option>
                              <option value="con"<%= tag.equals("con") ? "selected" : "" %>>����</option>
                          </select>
                          <input type="text" style="width: 500px; height: 30px; margin: auto;"id="keyword" name="keyword" value="<%= keyword %>">
                          <input type="submit" value="�˻�" style="height: 34px;">
                      </form>   
                  </td>
              </tr>            
          </table>         
<!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
<%@ include file="../include/tail.jsp" %>