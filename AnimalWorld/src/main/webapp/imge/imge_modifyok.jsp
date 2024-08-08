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

MultipartRequest multi = new MultipartRequest(request,uploadPath,size, "EUC-KR",new DefaultFileRenamePolicy());

String pageno	  = multi.getParameter("page");
String bno	  = multi.getParameter("bno");
String btitle = multi.getParameter("title");
String bkind  = multi.getParameter("kind");
String bnote  = multi.getParameter("content");
String saveflag = multi.getParameter("saveFlag");
String thead = multi.getParameter("thead");
String keywordh = multi.getParameter("keyword");
String tagh = multi.getParameter("tag");

String en_key = URLEncoder.encode(keywordh, "utf-8");
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
//���� �Խù��� ÷�������� ���� �ִ��� Ȯ��
BoardDTO dto = new BoardDTO();
BoardVO oriVo = dto.Read(bno, false);
//System.out.println("���� ���� �̸� : " + oriVo.getBfname()); //System.out.println("oriVo.getBfname() ���� : " + oriVo.getBfname().getClass().getName());
//������ ÷�������� �ְ�, ���� �ø� ÷�������� ������ -> ���� ������ ����
if(oriVo.getBfname() != null && filename == null)
{
	filename = oriVo.getBfname();
	savename = oriVo.getBpname();
}
//�����͸� DB�� �����Ѵ�.
BoardVO vo = new BoardVO();
vo.setUserno(login.getUserno());
vo.setBno(bno);
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

dto.Update(vo);
//view.jsp �� ������.
response.sendRedirect("../imge/imge_view.jsp?kind=I&tag="+tagh+"&keyword="+ en_key +"&page="+ pageno +"&no=" + vo.getBno());

%>
<%@ include file="../include/tail.jsp" %>