<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.ArrayList"%>    
<%@ include file="../include/head.jsp" %>
<%
String kind = request.getParameter("kind");
String ruserno = login.getUserno();

int pageno  = 1;  //���� ������ ��ȣ
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //��ü ��������
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

ReplyDTO dto = new ReplyDTO();

total = dto.MyTotal(ruserno);
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<ReplyVO> Rlist = dto.MyList(pageno,ruserno);

String en_keyword = URLEncoder.encode(keyword, "utf-8");
%>
<style>
.now
{
	font-weight: bold;
	color: red !important;
}
</style>
<table border="0" style="width: 100%;">
            <td  valign="top" style="text-align: center; width: 200px;">
                <div class="submenu"><a href="../home/my_page.jsp">�� ����</a></div>
                <div class="submenu"><a href="../home/my_write.jsp">���� �Խù�</a></div>
                <div style="height:2px; background-color:#ffffff;"></div>
                <div class="submenu"><a href="../home/my_coment.jsp">���� ���</a></div>
                <div class="submenu"><a href="../home/my_subwrite.jsp">�ӽ������� ��</a></div>
            </td>
            <td style="width:5px; background-color: #fc6e51;"></td>
            <td>
                <!-- ������ ��ºκ�-->
<table border="0" style="width: 100%;">
                    <tr>
                        <td>
                            <span style="color: black; font-weight: bold;">�� ���� ���</span><br><br>
                        </td>
                    </tr>
                </table>
                <table border="0" style="width: 100%; ">
                    <tr>

                        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
                            ����
                        </td>
                        <td style="text-align: center; width: 200px; background-color:#00BFFF;">
                            ����
                        </td>
                        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
                            �ۼ���
                        </td>
                    </tr>
                    
      <%
    //��� ��ȣ ��� = (��ü ����) - (��������ȣ - 1) * 10
		int seqno = total - (pageno -1 ) * 10;
      for(ReplyVO item : Rlist)
      {
    	  
      %>
             <tr style="background-color:#f4f4f4;">
                                 <% 
                    String kindname = "";
                    String link = "";
			        String bkind = item.getKind();
                    switch(bkind)
                    {
                    case "F":
                    	kindname = "�����Խ���";
                    	link = "../free/free_view.jsp";
                    	break;
                    case "R":
                    	kindname = "��ǰ��õ �Խ���";
                    	link = "../food/food_view.jsp";
                    	break;
                    case "S":
                    	kindname = "���� �Խ���";
                    	link = "../share/share_view.jsp";
                    	break;
                    case "I":
                    	kindname = "�̹���������";
                    	link = "../imge/imge_view.jsp";
                    	break;
                    case "Q":
                    	kindname = "QnA �Խ���";
                    	link = "../qna/qna_view.jsp";
                    	break;
                    }
			    %>
           <td style="text-align: center;"><%= kindname %></td>
           <td style="text-align: left;"><a style="color: blue;" href="<%= link %>?kind=<%= bkind %>&page=<%= pageno %>&no=<%=item.getBno()%>"><%= item.getRnote() %></a>
           </td>
           <td style="text-align: center;"><%= item.getRwdate() %></td>
           <%
	  }
      %>                       
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
			<a href="my_coment.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= startBlock - 1 %>">����</a>
			<%		
		}
		for(int p = startBlock; p <= endBlock; p++)
		{
			String css = "";
			if(p == pageno) css = "now";
			%>
			<a class="<%= css %>" href="my_coment.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= p %>"><%= p %></a>
			<%
		}
		if(endBlock != maxpage)
		{
			%>
			<a href="my_coment.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= endBlock + 1 %>">����</a>
			<%
		}	
		%>
		</td>
	</tr>
         </table>
                <%@ include file="../include/tail.jsp" %>