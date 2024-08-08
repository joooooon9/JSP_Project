<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@page import="java.util.ArrayList"%>
<%
String kind = request.getParameter("kind");
String userno = login.getUserno();

int pageno  = 1;  //현재 페이지 번호
int total   = 0;  //전체 게시물 갯수
int maxpage = 0;  //전체 페이지수
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

BoardDTO dto = new BoardDTO();
total = dto.MyTotal(userno);
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<BoardVO> list = dto.MyList(pageno,userno,"T",tag,keyword);
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
                <div class="submenu"><a href="../home/my_page.jsp">내 정보</a></div>
                <div class="submenu"><a href="../home/my_write.jsp">나의 게시물</a></div>
                <div style="height:2px; background-color:#ffffff;"></div>
                <div class="submenu"><a href="../home/my_coment.jsp">나의 댓글</a></div>
                <div class="submenu"><a href="../home/my_subwrite.jsp">임시저장한 글</a></div>
            </td>
            <td style="width:5px; background-color: #fc6e51;"></td>
            <td>
<table border="0" style="width: 100%;">
                    <tr>
                        <td>
                            <span style="color: black; font-weight: bold;">▶ 나의 게시물</span><br><br>
                        </td>
                    </tr>
                </table>
                <table border="0" style="width: 100%; ">
                    <tr>
                        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
                            구분
                        </td>
                        <td style="text-align: center; width: 200px; background-color:#00BFFF;">
                            제목
                        </td>
                        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
                            작성일
                        </td>
                        <td style="text-align: center; width: 50px; background-color:#00BFFF;">
                            조회수
                        </td>
                    </tr>
      <%
    //출력 번호 계산 = (전체 갯수) - (페이지번호 - 1) * 10
		int seqno = total - (pageno -1 ) * 10;
      for(BoardVO item : list)
      {
      %>
      <tr style="background-color:#f4f4f4;">
          
          <td style="text-align: center;">
                    <% 
                    String kindname = "";
                    String link = "";
			        String bkind = item.getBkind();
                    switch(bkind)
                    {
                    case "F":
                    	kindname = "자유게시판";
                    	link = "../free/free_view.jsp";
                    	break;
                    case "R":
                    	kindname = "식품추천 게시판";
                    	link = "../food/food_view.jsp";
                    	break;
                    case "S":
                    	kindname = "나눔 게시판";
                    	link = "../share/share_view.jsp";
                    	break;
                    case "I":
                    	kindname = "이미지갤러리";
                    	link = "../imge/imge_view.jsp";
                    	break;
                    case "Q":
                    	kindname = "QnA 게시판";
                    	link = "..qna/qna_view.jsp";
                    	break;
                    }
			    %>
          <%= kindname %></td>							
          <td style="text-align: left;">
          <a href="<%= link %>?kind=<%= bkind %>&page=<%= pageno %>&no=<%=item.getBno()%>"><%= item.getBtitle() %></a>
          <% if(!item.getRcount().equals("0"))
          {
        	  %><span style="color: orange;">(<%= item.getRcount() %>)</span>
        	  <%
          }
       	  %>
          </td>
          <td style="text-align: center;"><%= item.getBwdate() %></td>										
          <td style="text-align: center;"><%= item.getBhit() %></td>					
      </tr>
      <%
      }
      %>
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
			<a href="my_write.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= startBlock - 1 %>">이전</a>
			<%		
		}
		for(int p = startBlock; p <= endBlock; p++)
		{
			String css = "";
			if(p == pageno) css = "now";
			%>
			<a class="<%= css %>" href="my_write.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= p %>"><%= p %></a>
			<%
		}
		if(endBlock != maxpage)
		{
			%>
			<a href="my_write.jsp?tag=<%= tag %>&keyword=<%=en_keyword %>&kind=<%= kind %>&page=<%= endBlock + 1 %>">다음</a>
			<%
		}	
		%>
		</td>
	</tr>
  </table>
  <table  border="0" class="pull-right" style="margin-left:auto;margin-right:auto; width: 1200px;">
      <tr>
          <td>
              <form method="get" name="search" action="my_write.jsp" style="text-align: center;" accept-charset="utf-8">
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
<%@ include file="../include/tail.jsp" %>