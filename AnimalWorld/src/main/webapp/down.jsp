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
	//�Խù��� ����.
	response.sendRedirect("../home/index.jsp");
	return;
}




//���� ����� ���� �̸�
String filename = uploadPath + "/" + vo.getBpname();
String name = vo.getBfname();
//�ѱ� ������ encode ó���Ѵ�.
name = URLEncoder.encode(name,"utf-8");

response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + name);

//����� ������ �������� ������.
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