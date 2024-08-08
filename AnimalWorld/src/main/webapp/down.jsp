<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="aws.vo.*" %>
<%@ page import="aws.dto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>    
<%@ include file="../path.jsp" %> 
<%
BoardDTO dto = new BoardDTO();
BoardVO  vo = dto.Read(request.getParameter("no"),false);
if(vo == null)
{
	//게시물이 없음.
	response.sendRedirect("../home/index.jsp");
	return;
}




//실제 저장된 파일 이름
String filename = uploadPath + "/" + vo.getBpname();
String name = vo.getBfname();
//한글 파일을 encode 처리한다.
name = URLEncoder.encode(name,"utf-8");

response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + name);

//저장된 파일을 브라우저로 보낸다.
out.clear();
File file = new File(filename);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>