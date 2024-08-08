<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
	request.setCharacterEncoding("EUC-KR");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	if(name == null || email == null || name.equals("") || email.equals(""))
	{
		response.sendRedirect("find_id.jsp");
		return;
	}
	UserVO vo = new UserVO();
	UserDTO dto = new UserDTO();
	vo = dto.FindID(name, email);
	if(vo == null)
	{
		%>
		<script>
			alert("��ġ�ϴ� ȸ�������� �����ϴ�.");
			document.location = "../login/find_id.jsp";
		</script>
		
		<%
		return;
	}
%>
       <!-- ������ ��ºκ� -->
       
       <table border="0" style="margin-left:auto;margin-right:auto; width: 100%;">
           <tr>
               <td style="font-size: 20px; font-weight: bolder;">�� ���̵�ã����</td>
           </tr>
       </table>
       <form action="find_newpw.jsp" method="post">
       <input type="hidden" name="id" id="uid" value="<%=vo.getId() %>">
       <table border="1" style="margin-left:auto;margin-right:auto; width: 100%;">
           <h4 style="margin-bottom: auto;">ȸ�����Խ� ����� ���̵��Դϴ�.</h4>
           <tr style="background-color: rgb(255, 231, 171);">
               
               <td>�̸�</td>
               <td>���̵�</td>
               <td>�̸���</td>
               <td>��������</td>
           </tr>
           <tr>
               <td><%=vo.getName() %></td>
               <td><%=vo.getId() %></td>
               <td><%=vo.getEmail() %></td>
               <td><%=vo.getJoindate() %></td>
           </tr>
       </table>
       <div style="text-align: right; margin-top: 5px;">
           <input type="submit" value="��й�ȣ ����">
         </div><br>
         </form>
       <div style="text-align: center;">
           <button style="width: 260px; height: 40px; margin-left: 45px; background-color: aquamarine; font-size: 20px; margin-bottom: 15px;"
           type="button" onclick="location.href='login.jsp'">�ִϸֿ���α���</button>
          </div>
    </td>
</tr>
<!--footer �κ�-->
<%@ include file="../include/tail.jsp" %>