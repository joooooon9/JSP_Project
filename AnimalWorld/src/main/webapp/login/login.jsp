<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
session.removeAttribute("login");
session.removeAttribute("username");
%>
<script>
window.onload = function()
{
	
	$("#uid").focus();
	$("#login").submit(function(){
		// ���̵� �ԷµǾ��ִ��� Ȯ��
		if($("#uid").val() == "")
		{
			alert("���̵� �Է��ϼ���");
			$("#uid").focus();
			return false;
		}
		// ����� �ԷµǾ��ִ��� Ȯ��
		if($("#upw").val() == "")
		{
			alert("��й�ȣ�� �Է��ϼ���");
			$("#upw").focus();
			return false;
		}
		// �Ѵ� �ԷµǾ������� submit
		return true;
	});
}
</script>
<style>
        #login{
            text-align: center;
        }
        #login input[type=submit]{
            width: 260px; height: 40px; margin-left: 30px;
            background-color: aquamarine;
            font-size: 20px;
        }
</style>
<!-- ������ ��ºκ� -->
                <h3>�� �α���ȭ��</h3><br>
                <form id="login" action="loginok.jsp" method="get">
                    <h2 style="color:deepskyblue;">�α���</h2>
                    ID : <input type="text" style="width: 250px; height: 30px;" maxlength="15" size="20" placeholder="���̵� �Է����ּ���." id="uid" name="uid"><br>
                    PW : <input type="password" style="width: 250px; height: 30px; margin-top: 5px; margin-right: 10px; margin-bottom: 20px;" size="20" placeholder="��й�ȣ�� �Է����ּ���." id="upw" name="upw"><br>
                    <input type="submit" value="�α���"><br>
                    <div style="margin-top: 15px; margin-bottom: 15px; margin-left: 42px;">
                        &nbsp;&nbsp;<a id="find1" href="find_id.jsp">���̵�ã��</a>
                        &nbsp;&nbsp;
                        <a type=submit id="find2" href="find_pw.jsp">��й�ȣã��</a>
                        &nbsp;&nbsp;
                    </div>
                </form>
            </td>
<%@ include file="../include/tail.jsp" %>