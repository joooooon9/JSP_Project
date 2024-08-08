<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
BoardDTO dto = new BoardDTO();
BoardVO vo = dto.Read(request.getParameter("no"), true);
String pageno = request.getParameter("page");
if(vo == null)
{
	response.sendRedirect("../home/index.jsp");
	return;
}
String en_keyword = URLEncoder.encode(keyword, "utf-8");
%>
<script>
function DoDelete()
{
	if(confirm("���� ���� �����Ͻðڽ��ϱ�?") == false)
	{
		return;	
	}
	document.location = "../home/delete.jsp?no=<%= vo.getBno() %>";
}

function Doit()
{
	if($("#rnote").val().trim() == "")
	{
		alert("������ �Էµ��� �ʾҽ��ϴ�.");
		$("#rnote").focus();
		return false;
	}
	return true;
}

function DeleteReply(rno)
{
	if(confirm("����� �����Ͻðڽ��ϱ�")==false)
	{
		return;	
	}
	document.location = "deletereply.jsp?page="+<%= pageno %>+"&rno=" + rno;
}
</script>
<span style="color: black; font-weight: bold;">����ǰ��õ�Խ��� �ۺ���</span><br><br><br>
                <!-- �����Խ��� �ۺ��� �κ� -->
                <table border="1" style="margin:auto; width: 1000px; border-collapse : collapse;">
                    <tr>
                        <th style="width: 100px; background-color: aqua;">����</th>
                        <td>
                            <%= vo.getBtitle() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">�ۼ���</th>
                        <td>
                            <%= vo.getName() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">�ۼ���</th>
                        <td>
                            <%= vo.getBwdate() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">��ȸ��</th>
                        <td>
                            <%= vo.getBhit() %>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;" colspan="2">
                        <%= vo.getBnote() %><br>
                        <%
							if(vo.getBfname() != null)
							{
								%>
								<img src="../down.jsp?no=<%= vo.getBno() %>" style="width: 60%;" >
								<%
							}else
							{
								%><%
							}
						%>
                        </td>
                    </tr>
                    <tr>
                        <th style="background-color: aqua;">÷������</th>
                        <td>						
                 		<%
							if(vo.getBfname() != null)
							{
								%>
								<a style="color: blue;" href="../down.jsp?no=<%= vo.getBno() %>"><%= vo.getBfname() %></a>
								<%
							}else
							{
								%>÷�������� �����ϴ�.<%
							}
						%>
                        </td>																		
                    </tr>
                </table>
                <p style="color: red; margin-left: 249px">[ �˸� ] ��ǰ��õ �Խ��ǿ��� �弳 �Ǵ� ���� ���� ���� ��� ���� �����ڿ� ���Ͽ� ���� �˴ϴ�.</p>              
                <form style="text-align: center; font-size: 30px;">
                        <button type="button" onclick="location.href='food_list.jsp?kind=<%= vo.getBkind() %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>'">�۸��</button>
                        <%
                        	if(login != null && login.getUserno().equals(vo.getUserno()))
                        	{
                        %>
						<button type="button" onclick="location.href='food_modify.jsp?kind=R&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>&no=<%= vo.getBno()%>'">�ۼ���</button>
						<button type="button" onclick="javascript:DoDelete();">�ۻ���</button>
						<%
                        	}
						%>					
                </form>
                <br>
                
            <!-- ��� ���̺� -->
            <form action="replyok.jsp" method="post" id="reply" name="reply" onsubmit="return Doit();">
            <table border="1" style="margin: auto; width: 1000px; border-collapse : collapse;">
            <% if(login !=null)
	           {
            	%>
                <tr>
                    <th style="width: 100px;"><%=login.getName() %></th>
                    <td>
                    	<input type="hidden" name="page" value="<%= pageno %>">
                    	<input type="hidden" name="bno" value="<%= vo.getBno() %>">
						<input type="hidden" name="ruserno" value="<%= login.getUserno() %>">
                        <input style="width: 99%; height: 30px; margin: auto" name="rnote" id="rnote" placeholder="����� �Է����ּ���...">
                    </td>
                    <td width="150px" align="center">
                        <input type="submit" value="�ۼ��Ϸ�">
                    </td>                 
                </tr>
                <%
	           }else
	           {%>
	        	   <tr>
                   <th style="width: 100px;">ȸ���̸�</th>
                   <td>   					
                       <input style="width: 99%; height: 30px; margin: auto" readonly placeholder="ȸ���� �̿밡���մϴ�..">
                   </td>
                   <td width="150px" align="center">
                       <input type="button" value="�ۼ��Ϸ�" onclick="javascript:alert('�α��� ���� ��밡���մϴ�.')">
                   </td>                 
               </tr>
               <%
	           }
            	ReplyDTO rdto = new ReplyDTO();
            	ArrayList<ReplyVO> list = rdto.GetList(vo.getBno());
            	for( ReplyVO r : list)
            	{
                %>
                <tr>
                    <th style="width: 100px;"><%= r.getName() %></th>
                    <td>
                        <div style="width: 85%; height: 30px; margin-left: 15px"><%= r.getRnote() %>
                        <%
							if(login != null && login.getUserno().equals(r.getRuserno()))
							{
								%>
								 [ <a href="javascript:DeleteReply(<%= r.getRno() %>);">����</a> ]</div>
								 <%
							}
						%>
                    </td>                 
                    <td  width="150px" align="center"><%= r.getRwdate() %></td>
                </tr>
                <%
            	}
                %>
            </table>
            </form>
        <!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
  <%@ include file="../include/tail.jsp" %>