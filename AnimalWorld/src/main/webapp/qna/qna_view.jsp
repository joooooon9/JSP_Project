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
<span style="color: black; font-weight: bold;">��QnA�Խ��� �ۺ���</span><br><br><br>
                <!-- �����Խ��� �ۺ��� �κ� -->
                <table border="1" style="margin:auto; width: 1000px; border-collapse : collapse;">
                    <tr>
                        <th style="width: 100px; background-color: aqua;">����</th>
                        <td>
                            <% 
						        String thead = vo.getThead();
						        String color = "black";  // �⺻ ����
						        if (thead.equals("�亯���")) {
						            color = "blue";
						        } else{
						            color = "red";
						        }
						    %>
            			<span style="color: <%= color %>;">[<%= thead %>]</span><%= vo.getBtitle() %>
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
                <p style="color: red; margin-left: 249px">[ �˸� ] QnA �Խ��ǿ��� �弳 �Ǵ� ���� ���� ���� ��� ���� �����ڿ� ���Ͽ� ���� �˴ϴ�.</p>              
                <form style="text-align: center; font-size: 30px;">
                        <button type="button" onclick="location.href='qna_list.jsp?kind=<%= vo.getBkind() %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>'">�۸��</button>
                        <%
                        	if(login != null && login.getUserno().equals(vo.getUserno()))
                        	{
                        %>
						<button type="button" onclick="location.href='qna_modify.jsp?kind=Q&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>&no=<%= vo.getBno()%>'">�ۼ���</button>
						<button type="button" onclick="javascript:DoDelete();">�ۻ���</button>
						<%
                        	}
						%>					
                </form>
                <br>
                
            <!-- ��� ���̺� -->
            <form action="replyok.jsp" method="post" id="reply" name="reply" onsubmit="return Doit();">
            <table border="1" style="margin: auto; width: 1000px; border-collapse : collapse;">
             <% if(login != null)
	           {
            	%>
                <tr>
                    <th style="width: 100px; background-color: darkgray;">�ۼ���</th>
                    <td style="background-color: darkgray; font-weight: bold; text-align: center;">
                        ����
                    </td>
                    <td style="background-color: darkgray; width: 100px; text-align: center; font-weight: bold;">
                        �亯����
                    </td>                 
                </tr>
                <tr>
                    <td style="text-align: center;"><%=login.getName() %></td>
                    <input type="hidden" name="page" value="<%= pageno %>">
	            	<input type="hidden" name="bno" value="<%= vo.getBno() %>">
	            	<input type="hidden" name="ruserno" value="<%= login.getUserno() %>">
                    <td style=""><textarea  style="resize: none; width: 99%; height: 80px; margin: auto" name="rnote" id="rnote" placeholder="�亯�� �Է����ּ���..."></textarea></td>
                    <td style="text-align: center;"><input type="submit" value="�亯�ϱ�"></td>
                </tr>
                <%
	           }else
	           {%>
	           <tr>
                    <th style="width: 100px;">ȸ���̸�</th>
                    <td style=""><textarea style="resize: none; width: 99%; height: 80px;" readonly placeholder="ȸ���� �̿밡���մϴ�.."></textarea></td>
                    <td style="text-align: center;">
                    <input type="button" value="�亯�ϱ�" onclick="javascript:alert('�α��� ���� ��밡���մϴ�.')">
                    </td>
                </tr>
                <%
                }
                ReplyDTO rdto = new ReplyDTO();
            	ArrayList<ReplyVO> list = rdto.GetList(vo.getBno());
            	for( ReplyVO r : list)
            	{
                %>
                <tr style="height: 80px">
                    <td style="text-align: center;"><%= r.getName() %></td>
                    <td><%= r.getHTML() %>
                    	<%
						if(login != null && login.getUserno().equals(r.getRuserno()))
						{
							%>
							[ <a href="javascript:DeleteReply(<%= r.getRno() %>);">����</a> ]
							<%
						}
				        %>
			        </td>
                    <td style="text-align: center;"><%= r.getRwdate() %></td>
                </tr>
                <%
            	}
                %>
            </table>
            </form><br>
            
            
        <!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
  <%@ include file="../include/tail.jsp" %>