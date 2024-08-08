<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="aws.util.*" %>
<%
String kind = request.getParameter("kind");
if(kind == null) kind = "R";
int pageno  = 1;  //현재 페이지 번호
int total   = 0;  //전체 게시물 갯수
int maxpage = 0;  //전체 페이지수
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
    alert("회원만 이용가능한 권한입니다.");
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
  <span style="color: black; font-weight: bold;">▶식품게시판 글목록</span><br><br><br>
  <table border="0" class="" style="margin: auto; width: 1000px; border-spacing: 0px;">
      <tr style="text-align: center; background-color: aqua;">
              <th style="width: 80px;">번호</th>
              <th style="width: 300px;">제목</th>
              <th style="width: 80px;">작성일</th>
              <th style="width: 60px;">작성자</th>
              <th style="width: 60px;">조회수</th>                       
      </tr>
      <%
      //출력 번호 계산 = (전체 갯수) - (페이지번호 - 1) * 10
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
  <p><button type="button" style="width: 95px; height: 30px;" onclick="location.href='food_write.jsp'">글쓰기</button></p>
  <%
  	}else
  	{
  		%>
<p><input type="button" style="width: 95px; height: 30px;" onclick="check()" value="글쓰기"></p> 							              		
  		<% 	
  	}
  %>    	
      	</td>
      </tr>
      	<tr>
		<td style="text-align:center; font-size: 30pt; font-weight: bolder;" colspan="5">
		<%	
		int startBlock = 0; //페이지 시작 블럭 번호
		int endBlock   = 0; //페이지 끝 블럭 번호
		//시작 블럭번호와 끝 블러 번호 계산
		startBlock = ((pageno-1) - ((pageno-1) % 10)) + 1;
		
		endBlock   = startBlock + 10 - 1;
		if(endBlock > maxpage) endBlock = maxpage;
			
		
		if(startBlock > 10)
		{
			%>
			<a href="food_list.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= startBlock - 1 %>">이전</a>
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
			<a href="food_list.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= endBlock + 1 %>">다음</a>
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
                              <option value="">전체</option>
                              <option value="title"<%= tag.equals("title") ? "selected" : "" %>>제목</option>
                              <option value="con"<%= tag.equals("con") ? "selected" : "" %>>내용</option>
                          </select>
                          <input type="text" style="width: 500px; height: 30px; margin: auto;"id="keyword" name="keyword" value="<%= keyword %>">
                          <input type="submit" value="검색" style="height: 34px;">
                      </form>   
                  </td>
              </tr>            
          </table>         
<!-- ----------------------------------------- 하단 카피라이트 인크루드 --------------------------------------------->
<%@ include file="../include/tail.jsp" %>