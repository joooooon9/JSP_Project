<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
String bno = request.getParameter("no");
if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.Read(bno, false);
//로그인을 했고, 로그인 회원번호와 게시물 작성자 회원번호가 일치하면
//삭제를 처리한다.
if( login != null && login.getUserno().equals(vo.getUserno()))
{
	dto.Delete(bno);
	out.println("글이 삭제되었습니다.");
}else
{
	out.println("글 삭제 권한이 없습니다.");
}
%>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<br>
<%
  String pkind = vo.getBkind();
  String link = "";
  switch(pkind)
  {
  case "F" : 
	  pkind = "자유게시판";
	  link = "../free/free_list.jsp";
	  break;
  case "R" : 
	  pkind = "식품추천게시판";
	  link = "../food/food_list.jsp";
	  break;
  case "S" : 
	  pkind = "나눔게시판";
	  link = "../share/share_list.jsp";
	  break;
  case "I" : 
	  pkind = "이미지갤러리";
	  link = "../imge/imge_list.jsp";
	  break;
  case "Q" : 
	  pkind = "QnA";
	  link = "../qna/qna_list.jsp";
	  break;
  }
%>
<a href="<%= link %>">목록으로 돌아가기</a>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="../include/tail.jsp" %>