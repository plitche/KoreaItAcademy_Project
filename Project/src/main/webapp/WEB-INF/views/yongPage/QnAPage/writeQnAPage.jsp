<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jquery, fontawesome -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/07b67006ce.js"></script>
	
<!-- css파일 및 js파일 -->
<link rel="stylesheet" href="resources/wooki/css/textEditor.css">
<script src="resources/wooki/js/textEditor.js"></script>

<link type="text/css" rel="stylesheet" href="resources/style/soo/writeQnAPage.css" >
<!DOCTYPE html>
<jsp:include page="../../template/header.jsp">
	<jsp:param value="질문과 답변페이지" name="title"/>
</jsp:include>

<!-- 텍스트 에디터 실행을 위한 스크립트 -->
<script>
	$(document).ready(function() {
		fn_insertTempBoard($('#user_no').val());
		divToBr();
		deleteContent();
		fn_filesend();
	});
</script>

<!-- 질문 작성 완료 버튼 클릭 시 내용이 다 기입되었는지 확인할 function -->
<script>
	function fn_writeQnA(f) {
		if($('input[name="board_qna_title"]').val() == '') {
			Swal.fire('제목이 없습니다.', '질문 제목을 작성해주세요!', 'error');
			return;
		}
		if($('#content').text() == '') {
			Swal.fire('내용이 없습니다.', '질문 내용을 작성해주세요!', 'error');
			return;
		}
		fn_submit();
	}
</script>

<h3 style="font-weight: bold; width: 100%; text-align: center; margin: 50px auto;">질문 작성하기</h3>

<form method="post" id="insertForm" action="writeQnA.plitche">
	<div id="qnaTitle">
		<div>질문 제목</div>
		<input type="text" name="board_qna_title" placeholder="질문 제목을 입력하세요."/>
	</div>
	<input type="hidden" name="temp_no" id="temp_no" />
	<input type="hidden" name="user_no" id="user_no" value="${loginUser.user_no}" />
</form>
<pre id="writeRefer">
   ■ 필독 사항
   - 자유 형식으로 질문 제목과 질문 내용을 작성해 주세요.
   - 질문 제목은 질문 내용을 간략하게 표현할 수 있게 작성해 주세요.
   - 댓글이 작성되면 질문 수정과 삭제가 불가함으로 다시한번 꼼꼼히 작성해주세요.
   - 댓글을 통해 궁금증이 해결되셨다면, 해결 완료 버튼을 통해 더이상 댓글을 받지 않을 수 있습니다. 
</pre>
<div id="qnaContent">
	<span>질문 상세 내용</span>
	<i class="far fa-plus-square btn" onclick="fn_addContent()"></i>
	<label>
		<input style="display: none" type="file" id="uploadFile" name="uploadFile" accept="image/*" />
		<i class="far fa-images btn"></i>
	</label>
	<div id="content" style="border: 1px solid #d8d8d8;"></div>
	<br/>
	<input type="button" id="doneBtn" value="질문 작성완료" onclick="fn_writeQnA(this.form)" />
</div>



<%@ include file="../../template/footer.jsp" %>
