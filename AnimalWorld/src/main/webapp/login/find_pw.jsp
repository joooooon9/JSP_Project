<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>
window.onload = function()
{
	$("#uid").focus();
	
	$("#FindID").submit(function(){
		if($("#uid").val().trim()== "")
		{
			alert("id�� �Էµ��� �ʾҽ��ϴ�.");
			$("#uid").focus();
			return false;
		}
	})
}
</script>
<style>
	#FindID {
            text-align: center;
        	}
   #FindID input {
	       width: 250px; 
	       height: 30px; 
	       line-height:30px;
	       margin-bottom: 20px;
	       background-color: plum;
       		 }
</style>

        <!-- ������ ��ºκ� -->
        <form id="FindID" action="find_pwcheck.jsp" method="get">
            <h3 style="text-align: left;">�� ��й�ȣã��1</h3><br>
            <h4 style="margin: auto;">��й�ȣ�� ã�� ���� �ִϸֿ���ID�� �Է����ּ���.</h4>
            �ִϸֿ���ID : <input type="text" name="id" id="uid" maxlength="30" size="30" placeholder="�ִϸֿ���ID"><br>
            <input type="submit" value="����" style="width: 100px; height: 40px; margin: auto;
            background-color: aquamarine; font-size: 20px;"><br>
        </form>
    </td>
</tr>
<!--footer �κ�-->
<%@ include file="../include/tail.jsp" %>