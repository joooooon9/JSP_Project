<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String name = request.getParameter("name");
String id = request.getParameter("id");
System.out.print(name);
%>
<script>
window.onload = function () {
    $("#pwok").submit(function () {
        // pw 입력값이 없으면 중지
        if ($("#pw").val() == "") {
            alert("비밀번호를 입력하세요");
            $("#pw").focus();
            event.preventDefault();
            return;
        }
        // pwc 입력값이 없으면 중지
        if ($("#checkpw").val() == "") {
            alert("비밀번호 확인을 입력하세요");
            $("#checkpw").focus();
            event.preventDefault();
            return;
        }
        // pw 입력값이 있는데, pwc 입력값과 다르면 중지
        if ($("#pw").val() != $("#checkpw").val()) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다");
            $("#checkpw").val("");
            $("#checkpw").focus();
            event.preventDefault();
            return;
        }
    });
};
</script>
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
            <form action="../login/changepw.jsp" method="post" name="pwok" id="pwok">
            <input type="hidden" name="id" id="uid" value="<%= id %>">
            <input type="hidden" name="name" id="uname" value="<%= name %>">
<table border="0" style="width: 100%;">
                    <tr>
                        <td>
                            <span style="color: black; font-weight: bold;">▶ 비밀번호 변경</span><br><br><br>
                        </td>
                    </tr>
                </table>
                <table border="1" style="width: 50%; margin-left: auto; margin-right: auto; text-align: center;">
                   <tr>
                    <tr>
                        <td style="background-color:#f2f2f2; ">새로운 비밀번호</td>
                        <td style="text-align: left;"><input type="password" name="pw" id="pw"></td>
                    </tr>
                    <tr>
                        <td style="background-color:#f2f2f2;">비밀번호 확인</td>
                        <td style="text-align: left;"><input type="password" name="checkpw" id="checkpw"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" style="margin-right: 25%;" value="변경하기">
                            <button type="button" onclick="location.href='my_page.jsp'">취소</button>
                        </td>
                    </tr>
                    </form>
                   </tr>
                        </table>
                   <%@ include file="../include/tail.jsp" %>