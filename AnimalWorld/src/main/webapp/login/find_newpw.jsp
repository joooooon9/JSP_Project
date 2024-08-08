<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%
String id = request.getParameter("id");
%>
<script>
window.onload = function()
{
	$("#newpw").focus();
	$("#npw").submit(function(){
		// 변경할 비밀번호를 입력하지 않았을 때
	    if($("#newpw").val() == "") {
	        alert("변경할 비밀번호가 입력되지 않았습니다.");
	        $("#newpw").focus();
	        event.preventDefault();
	        return false;
	    }
	    // 비밀번호 확인을 입력하지 않았을 때
	    if($("#newpwc").val() == "") {
	        alert("비밀번호 확인이 입력되지 않았습니다.");
	        $("#newpwc").focus();
	        event.preventDefault();
	        return false;
	    }
	    // 변경할 비밀번호와 확인에 입력한 값이 다를 때
	    if($("#newpw").val() != $("#newpwc").val()) {
	        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	        $("#newpw").val("");
	        $("#newpwc").val("");
	        $("#newpw").focus();
	        event.preventDefault();
	        return false;
	    }
	    if(confirm("입력한 비밀번호로 변경하시겠습니까?") == false) {
	        return false;
	    }
	});
}



</script>
<!-- 컨텐츠 출력부분-->
<table border="0" style="width: 100%;">
    <tr>
        <td>
            <span style="color: black; font-weight: bold;">▶ 비밀번호 변경</span><br><br><br>
        </td>
    </tr>
</table>
	<h4 style="text-align: center; margin: auto; color: red;">* 비밀번호생성규칙에따라 변경해주시기바랍니다.</h4>
	<form action="changepw.jsp" method="post" id="npw">
	<input type="hidden" name="id" id= "uid" value="<%= id %>">
<table border="1" style="width: 50%; margin-left: auto; margin-right: auto; text-align: center;">
    <tr>
        <td style="background-color:#f2f2f2; ">새로운 비밀번호</td>
        <td style="text-align: left;"><input type="password" name="pw" id="newpw"></td>
    </tr>
    <tr>
        <td style="background-color:#f2f2f2;">비밀번호 확인</td>
        <td style="text-align: left;"><input type="password" id="newpwc"></td>
    </tr>
    <tr>
        <td colspan="2">
            <input type="submit" style="margin-right: 25%;" value="변경하기">
            <button type="button" onclick="location.href='find_pwcheck.jsp'">취소</button>
        </td>
    </tr>
</table>
</form>
<br>
<table border="1" style="width: 100%;">
    <caption style="font-size: 20px; color: red;">
            ☆비밀번호 생성규칙 안내☆
            </caption>
            <colgroup>
                <col width="150">
                <col width="*">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">구분</th>
                    <th scope="col">개인정보 생성규칙</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>비밀번호 최소길이</td>
                    <td>영대문자(A~Z, 26개), 영소문자(a~z, 26개), 숫자(0~9, 10개) 및 특수문자(32개) 중 3종류 이상으로 구성하여 최소 9자 이상으로 입력합니다.<br>
                        ※ 특수문자 32개 예시<br>
                    <strong>~ ․! @ # $ % ^ &amp; * ( ) _ - +  =&nbsp; [ ] [ ] | \ ; :‘ “ &lt; &gt; , . ? /</strong></td>
                </tr>
                <tr>
                    <td>추측하기 어려운 비밀번호 생성</td>
                    <td>
                        <li>생성한 비밀번호에 12345678 등과 같은 일련번호, 전화번호 등과 같은 쉬운 문자열이 포함되지 않도록 합니다.</li>
                        <li>love, happy 등과 같은 잘 알려진 단어 또는 키보드 상에서 나란히 있는 문자열도 포함되지 않도록 합니다.</li>
                        </ul></td>
                </tr>
                <tr>
                    <td>비밀번호의 주기적인 변경</td>
                    <td>비밀번호에 유효기간을 설정하고 적어도 6개월마다 변경함으로써 동일한 비밀번호를 장기간 사용하지 않습니다.</td>
                </tr>
                <tr>
                    <td>동일한 비밀번호 사용제한</td>
                    <td>2개의 비밀번호를 교대로 사용하지 않습니다.</td>
                </tr>
            </tbody>
        </table>
    </td>
</tr>
<!--footer 부분-->
<%@ include file="../include/tail.jsp" %>
