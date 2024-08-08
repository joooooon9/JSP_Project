<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="aws.util.*" %>
<%@page import="java.util.ArrayList"%>
<%
String kind = request.getParameter("kind");
if(kind == null) kind = "I";

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
#imt
{
 border-radius: 12px; 
}
#td {
border-top-left-radius: 20px; border-top-right-radius: 20px;
border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;
}
#tname{
	display: inline-block;
	max-width: 150px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	vertical-align: middle;
}
</style>
              <!-- ������ ��ºκ�-->
              <table border="0" style="width: 100%;">
                  <tr>
                      <td>
                          <span style="color: black; font-weight: bold;">�� �̹���������</span><br><br><br>
                      </td>
                  </tr>
              </table>
              
              <table border="0" class="image-table" style="margin-left: auto; margin-right: auto; ">
                  <tr>
                       <%
					    //��� ��ȣ ��� = (��ü ����) - (��������ȣ - 1) * 10
						int seqno = total - (pageno -1 ) * 10;
					    int count = 0;
					    for(BoardVO item : list)
					    {
					    	count++;
				       %>
                      <td>
                          <table border="0" style="margin:10px 10px; width: 200px; height: 300px" id="imt" >
                              <tr>
                                  <td style="background-color: #00BFFF; text-align: center; width: 200px; height: 30px;" id="td">
                                  <div id="tname">
                                  <%= item.getBtitle() %>
                                  </div>
                                  </td>
                              </tr>
                              <tr>
                              
                                  <td id="td">                                  
                                  <a href="imge_view.jsp?kind=<%= kind %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>&no=<%=item.getBno()%>">
                                  	<img src="../down.jsp?no=<%= item.getBno() %>" width="200px" height="200px" id="td"> 
                                  	</a>
                                  </td>
                                  
                              </tr>
                              <tr>
                                  <td style="text-align: center; background-color: orange;"id="td"><%= item.getName() %></td>
                              </tr>
                              <tr>
                                  <td style="text-align: center; background-color: silver;"id="td"><%= item.getBwdate() %></td>
                              </tr>
                          </table>
                      </td>
                          <%
                          	if(count%5==0){
                          		%>
                          		</tr><tr>
                          		<%
                          	}
					      }
					      %>
                  </tr>
                  <tr>
		      	<td colspan="5" style="text-align: right; height: 60px;">
  			<%
  	if(login != null)
  	{
  %>
  <p><button type="button" style="width: 95px; height: 30px;" onclick="location.href='imge_write.jsp'">�۾���</button></p>
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
			<a href="imge_list.jsp?kind=<%= kind %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= startBlock - 1 %>">����</a>
			<%		
		}
		for(int p = startBlock; p <= endBlock; p++)
		{
			String css = "";
			if(p == pageno) css = "now";
			%>
			<a class="<%= css %>" href="imge_list.jsp?kind=<%= kind %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= p %>"><%= p %></a>
			<%
		}
		if(endBlock != maxpage)
		{
			%>
			<a href="imge_list.jsp?kind=<%= kind %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= endBlock + 1 %>">����</a>
			<%
		}	
		%>
		</td>
	</tr>
  </table>
  
     <table  border="0" class="pull-right" style="margin-left:auto;margin-right:auto; width: 1200px;">
       <tr>
           <td>
               <form method="get" name="search" action="imge_list.jsp" style="text-align: center;" accept-charset="utf-8">
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
                  <!--footer �κ�-->

<%@ include file="../include/tail.jsp" %>