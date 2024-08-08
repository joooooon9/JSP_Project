<%@ include file="../include/head.jsp" %>
<%

request.setCharacterEncoding("EUC-KR");

String bno = request.getParameter("bno");
String ruserno = request.getParameter("ruserno");
String rnote = request.getParameter("rnote");
String pageno = request.getParameter("page");
ReplyDTO dto = new ReplyDTO();
ReplyVO vo = new ReplyVO();

vo.setBno(bno);
vo.setRuserno(ruserno);
vo.setRnote(rnote);

dto.Insert(vo);

response.sendRedirect("food_view.jsp?kind=R&page="+ pageno +"&no="+bno);
%>