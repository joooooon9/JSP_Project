<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="../path.jsp" %>
<%

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;

MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"euc-kr",new DefaultFileRenamePolicy());

String btitle = multi.getParameter("title");
String bkind  = multi.getParameter("kind");
String bnote  = multi.getParameter("content");
String saveflag = multi.getParameter("saveFlag");
String thead = multi.getParameter("thead");

//���ε��� ���� �̸��� ��´�.
String filename = (String)multi.getFilesystemName("attach");
String savename = "";
if(filename != null)
{
	//������ ���ڿ��� �����Ѵ�.
	savename = UUID.randomUUID().toString();
	
	//���� ���ε��� �����̸��� ������ ���ڿ� �����̸����� �����Ѵ�.
	String source_name = uploadPath + "/" + filename;
	String target_name = uploadPath + "/" + savename;
	File srcFile    = new File(source_name);
	File targetFile = new File(target_name);
	srcFile.renameTo(targetFile);
}


//�����͸� DB�� �����Ѵ�.
BoardDTO dto = new BoardDTO();
BoardVO vo = new BoardVO();
vo.setUserno(login.getUserno());
vo.setBtitle(btitle);
vo.setBkind(bkind);
vo.setBnote(bnote);
vo.setSaveflag(saveflag);
vo.setThead(thead);
if( filename != null )
{
	vo.setBfname(filename);
	vo.setBpname(savename);
}

dto.Insert(vo);

//list.jsp �� ������.
response.sendRedirect("../qna/qna_view.jsp?no=" + vo.getBno());

%>
<%@ include file="../include/tail.jsp" %>