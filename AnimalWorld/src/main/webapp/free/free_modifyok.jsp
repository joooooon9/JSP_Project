<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="../path.jsp" %>
<%

//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,size, "EUC-KR",new DefaultFileRenamePolicy());

String pageno	  = multi.getParameter("page");
String bno	  = multi.getParameter("bno");
String btitle = multi.getParameter("title");
String bkind  = multi.getParameter("kind");
String bnote  = multi.getParameter("content");
String saveflag = multi.getParameter("saveFlag");
String tagh = multi.getParameter("tag");
String keywordh = multi.getParameter("keyword");

String en_key = URLEncoder.encode(keywordh, "utf-8");
//업로드한 파일 이름을 얻는다.
String filename = (String)multi.getFilesystemName("attach");
String savename = "";
if(filename != null)
{
	//랜덤한 문자열을 생성한다.
	savename = UUID.randomUUID().toString();
	
	//원래 업로드한 파일이름을 랜덤한 문자열 파일이름으로 변경한다.
	String source_name = uploadPath + "/" + filename;
	String target_name = uploadPath + "/" + savename;
	File srcFile    = new File(source_name);
	File targetFile = new File(target_name);
	srcFile.renameTo(targetFile);
}
//기존 게시물이 첨부파일을 갖고 있는지 확인
BoardDTO dto = new BoardDTO();
BoardVO oriVo = dto.Read(bno, false);
//System.out.println("기존 파일 이름 : " + oriVo.getBfname()); //System.out.println("oriVo.getBfname() 정보 : " + oriVo.getBfname().getClass().getName());
//기존에 첨부파일이 있고, 새로 올린 첨부파일이 없으면 -> 기존 파일을 유지
if(oriVo.getBfname() != null && filename == null)
{
	filename = oriVo.getBfname();
	savename = oriVo.getBpname();
}
//데이터를 DB에 저장한다.
BoardVO vo = new BoardVO();
vo.setUserno(login.getUserno());
vo.setBno(bno);
vo.setBtitle(btitle);
vo.setBkind(bkind);
vo.setBnote(bnote);
vo.setSaveflag(saveflag);
if( filename != null )
{
	vo.setBfname(filename);
	vo.setBpname(savename);
}

dto.Update(vo);
//free_view.jsp 로 보낸다.
response.sendRedirect("../free/free_view.jsp?kind=F&tag=" + tagh + "&keyword=" + en_key + "&page=" + pageno + "&no=" + vo.getBno());

%>
<%@ include file="../include/tail.jsp" %>