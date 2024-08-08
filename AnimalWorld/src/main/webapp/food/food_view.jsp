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
	if(confirm("지금 글을 삭제하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "../home/delete.jsp?no=<%= vo.getBno() %>";
}

function Doit()
{
	if($("#rnote").val().trim() == "")
	{
		alert("내용이 입력되지 않았습니다.");
		$("#rnote").focus();
		return false;
	}
	return true;
}

function DeleteReply(rno)
{
	if(confirm("댓글을 삭제하시겠습니까")==false)
	{
		return;	
	}
	document.location = "deletereply.jsp?page="+<%= pageno %>+"&rno=" + rno;
}
</script>
<span style="color: black; font-weight: bold;">▶식품추천게시판 글보기</span><br><br><br>
                <!-- 자유게시판 글보기 부분 -->
                <table border="1" style="margin:auto; width: 1000px; border-collapse : collapse;">
                    <tr>
                        <th style="width: 100px; background-color: aqua;">제목</th>
                        <td>
                            <%= vo.getBtitle() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">작성자</th>
                        <td>
                            <%= vo.getName() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">작성일</th>
                        <td>
                            <%= vo.getBwdate() %>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px; background-color: aqua;">조회수</th>
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
                        <th style="background-color: aqua;">첨부파일</th>
                        <td>						
                 		<%
							if(vo.getBfname() != null)
							{
								%>
								<a style="color: blue;" href="../down.jsp?no=<%= vo.getBno() %>"><%= vo.getBfname() %></a>
								<%
							}else
							{
								%>첨부파일이 없습니다.<%
							}
						%>
                        </td>																		
                    </tr>
                </table>
                <p style="color: red; margin-left: 249px">[ 알림 ] 식품추천 게시판에서 욕설 또는 비방글 등은 사전 경고 없이 관리자에 의하여 삭제 됩니다.</p>              
                <form style="text-align: center; font-size: 30px;">
                        <button type="button" onclick="location.href='food_list.jsp?kind=<%= vo.getBkind() %>&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>'">글목록</button>
                        <%
                        	if(login != null && login.getUserno().equals(vo.getUserno()))
                        	{
                        %>
						<button type="button" onclick="location.href='food_modify.jsp?kind=R&tag=<%= tag %>&keyword=<%= en_keyword %>&page=<%= pageno %>&no=<%= vo.getBno()%>'">글수정</button>
						<button type="button" onclick="javascript:DoDelete();">글삭제</button>
						<%
                        	}
						%>					
                </form>
                <br>
                
            <!-- 댓글 테이블 -->
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
                        <input style="width: 99%; height: 30px; margin: auto" name="rnote" id="rnote" placeholder="댓글을 입력해주세요...">
                    </td>
                    <td width="150px" align="center">
                        <input type="submit" value="작성완료">
                    </td>                 
                </tr>
                <%
	           }else
	           {%>
	        	   <tr>
                   <th style="width: 100px;">회원이름</th>
                   <td>   					
                       <input style="width: 99%; height: 30px; margin: auto" readonly placeholder="회원만 이용가능합니다..">
                   </td>
                   <td width="150px" align="center">
                       <input type="button" value="작성완료" onclick="javascript:alert('로그인 이후 사용가능합니다.')">
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
								 [ <a href="javascript:DeleteReply(<%= r.getRno() %>);">삭제</a> ]</div>
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
        <!-- ----------------------------------------- 하단 카피라이트 인크루드 --------------------------------------------->
  <%@ include file="../include/tail.jsp" %>