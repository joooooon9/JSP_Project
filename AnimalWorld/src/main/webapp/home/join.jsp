<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>
// id 중복검사 결과를 담아놓을 플래그 변수


// id 입력이 들어오면, ajax를 이용하여, DBMS에 동일한 id가 존재하는지 검사
window.onload = function(){
	
	$("#uID").focus();
	
	// id 입력창에 사용자가 입력값을 넣으면 이벤트 리스너를 통해 입력값을 체크
	$("input[name='id']").keyup(function(){
		CheckID();
	});
}

//회원가입 처리
function DoJoin()
{
	// id 입력값이 없으면 메세지 출력하고 submit 중지
	if($("#uID").val() == "")
	{
		alert("아이디를 입력하세요");
		$("#uID").focus();
		return;
	}
	// pw 입력값이 없으면 중지
	if($("#pw").val() == "")
	{
		alert("비번을 입력하세요");
		$("#pw").focus();
		return;
	}
	// pwc 입력값이 없으면 중지
	if($("#pwc").val() == "")
	{
		alert("비번확인을 입력하세요");
		$("#pwc").focus();
		return;
	}
	// pw 입력값이 있는데, pwc 입력값과 다르면 중지
	if($("#pw").val() != $("#pwc").val())
	{
		alert("비번과 비번확인이 일치하지 않습니다");
		$("#pwc").val("");
		$("#pwc").focus();
		return;
	}
	
	// 이름 입력값이 없으면 중지
	if($("#uName").val() == "")
	{
		alert("이름을 입력하세요");
		$("#uName").focus();
		return;
	}
	// id가 중복이거나, 중복검사가 ERROR이면 중지
	if(checkCode == "ERROR")
	{
		alert("ID중복검사 오류상태입니다");
		$("#uID").val("");
		$("#uID").focus();
		return;
	}
	if(checkCode == "DUPLICATE")
	{
		alert("중복된 ID입니다. 회원가입을 진행할 수 없습니다");
		$("#uID").val("");
		$("#uID").focus();
		return;
	}
	
	if($("#mail").val() == "")
	{
		alert("메일주소를 입력하세요.");
		$("#mail").focus();
		return;
	}	
	if($("#code").val() == "")
	{
		alert("인증코드를 입력하세요.");
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
				if(confirm("회원가입을 진행하시겠습니까?") == 1)
				{
					$("#join").submit();
				}					
			}else
			{
				alert("인증코드가 일치하지 않습니다.");
				$("#code").focus();
			}
		}			
	});			
}

function CheckID()
{
	// 중복검사 결과를 초기화
	checkCode = "ERROR";
	// 메세지 박스를 초기화
	$("#msg_box").html("");
	// 입력값이 없으면 입력값을 넣도록 메세지 출력
	if($("#uID").val() == "") { $("#msg_box").html("아이디가 입력되지 않았습니다"); }
	// 입력값이 4글자 이상이면 id중복 체크 ajax 호출
	if($("#uID").val().length > 3 )
	{
		$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
			url			: "idcheck.jsp?id=" + $("#uID").val(),
			type		: "get",
			dataType	: "html",
			success		: function(response){
				response = response.trim();
				console.log(response);
				// ajax로 받은 결과 코드를 플래그 변수에 넣습니다
				checkCode = response;
				switch(response)
				{
				case "ERROR" :
					$("#msg_box").html("중복검사 오류가 발생했습니다");
					break;
				case "DUPLICATE" :
					$("#msg_box").html("중복된 아이디입니다");
					break;
				case "NOT_DUPLICATE" :
					$("#msg_box").html("사용 가능한 아이디입니다");
					break;
				}
			}
		});
	}else
	{
		$("#msg_box").html("4글자 이상 입력해주세요");					
	}
}

function SendMail()
{
	if( $("#email").val() == "")
	{
		alert("메일 주소를 입력하세요.");
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
                                <span style="color: black; font-weight: bold;">▶ 회원가입</span><br><br><br>
                            </td>
                        </tr>
                    </table>
                    <table border="1" style="margin-left: auto; margin-right: auto;">
                        <tr>
                            <td>아이디(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" id="uID" name="id"><br>
                                <span id="msg_box" style="color: red; font-weight: bold;">아이디를 입력하세요</span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호(*)</td>
                            <td><input type="password" style="text-align: left; width: 50%;" name="pw" id="pw"></td>
                        </tr>
                        <tr>
                            <td>비밀번호확인(*)</td>
                            <td><input type="password" style="text-align: left; width: 50%;" name="pwc" id="pwc"></td>
                        </tr>
                        <tr>
                            <td>이름(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" name="name" id="uName"></td>
                        </tr>
                        <tr>
                            <td>성별(*)</td>
                            <td>
                                <input type="radio" name="gender" value="M" checked>남자
                                <input type="radio" name="gender" value="F">여자
                            </td>
                        </tr>
                        <tr>
                            <td>이메일(*)</td>
                            <td><input type="text" style="text-align: left; width: 50%;" name = "email" id="email"> &nbsp;&nbsp;&nbsp;&nbsp; 
                            <input type="button" onclick="SendMail();" value="인증하기">
                            </td>
                        </tr>
                        <tr>
                            
                            <td colspan="2"><input type="text" style="text-align: left; width: 50%;" placeholder="인증번호를 입력해주세요" name="code" id="code"> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <input type="button" onclick="DoJoin();" value="가입완료">&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="reset" value="취소">
                            </td>							
                        </tr>
                    </table>
                    <br>
                </form>
<%@ include file="../include/tail.jsp" %>