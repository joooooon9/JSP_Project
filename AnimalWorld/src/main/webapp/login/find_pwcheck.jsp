<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
String id = request.getParameter("id");

UserVO vo = new UserVO();
UserDTO dto = new UserDTO();

vo = dto.FindPW(id);

if(vo == null)
{
	%>
	<script>
		alert("��ġ�ϴ� ȸ�������� �����ϴ�.");
		document.location = "../login/find_pw.jsp";
	</script>
	
	<%
	return;
}
%>
<script type="text/javascript">
function DoCheck()
{
	if( $("#uid").val() == "")
	{
		alert("���̵� �Է����ּ���.");
		$("#uid").focus();
		return;
	}
	if( $("#uname").val() == "")
	{
		alert("�̸��� �Է����ּ���.");
		$("#uname").focus();
		return;
	}
	if( $("#mail").val() == "")
	{
		alert("���� �ּҸ� �Է����ּ���.");
		$("#mail").focus();
		return;
	}
	console.log($("#uname").val());
	$.ajax({
		type    : "post",
		url     : "checkmail.jsp",
		data 	: {
			'name':$("#uname").val(),
			'id': $("#uid").val(),
			'mail' : $("#mail").val()
			},		
		dataType: "html",
		contentType: 'application/x-www-form-urlencoded;charset=euc-kr',
		success : function(result) 
		{
			result = result.trim();
			alert(result);
		}			
	});
}
function CodeCheck()
{
	$.ajax({
		type : "get",
		url: "checkcode.jsp",
		dataType: "html",
		success : function(result) 
		{
			result = result.trim();
			if($("#code").val() == result)
			{
				$("#findpw").submit();		
			}
			else if($("#code").val() == "")
			{
				alert("�����ڵ尡 �Էµ��� �ʾҽ��ϴ�.");
				$("#code").focus();
			}
			else
			{
				alert("�����ڵ尡 �ùٸ��� �ʽ��ϴ�.");
				$("#code").focus();
			}
		}			
	});	
}
</script>
       <!-- ������ ��ºκ� -->
       <h3>�� ��й�ȣã��2</h3><br>
       <form action="find_newpw.jsp" method="get" id="findpw">
       <table border="0" id="bor_" style="margin-left: auto; margin-right: auto;">
           <tr>
               <td colspan="2">
                   <h4 style="margin: auto;">�̸�, �̸����ּ� Ȯ�� �� �̸��Ϸ� ������ȣ�� �߼۵˴ϴ�.</h4>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   ���̵� &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                   <input type="text" maxlength="10" size="20" placeholder="���̵�" style="background-color: plum" readonly value="<%=vo.getId() %>" name="id" id="uid"><br>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   �̸� &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                   <input type="text" maxlength="10" size="20" placeholder="�̸�" style="background-color: plum" name="name" id="uname"><br>
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   �̸����ּ� &nbsp;&nbsp;: &nbsp; 
               </td>
               <td>
                   <input type="text" maxlength="30" size="20" placeholder="�̸����ּ�" style="background-color: plum;" name="mail" id="mail"> <input type="button" onclick="DoCheck();" value="�����ڵ� �߼�">
               </td>
           </tr>
           <tr>
               <td style="text-align: right;">
                   �����ڵ�Ȯ�� &nbsp;&nbsp;: &nbsp;
               </td>
               <td>
                    <input type="text" maxlength="8" size="20" placeholder="�����ڵ带 �Է����ּ���." style="background-color: plum;" id="code" name="code">
               </td>
           </tr>
           <tr>
               <td colspan="2" style="text-align: center;">
                   <button type="button" onclick="location.href='find_pw.jsp'" style="width: 100px; height: 40px; margin: auto;
                   background-color: aquamarine; font-size: 20px;">����</button>
                   <input type="button" onclick="CodeCheck();" style="width: 100px; height: 40px; margin: auto;
                   background-color: aquamarine; font-size: 20px;" value="����"><br>
                </td>  
            </tr>
        </table>
       </form>
    </td>
</tr>
<!--footer �κ�-->
<%@ include file="../include/tail.jsp" %>