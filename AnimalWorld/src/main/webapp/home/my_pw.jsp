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
        // pw �Է°��� ������ ����
        if ($("#pw").val() == "") {
            alert("��й�ȣ�� �Է��ϼ���");
            $("#pw").focus();
            event.preventDefault();
            return;
        }
        // pwc �Է°��� ������ ����
        if ($("#checkpw").val() == "") {
            alert("��й�ȣ Ȯ���� �Է��ϼ���");
            $("#checkpw").focus();
            event.preventDefault();
            return;
        }
        // pw �Է°��� �ִµ�, pwc �Է°��� �ٸ��� ����
        if ($("#pw").val() != $("#checkpw").val()) {
            alert("��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�");
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
                <div class="submenu"><a href="../home/my_page.jsp">�� ����</a></div>
                <div class="submenu"><a href="../home/my_write.jsp">���� �Խù�</a></div>
                <div style="height:2px; background-color:#ffffff;"></div>
                <div class="submenu"><a href="../home/my_coment.jsp">���� ���</a></div>
                <div class="submenu"><a href="../home/my_subwrite.jsp">�ӽ������� ��</a></div>
            </td>
            <td style="width:5px; background-color: #fc6e51;"></td>
            <td>
            <form action="../login/changepw.jsp" method="post" name="pwok" id="pwok">
            <input type="hidden" name="id" id="uid" value="<%= id %>">
            <input type="hidden" name="name" id="uname" value="<%= name %>">
<table border="0" style="width: 100%;">
                    <tr>
                        <td>
                            <span style="color: black; font-weight: bold;">�� ��й�ȣ ����</span><br><br><br>
                        </td>
                    </tr>
                </table>
                <table border="1" style="width: 50%; margin-left: auto; margin-right: auto; text-align: center;">
                   <tr>
                    <tr>
                        <td style="background-color:#f2f2f2; ">���ο� ��й�ȣ</td>
                        <td style="text-align: left;"><input type="password" name="pw" id="pw"></td>
                    </tr>
                    <tr>
                        <td style="background-color:#f2f2f2;">��й�ȣ Ȯ��</td>
                        <td style="text-align: left;"><input type="password" name="checkpw" id="checkpw"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" style="margin-right: 25%;" value="�����ϱ�">
                            <button type="button" onclick="location.href='my_page.jsp'">���</button>
                        </td>
                    </tr>
                    </form>
                   </tr>
                        </table>
                   <%@ include file="../include/tail.jsp" %>