<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
UserDTO dto = new UserDTO();
UserVO vo = new UserVO();
%>
<table border="0" style="width: 100%;">
            <td  valign="top" style="text-align: center; width: 200px;">
                <div class="submenu"><a href="../home/my_page.jsp">내 정보</a></div>
                <div class="submenu"><a href="../home/my_write.jsp">나의 게시물</a></div>
                <div style="height:2px; background-color:#ffffff;"></div>
                <div class="submenu"><a href="../home/my_coment.jsp">나의 댓글</a></div>
                <div class="submenu"><a href="../home/my_subwrite.jsp">임시저장한 글</a></div>
            </td>
            <td style="width:5px; background-color: #fc6e51;"></td>
            <td>
                <!-- 컨텐츠 출력부분-->
                <table border="0" style="width: 100%;">
                    <tr>
                        <td>
                            <span style="color: black; font-weight: bold;">▶ 내 정보</span><br><br><br>
                        </td>
                    </tr>
                </table>
                <form action="my_pw.jsp" method="post">
                <table border="0" style="width: 35%; margin-left: auto; margin-right: auto; text-align: center;">
                   <tr>
                    <tr>
                        <td style="background-color:#71ff82;">이름</td>
                        <input type="hidden" id="uname" name="name" value="<%= login.getName() %>">
                        <td style="text-align: left; background-color:#f2f2f2;"><%= login.getName() %></td>
                    </tr>
                    <tr>
                        <td style="background-color:#71ff82;">아이디</td>
                        <input type="hidden" id="uid" name="id" value="<%= login.getId() %>">
                        <td style="text-align: left;background-color:#f2f2f2;"><%= login.getId() %></td>
                    </tr>
                    <tr>
                        <td style="background-color:#71ff82;">비밀번호</td>
                        <input type="hidden" id="upw" name="upw" value="<%= login.getPw() %>">
                        <td style="text-align: left;background-color:#f2f2f2;">****
                        <input type="submit" style="text-align: right; margin-left: 60%" value="변경하기">
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color:#71ff82;">성별</td>
                        <td style="text-align: left;background-color:#f2f2f2;">
                        <%
                        String gender = login.getGender();
                        if ("M".equals(gender)) {
                            out.print("남자");
                        } else if ("F".equals(gender)) {
                            out.print("여자");
                        }
                        %></td>
                    </tr>
                    <tr>
                        <td style="background-color:#71ff82;">이메일</td>
                        <td style="text-align: left;background-color:#f2f2f2;"><%= login.getEmail() %></td>
                    </tr>
                    </form>
                    <tr>
                        <td >
                            <button type="button" onclick="location.href='index.jsp'">메인으로</button>
                        </td>
                        <td >
                            <button type="button" onclick="javascript:deleteuser();">회원탈퇴</button>
                        </td>
                    </tr>
                   </tr>
                    <tr>
                            </td>
</tr>
</table><br>
                    <%@ include file="../include/tail.jsp" %>