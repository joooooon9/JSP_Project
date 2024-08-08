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
			alert("일치하는 회원정보가 없습니다.");
			document.location = "../login/find_id.jsp";
		</script>
		
		<%
		return;
	}
%>
       <!-- 콘텐츠 출력부분 -->
       
       <table border="0" style="margin-left:auto;margin-right:auto; width: 100%;">
           <tr>
               <td style="font-size: 20px; font-weight: bolder;">▶ 아이디찾기결과</td>
           </tr>
       </table>
       <form action="find_newpw.jsp" method="post">
       <input type="hidden" name="id" id="uid" value="<%=vo.getId() %>">
       <table border="1" style="margin-left:auto;margin-right:auto; width: 100%;">
           <h4 style="margin-bottom: auto;">회원가입시 사용한 아이디입니다.</h4>
           <tr style="background-color: rgb(255, 231, 171);">
               
               <td>이름</td>
               <td>아이디</td>
               <td>이메일</td>
               <td>가입일자</td>
           </tr>
           <tr>
               <td><%=vo.getName() %></td>
               <td><%=vo.getId() %></td>
               <td><%=vo.getEmail() %></td>
               <td><%=vo.getJoindate() %></td>
           </tr>
       </table>
       <div style="text-align: right; margin-top: 5px;">
           <input type="submit" value="비밀번호 변경">
         </div><br>
         </form>
       <div style="text-align: center;">
           <button style="width: 260px; height: 40px; margin-left: 45px; background-color: aquamarine; font-size: 20px; margin-bottom: 15px;"
           type="button" onclick="location.href='login.jsp'">애니멀월드로그인</button>
          </div>
    </td>
</tr>
<!--footer 부분-->
<%@ include file="../include/tail.jsp" %>