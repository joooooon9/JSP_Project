<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
                <!-- --------------------------------------- 위에 상단부분 인크루드 -------------------------------------------------->
<script src="/PJ/res/se2/js/HuskyEZCreator.js" type="text/javascript"></script>
<script src="/PJ/res/se2/init.js" type="text/javascript"></script>
<script type="text/javascript">
	window.onload = function()
	{
		$("#title").focus();
	}
	function wsubmit()
	{
		if($("#title").val().trim() == "")
		{
			alert("제목이 입력되지 않았습니다.");
			$("#title").focus();
			return false;
		}
		if($("#content").val().trim() == "<p>&nbsp;</p>")
		{
			alert("내용이 입력되지 않았습니다.");
			$("#content").focus();
			return false;
		}
        if ($("select[name='thead'] option:selected").val() == "말머리") {
            alert("말머리를 선택해주세요.");
            $("#thead").focus();
            return false;
        }
		return true;
	}
	function subwrite()
	{
		if(confirm("임시저장하시겠습니까?") == false)
			{
				return false;
			}
		$("#saveFlag").val("F");
		$("form").submit();
	}
</script>
                <span style="color: black; font-weight: bold;">▶나눔게시판 글작성</span><br><br><br>
                <form action="share_writeok.jsp" method="post" enctype="multipart/form-data" onsubmit="return wsubmit();">
                <!-- bkind = F>자유게시판, R>식품추천, S>나눔게시판, I>이미지갤러리 Q>qna게시판 -->
                <input type="hidden" name="kind" id="kind" value="S">
                <table border="1" style="margin: auto; width: 1000px;">
                    <tr>
                        <th style="width: 100px; background-color: aqua;">제목</th>
                        <td>
                            <input type="text" style="width: 85%; margin: auto;" name="title" id="title">
                <select name="thead" id="thead">
                    <option value="말머리" selected disabled>말머리선택</option>
                    <option value="나눔전">나눔전</option>
                    <option value="나눔중">나눔중</option>
                    <option value="나눔완료">나눔완료</option>
                </select>
                        </td>
                    </tr>
                    <tr style="text-align: center;  height: 500px;">
                        <th style="background-color: aqua;">내용</th>
                        <td><textarea style="width: 99%; height: 500px; resize: none;" id="content" name="content" class="smarteditor2"></textarea></td>
                    </tr>
                    <tr>
                        <th style="background-color: aqua;">첨부파일</th>
                        <td>						
                            <input type="file" style="width: 99%;" id="attach" name="attach">
                        </td>																		
                    </tr>
                </table>
                <p style="color: red; margin-left: 249px">[ 알림 ] 나눔게시판에서 욕설 또는 비방글 등은 사전 경고 없이 관리자에 의하여 삭제 됩니다.</p>
         
				    <div style="text-align: center; margin-top: 20px;">
				        <!-- input으로 플래그 값을 지정 T:저장 F:임시 -->
				        <input type="hidden" value="T" name="saveFlag" id="saveFlag">
				        <input type="submit" value="작성완료">
				        <button type="button" onclick="javascript:subwrite()">임시저장</button>				       
				        <button type="button" class="my_btn" onclick="location.href='share_list.jsp'">돌아가기</button><br>
				    </div>                 
                </form>
<!-- ----------------------------------------- 하단 카피라이트 인크루드 --------------------------------------------->
<%@ include file="../include/tail.jsp" %>