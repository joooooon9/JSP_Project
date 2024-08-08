<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("EUC-KR");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String gender = request.getParameter("gender");
String email = request.getParameter("email");

//�Ķ��Ÿ�� �Ѿ�� �������� ��ȿ���� �˻��մϴ�
if( id == null || pw == null || name == null || email == null ||
	id.equals("") || pw.equals("") || name.equals("") || email.equals("") )
{ // �����Ϳ� ������ ������� ���� �������� �ǵ����ϴ�
	response.sendRedirect("join.jsp");
	return;
}

UserDTO dto = new UserDTO();

if(dto.CheckID(id) == true)
{
	response.sendRedirect("join.jsp");
	return;
}

UserVO vo = new UserVO();
vo.setId(id);
vo.setPw(pw);
vo.setName(name);
vo.setGender(gender);
vo.setEmail(email);
if(dto.Join(vo) == false)
{
	%>
	<script>
		alert("ȸ�������� ������ �߻��߽��ϴ�");
		document.location = "join.jsp";
	</script>
	<%
}else
{
	%>
		<script>
		alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
		document.location = "joinOK.jsp";
		</script>
	<%
}
%>

