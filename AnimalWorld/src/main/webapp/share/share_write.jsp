<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
                <!-- --------------------------------------- ���� ��ܺκ� ��ũ��� -------------------------------------------------->
<script src="/PJ/res/se2/js/HuskyEZCreator.js" type="text/javascript"></script>
<script src="/PJ/res/se2/init.js" type="text/javascript"></script>
<script type="text/javascript">
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
        if ($("select[name='thead'] option:selected").val() == "���Ӹ�") {
            alert("���Ӹ��� �������ּ���.");
            $("#thead").focus();
            return false;
        }
		return true;
	}
	function subwrite()
	{
		if(confirm("�ӽ������Ͻðڽ��ϱ�?") == false)
			{
				return false;
			}
		$("#saveFlag").val("F");
		$("form").submit();
	}
</script>
                <span style="color: black; font-weight: bold;">�������Խ��� ���ۼ�</span><br><br><br>
                <form action="share_writeok.jsp" method="post" enctype="multipart/form-data" onsubmit="return wsubmit();">
                <!-- bkind = F>�����Խ���, R>��ǰ��õ, S>�����Խ���, I>�̹��������� Q>qna�Խ��� -->
                <input type="hidden" name="kind" id="kind" value="S">
                <table border="1" style="margin: auto; width: 1000px;">
                    <tr>
                        <th style="width: 100px; background-color: aqua;">����</th>
                        <td>
                            <input type="text" style="width: 85%; margin: auto;" name="title" id="title">
                <select name="thead" id="thead">
                    <option value="���Ӹ�" selected disabled>���Ӹ�����</option>
                    <option value="������">������</option>
                    <option value="������">������</option>
                    <option value="�����Ϸ�">�����Ϸ�</option>
                </select>
                        </td>
                    </tr>
                    <tr style="text-align: center;  height: 500px;">
                        <th style="background-color: aqua;">����</th>
                        <td><textarea style="width: 99%; height: 500px; resize: none;" id="content" name="content" class="smarteditor2"></textarea></td>
                    </tr>
                    <tr>
                        <th style="background-color: aqua;">÷������</th>
                        <td>						
                            <input type="file" style="width: 99%;" id="attach" name="attach">
                        </td>																		
                    </tr>
                </table>
                <p style="color: red; margin-left: 249px">[ �˸� ] �����Խ��ǿ��� �弳 �Ǵ� ���� ���� ���� ��� ���� �����ڿ� ���Ͽ� ���� �˴ϴ�.</p>
         
				    <div style="text-align: center; margin-top: 20px;">
				        <!-- input���� �÷��� ���� ���� T:���� F:�ӽ� -->
				        <input type="hidden" value="T" name="saveFlag" id="saveFlag">
				        <input type="submit" value="�ۼ��Ϸ�">
				        <button type="button" onclick="javascript:subwrite()">�ӽ�����</button>				       
				        <button type="button" class="my_btn" onclick="location.href='share_list.jsp'">���ư���</button><br>
				    </div>                 
                </form>
<!-- ----------------------------------------- �ϴ� ī�Ƕ���Ʈ ��ũ��� --------------------------------------------->
<%@ include file="../include/tail.jsp" %>