<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%

%>
<script>
window.onload = function()
{
	$("#name").focus();
	
	$("#FindID").submit(function(){
		if($("#name").val().trim()== "")
		{
			alert("�̸��� �Էµ��� �ʾҽ��ϴ�.");
			$("#name").focus();
			return false;
		}
		if($("#email").val().trim()== "")
		{
			alert("�̸����� �Էµ��� �ʾҽ��ϴ�.");
			$("#email").focus();
			return false;
		}
	})
}

</script>
<style>
   #FindID{
            text-align: center;
          }
</style>

        <!-- ������ ��ºκ� -->
        <form id="FindID" action="find_idok.jsp" method="post">
            <h3 style="text-align: left;">�� ���̵�ã��</h3>
            <h2 style="color: deepskyblue;">���̵�ã��</h2>
            �̸� : <input type="text" name="name" id="name" style="width: 250px; height: 30px;" maxlength="7" size="20" placeholder="�̸�"><br>
            �̸��� : <input type="text" name="email" id="email" style="width: 250px; height: 30px; margin-top: 5px; margin-right: 17px; margin-bottom: 20px;" 
                    size="20" placeholder="�̸��� �ּ�"><br>
            <input type="submit" value="���̵�ã��" style="width: 260px; height: 40px; margin-left: 45px; background-color: aquamarine; font-size: 20px;"><br>
            <div style="margin-top: 15px; margin-bottom: 15px;">
            <a id="find1" href="find_pw.jsp">��й�ȣã��</a>
            &nbsp;&nbsp;
            <a id="find2" href="login.jsp">�α����ϱ�</a>
            &nbsp;&nbsp;
            </div>
        </form>
    </td>
</tr>
 <!--footer �κ�-->
<%@ include file="../include/tail.jsp" %>
