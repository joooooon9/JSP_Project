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
	//�Խù��� ����.
	response.sendRedirect("index.jsp");
	return;
}
//�α����� �߰�, �α��� ȸ����ȣ�� �Խù� �ۼ��� ȸ����ȣ�� ��ġ�ϸ�
if( login == null || !login.getUserno().equals(vo.getUserno()) )
{	// �Խù� ���� ������ ����.
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
			alert("������ �Էµ��� �ʾҽ��ϴ�.");
			$("#title").focus();
			return false;
		}
		if($("#content").val().trim() == "<p>&nbsp;</p>")
		{
			alert("������ �Էµ��� �ʾҽ��ϴ�.");
			$("#content").focus();
			return false;
		}
		var fileVal = $("#attach").val();
		if(fileVal == "")
		{
			alert("÷�������� �����ϴ�.");
			$("#attach").focus();
			return false;
		}
	    if( fileVal != "" ){
	        var ext = fileVal.split('.').pop().toLowerCase(); //Ȯ���ںи�
	        //�Ʒ� Ȯ���ڰ� �ִ��� üũ
	        if($.inArray(ext, ['jpg','jpeg','gif','png']) == -1) {
	          alert( "�̹��� ���ϸ� ���ε� �Ҽ� �ֽ��ϴ�.");
	          return false;
	        }
	    }
		return true;
	}
	function Subwrite()
	{
		if(confirm("�ӽ������Ͻðڽ��ϱ�?") == false)
			{
				return false;
			}
		$("#saveFlag").val("F");
		$("#imgim").submit();
	}
</script>
<span style="color: black; font-weight: bold;">���̹����Խ��� �ۼ���</span><br><br><br>
<form action="imge_modifyok.jsp" method="post"  enctype="multipart/form-data" id="imgim" onsubmit="return wsubmit();">
<input type="hidden" name="bno" value="<%= vo.getBno() %>">
<input type="hidden" name="page" value="<%= pageno %>">
<input type="hidden" name="tag" value="<%= tag %>">
<input type="hidden" name="keyword" value="<%= keyword %>">
<table border="1" style="margin: auto; width: 1000px;">
    <tr>
        <th style="width: 100px; background-color: aqua;">����</th>
        <td>
            <input type="text" style="width: 99%; margin: auto;" id="title" name="title" value="<%= vo.getBtitle() %>">
        </td>
    </tr>
    <tr style="text-align: center;  height: 500px;">
        <th style="background-color: aqua;">����</th>
        <td><textarea style="width: 99%; height: 500px; resize: none;" id="content" name ="content" class="smarteditor2"><%=vo.getBnote() %></textarea></td>
    </tr>
    <tr>
        <th style="background-color: aqua;">÷������</th>
        <td>						
            <input name="attach" type="file" style="width:99%"><br>
		<%
			if(vo.getBfname() != null)
			{
			%>	<a href="down.jsp?no=<%= vo.getBno() %>"><%= vo.getBfname() %></a> <%
			}else
			{
				%>÷�������� �����ϴ�.<%
			}
		%>
        </td>																		
    </tr>
</table>
<p style="color: red; margin-left: 249px">[ �˸� ] �̹��� �Խ��ǿ��� �弳 �Ǵ� ���� ���� ���� ��� ���� �����ڿ� ���Ͽ� ���� �˴ϴ�.</p>
	<div style="text-align: center;">
	<!-- input���� �÷��� ���� ���� T:���� F:�ӽ� -->
		<input type="hidden" value="T" name="saveFlag" id="saveFlag">
	    <input type="submit"  value="�����Ϸ�">
	    <input type="submit" class="my_btn" value="�ӽ�����" onclick="Subwrite();">
	    <button type="button" class="my_btn" onclick="location.href= 'imge_view.jsp?kind=I&page=<%= pageno %>&no=<%= vo.getBno()%> '">���</button>
    </div>
</form>

<!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
<%@ include file="../include/tail.jsp" %>