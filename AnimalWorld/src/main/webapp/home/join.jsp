<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>
// id �ߺ��˻� ����� ��Ƴ��� �÷��� ����


// id �Է��� ������, ajax�� �̿��Ͽ�, DBMS�� ������ id�� �����ϴ��� �˻�
window.onload = function(){
	
	$("#uID").focus();
	
	// id �Է�â�� ����ڰ� �Է°��� ������ �̺�Ʈ �����ʸ� ���� �Է°��� üũ
	$("input[name='id']").keyup(function(){
		CheckID();
	});
}

//ȸ������ ó��
function DoJoin()
{
	// id �Է°��� ������ �޼��� ����ϰ� submit ����
	if($("#uID").val() == "")
	{
		alert("���̵� �Է��ϼ���");
		$("#uID").focus();
		return;
	}
	// pw �Է°��� ������ ����
	if($("#pw").val() == "")
	{
		alert("����� �Է��ϼ���");
		$("#pw").focus();
		return;
	}
	// pwc �Է°��� ������ ����
	if($("#pwc").val() == "")
	{
		alert("���Ȯ���� �Է��ϼ���");
		$("#pwc").focus();
		return;
	}
	// pw �Է°��� �ִµ�, pwc �Է°��� �ٸ��� ����
	if($("#pw").val() != $("#pwc").val())
	{
		alert("����� ���Ȯ���� ��ġ���� �ʽ��ϴ�");
		$("#pwc").val("");
		$("#pwc").focus();
		return;
	}
	
	// �̸� �Է°��� ������ ����
	if($("#uName").val() == "")
	{
		alert("�̸��� �Է��ϼ���");
		$("#uName").focus();
		return;
	}
	// id�� �ߺ��̰ų�, �ߺ��˻簡 ERROR�̸� ����
	if(checkCode == "ERROR")
	{
		alert("ID�ߺ��˻� ���������Դϴ�");
		$("#uID").val("");
		$("#uID").focus();
		return;
	}
	if(checkCode == "DUPLICATE")
	{
		alert("�ߺ��� ID�Դϴ�. ȸ�������� ������ �� �����ϴ�");
		$("#uID").val("");
		$("#uID").focus();
		return;
	}
	
	if($("#mail").val() == "")
	{
		alert("�����ּҸ� �Է��ϼ���.");
		$("#mail").focus();
		return;
	}	
	if($("#code").val() == "")
	{
		alert("�����ڵ带 �Է��ϼ���.");
		$("#code").focus();
		return;
	}
	
	$.ajax({
		type : "get",
		url: "getcode.jsp",
		dataType: "html",
		success : function(result) 
		{
			result = result.trim();
			if($("#code").val() == result)
			{
				if(confirm("ȸ�������� �����Ͻðڽ��ϱ�?") == 1)
				{
					$("#join").submit();
				}					
			}else
			{
				alert("�����ڵ尡 ��ġ���� �ʽ��ϴ�.");
				$("#code").focus();
			}
		}			
	});			
}

function CheckID()
{
	// �ߺ��˻� ����� �ʱ�ȭ
	checkCode = "ERROR";
	// �޼��� �ڽ��� �ʱ�ȭ
	$("#msg_box").html("");
	// �Է°��� ������ �Է°��� �ֵ��� �޼��� ���
	if($("#uID").val() == "") { $("#msg_box").html("���̵� �Էµ��� �ʾҽ��ϴ�"); }
	// �Է°��� 4���� �̻��̸� id�ߺ� üũ ajax ȣ��
	if($("#uID").val().length > 3 )
	{
		$.ajax({	// ajax ������� DBMS�� id ��ȸ�� ��û
			url			: "idcheck.jsp?id=" + $("#uID").val(),
			type		: "get",
			dataType	: "html",
			success		: function(response){
				response = response.trim();
				console.log(response);
				// ajax�� ���� ��� �ڵ带 �÷��� ������ �ֽ��ϴ�
				checkCode = response;
				switch(response)
				{
				case "ERROR" :
					$("#msg_box").html("�ߺ��˻� ������ �߻��߽��ϴ�");
					break;
				case "DUPLICATE" :
					$("#msg_box").html("�ߺ��� ���̵��Դϴ�");
					break;
				case "NOT_DUPLICATE" :
					$("#msg_box").html("��� ������ ���̵��Դϴ�");
					break;
				}
			}
		});
	}else
	{
		$("#msg_box").html("4���� �̻� �Է����ּ���");					
	}
}

function SendMail()
{
	if( $("#email").val() == "")
	{
		alert("���� �ּҸ� �Է��ϼ���.");
		$("#email").focus();
		return;
	}
	$.ajax({
		type    : "get",
		url     : "sendmail.jsp?mail=" + $("#email").val(),
		dataType: "html",
		success : function(result) 
		{
			result = result.trim();
			alert(result);
		}			
	});
}
</script>
<form name="join" id="join" method="post" action="joincheck.jsp">
                    <table border="0" style="width: 100%; margin-left: 10%;">
                        <tr>
                            <td>
                                <span style="color: black; font-weight: bold;">�� ȸ������</span><br><br><br>
                            </td>
                        </tr>
                    </table>
                    <table border="1" style="margin-left: auto; margin-right: auto;">
                        <tr>
                            <td>���̵�(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" id="uID" name="id"><br>
                                <span id="msg_box" style="color: red; font-weight: bold;">���̵� �Է��ϼ���</span>
                            </td>
                        </tr>
                        <tr>
                            <td>��й�ȣ(*)</td>
                            <td><input type="password" style="text-align: left; width: 50%;" name="pw" id="pw"></td>
                        </tr>
                        <tr>
                            <td>��й�ȣȮ��(*)</td>
                            <td><input type="password" style="text-align: left; width: 50%;" name="pwc" id="pwc"></td>
                        </tr>
                        <tr>
                            <td>�̸�(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" name="name" id="uName"></td>
                        </tr>
                        <tr>
                            <td>����(*)</td>
                            <td>
                                <input type="radio" name="gender" value="M" checked>����
                                <input type="radio" name="gender" value="F">����
                            </td>
                        </tr>
                        <tr>
                            <td>�̸���(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" name = "email" id="email"> &nbsp;&nbsp;&nbsp;&nbsp; 
                            <input type="button" onclick="SendMail();" value="�����ϱ�">
                            </td>
                        </tr>
                        <tr>
                            
                            <td colspan="2"><input type="text" style="text-align: left; width: 50%;" placeholder="������ȣ�� �Է����ּ���" name="code" id="code"> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <input type="button" onclick="DoJoin();" value="���ԿϷ�">&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="reset" value="���">
                            </td>							
                        </tr>
                    </table>
                    <br>
                </form>
<%@ include file="../include/tail.jsp" %>