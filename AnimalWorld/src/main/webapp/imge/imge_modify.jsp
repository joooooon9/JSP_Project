<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script src="/PJ/res/se2/js/HuskyEZCreator.js" type="text/javascript"></script>
<script src="/PJ/res/se2/init.js" type="text/javascript"></script>
<%
String pageno = request.getParameter("page");
BoardDTO dto = new BoardDTO();
BoardVO vo = dto.Read(request.getParameter("no"), false);
if(vo == null)
{
	//게시물이 없음.
	response.sendRedirect("index.jsp");
	return;
}
//로그인을 했고, 로그인 회원번호와 게시물 작성자 회원번호가 일치하면
if( login == null || !login.getUserno().equals(vo.getUserno()) )
{	// 게시물 변경 권한이 없음.
	response.sendRedirect("index.jsp");
	return;
}
%>
<script>
	window.onload = function()
	{
		$("#title").focus();
	}
	function wsubmit()
	{
		if($("#title").val().trim() == "")
		{
			alert("제목이 입력되지 않았습니다.");
			$("#title").focus();
			return false;
		}
		if($("#content").val().trim() == "<p>&nbsp;</p>")
		{
			alert("내용이 입력되지 않았습니다.");
			$("#content").focus();
			return false;
		}
		var fileVal = $("#attach").val();
		if(fileVal == "")
		{
			alert("첨부파일이 없습니다.");
			$("#attach").focus();
			return false;
		}
	    if( fileVal != "" ){
	        var ext = fileVal.split('.').pop().toLowerCase(); //확장자분리
	        //아래 확장자가 있는지 체크
	        if($.inArray(ext, ['jpg','jpeg','gif','png']) == -1) {
	          alert( "이미지 파일만 업로드 할수 있습니다.");
	          return false;
	        }
	    }
		return true;
	}
	function Subwrite()
	{
		if(confirm("임시저장하시겠습니까?") == false)
			{
				return false;
			}
		$("#saveFlag").val("F");
		$("#imgim").submit();
	}
</script>
<span style="color: black; font-weight: bold;">▶이미지게시판 글수정</span><br><br><br>
<form action="imge_modifyok.jsp" method="post"  enctype="multipart/form-data" id="imgim" onsubmit="return wsubmit();">
<input type="hidden" name="bno" value="<%= vo.getBno() %>">
<input type="hidden" name="page" value="<%= pageno %>">
<input type="hidden" name="tag" value="<%= tag %>">
<input type="hidden" name="keyword" value="<%= keyword %>">
<table border="1" style="margin: auto; width: 1000px;">
    <tr>
        <th style="width: 100px; background-color: aqua;">제목</th>
        <td>
            <input type="text" style="width: 99%; margin: auto;" id="title" name="title" value="<%= vo.getBtitle() %>">
        </td>
    </tr>
    <tr style="text-align: center;  height: 500px;">
        <th style="background-color: aqua;">내용</th>
        <td><textarea style="width: 99%; height: 500px; resize: none;" id="content" name ="content" class="smarteditor2"><%=vo.getBnote() %></textarea></td>
    </tr>
    <tr>
        <th style="background-color: aqua;">첨부파일</th>
        <td>						
            <input name="attach" type="file" style="width:99%"><br>
		<%
			if(vo.getBfname() != null)
			{
			%>	<a href="down.jsp?no=<%= vo.getBno() %>"><%= vo.getBfname() %></a> <%
			}else
			{
				%>첨부파일이 없습니다.<%
			}
		%>
        </td>																		
    </tr>
</table>
<p style="color: red; margin-left: 249px">[ 알림 ] 이미지 게시판에서 욕설 또는 비방글 등은 사전 경고 없이 관리자에 의하여 삭제 됩니다.</p>
	<div style="text-align: center;">
	<!-- input으로 플래그 값을 지정 T:저장 F:임시 -->
		<input type="hidden" value="T" name="saveFlag" id="saveFlag">
	    <input type="submit"  value="수정완료">
	    <input type="submit" class="my_btn" value="임시저장" onclick="Subwrite();">
	    <button type="button" class="my_btn" onclick="location.href= 'imge_view.jsp?kind=I&page=<%= pageno %>&no=<%= vo.getBno()%> '">취소</button>
    </div>
</form>

<!-- ----------------------------------------- 하단 카피라이트 인크루드 --------------------------------------------->
<%@ include file="../include/tail.jsp" %>