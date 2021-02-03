<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:include page="../template/header.jsp" />
<link type="text/css" rel="stylesheet" href="resources/style/jung/TrainerClassViewPage.css" >


    <form method="post">
    
    		<br/><br/><br/>
    	   <div class="TrainerClassView_part1"> 
    	   
		    	   <div class="TrainerClassInfo">
		    	   
					   모임제목 : ${trainerClassDto.meeting_title}<br/><br/>
					   모임일 : ${trainerClassDto.meeting_date}<br/><br/>
					   모집 기간 : ${trainerClassDto.start_gather_date} ~ ${trainerClassDto.end_gather_date}<br/><br/>
					   모집 인원 : 최소 ${trainerClassDto.meeting_min}명 ~ 최대 ${trainerClassDto.meeting_max}<br/><br/>
					   운동 종목 : ${trainerClassDto.exercise_no}<br/><br/>
					   모임장소 : ${trainerClassDto.location1_no} ${trainerClassDto.location2_no}<br/><br/>
					   상세 주소 : ${trainerClassDto.detail_location}<br/><br/>
					   준비물 :
					   <c:forEach var="materialsDto" items="${list}">
						   	${materialsDto.materials_name}
					   </c:forEach>
					   <br/><br/>
					   상세내용 : ${trainerClassDto.meeting_content}<br/><br/>
		    	   
		    	   </div>
				   
				   <div class="WishList_all">
				   
					   <div class="WishList"><a href="">관심페이지 등록하기</a></div>
					   <div class="TrainerClassPhoto">
					   		사진 
					   </div>
				   
				   </div>
				   
				   <!-- hidden -->
				   <input type="hidden" name="meeting_no" value="${trainerClassDto.meeting_no}" />
				   <input type="hidden" name="meeting_title" value="${trainerClassDto.meeting_title}" />
				   <input type="hidden" name="meeting_date" value="${trainerClassDto.meeting_date}" />
				   <input type="hidden" name="start_gather_date" value="${trainerClassDto.start_gather_date}" />
				   <input type="hidden" name="end_gather_date" value="${trainerClassDto.end_gather_date}" />
				   <input type="hidden" name="meeting_min" value="${trainerClassDto.meeting_min}" />
				   <input type="hidden" name="meeting_max" value="${trainerClassDto.meeting_max}" />
				   <input type="hidden" name="exercise_no" value="${trainerClassDto.exercise_no}" />
				   <input type="hidden" name="location1_no" value="${trainerClassDto.location1_no}" />
				   <input type="hidden" name="location2_no" value="${trainerClassDto.location2_no}" />
				   <input type="hidden" name="detail_location" value="${trainerClassDto.detail_location}" />
				   <input type="hidden" name="meeting_content" value="${trainerClassDto.meeting_content}" />
				   <!-- 받은 여러개의 materials 값을 보내기 위한 작업 -->
				   <c:forEach var="materialsList" items="${list}">
					   <input type="hidden" name="materials_name" value="${materialsList.materials_name}" />
				   </c:forEach>
    	   
    	   </div>
			   
			   <!-- 버튼들(수정, 삭제, 등록) -->
			   <input type="button" value="수정" onclick="fn_TrainerClassViewUpdatePage(this.form)" />
			   <input type="button" value="삭제" onclick="fn_TrainerClassViewDelete(this.form)" />
			   <input type="button" value="등록하기" onclick="fn_TrainerClassApply(this.form)" />
			   
			   
			   <!-- 모달창 띄우는 버튼 -->
			   <input type="button" value="질문하기" id="modal-open-btn" />
			   
			   <!-- 모달창 버튼 누를 시 열리는 내용들 -->
			   <div class="modal_all">
				      <div class="modal-box">
				      		<a href="" class="modal_close_btn">닫기</a>
					        <p class="modal-title">안녕하세요? 게시물 등록자입니다. 저희 모임에 대해 궁금하시다구요!? 무엇이든 질문 주세요.</p>
					        <br/>
					        <div class="modal-close-box">
					        <form>
					         	 <input type="text" name="question_title" placeholder="질문 제목" />
					         	 <textarea rows="10" cols="50" name="question_content" placeholder="질문 내용"></textarea>
					         	 <br/>
					         	 <input type="button" value="질문등록하기"  id="questionBtn"/>
					        </form>
					        	
					        </div><br/>
					        <table border="1">
					        	<thead>
					        		<tr>
					        			<td>질문자</td>
					        			<td>질문 제목</td>
					        			<td>답변 여부</td>
					        		</tr>
					        	</thead>
					        	<tbody id=question_info>
					        		
					        	</tbody>
					        </table>
				      </div>
			    </div>
			   
			   
		   
    </form>

	
	<script>
	
	//모달창 만들어주는 함수
	$(document).ready(function () {
		$(".modal_all").show();
	});

	
	
	</script>


    <script>
			
    		// 해당 게시물 수정 (작성자 권한)
			function fn_TrainerClassViewUpdatePage(f) {
				f.action = 'TrainerClassViewUpdatePage.leo';
				f.submit();
			}
			
    		// 해당 게시물 삭제 (작성자 권한)
			function fn_TrainerClassViewDelete(f) {
				if (confirm('삭제하시겠습니까?')) {
					f.action = 'TrainerClassViewDelete.leo';
					f.submit();
				}
			}
    		
    		// 해당 게시물을 작성자가 등록(마이페이지의 리스트로 넘어감)
    		function fn_TrainerClassApply(f) {
    			f.action = '';
    			f.submit();
    		}

	</script>
	
	
	<script>
		
		// 페이지 로드 이벤트
		$(document).ready(function(){
			commentList();
			commentInsert();
			commentUpdate();
			commentUpdate2();
			commentUpdateCancel();
			commentInsertCancel();
		});
		
		/**** 리스트 뿌려주기 ****/
		function commentList() {
			var meeting_no = '${trainerClassDto.meeting_no}';
			$.ajax({
				url: 'comment.leo',
				type: 'get',
				data: 'meeting_no=' + meeting_no,
				dataType: 'json',
				success: function (responseObj) {
					if (responseObj.result) {
						commentListContent(responseObj.commentList);
						$('#totalCount').empty();
						$('<span>').html(responseObj.totalCount)
						.appendTo('#totalCount');
					} else {
						$('#listComment_all').empty();
						 $('<div>').html('댓글을 작성해주세요')
						.appendTo('#listComment_all');
					}
				},
				error: function() {alert('실패');}
			});
		}
		function commentListContent(list) {
			$('#listComment_all').empty();
			$.each(list, function(idx, comment){
					
				$('<div>').addClass('commentContent')
				.append( $('<div>').addClass('myPhoto').append( $('<img alt="내프로필" src="">') ))
				.append( $('<div>').addClass('comment_wrap')
					.append( $('<div>').addClass('comment_all')
						.append( $('<div>').addClass('comment1')
								.append( $('<div>').html(comment.user_no))
								.append( $('<div>').html(comment.created_at))
						)
						.append( $('<div>').addClass('comment2').html(comment.comment_content) )
					)
					.append( $('<div>').addClass('CommentU_DBtn')
						.append( $('<input type="hidden" name="comment_no"/>').val(comment.comment_no) )
						.append( $('<input type="hidden" name="user_no"/>').val(comment.user_no))
						.append( $('<input type="hidden" name="comment_content"/>').val(comment.comment_content))
						.append( $('<div>').html('<input type="button" value="수정" id="btnUpdate"/>') )
						.append( $('<div>').html('<input type="button" value="삭제" id="btnDelete" onclick="commentDelete('+ comment.comment_no + ')"/>') )
					)															
				)
				.appendTo('#listComment_all');
				
			});
		}
		
		/**** 댓글 삽입 ****/
		function commentInsert() {
			$('#commentBtn').click(function(){
				var meeting_no = ${trainerClassDto.meeting_no};
				var user_no = 10;
				var comment_content = $('input:text[name="comment_content"]').val();
				var sendObj = {
						"comment_referer_no": meeting_no,
						"user_no": user_no,
						"comment_content": comment_content
					};
				
				$.ajax({
					url: 'commentInsert.leo',
					type: 'post',
					dataType:'json',
					data: JSON.stringify(sendObj),
					contentType: 'application/json; charset=utf-8',
					success: function(responseObj) {
						if (responseObj.result == true) {
							alert('댓글이 작성되었습니다.');
							commentList();
							$('input:text[name="comment_content"]').val('');
						} else {
							alert('댓글이 작성되지 않았습니다.');
						}
					},
					error: function(){alert('실패');}
				});
			});
		}
		
		/**** 댓글 삭제 ****/	
		function commentDelete(comment_no) {
					$.ajax({
						url: 'commentDelete.leo/' + comment_no,
						type: 'get',
						dataType: 'json',
						success: function(responseObj) {
							if (responseObj.result == 1) {
								alert('삭제되었습니다.');
								commentList();
							} else {
								alert('삭제에 실패했습니다.');
							}
						},
						error: function(){alert('실패');}						
					});
		}
		
		/**** 댓글 수정하기 위한 input 생성 후 value 입력 ****/
		function commentUpdate() {
			$('#listComment_all').on('click', '#btnUpdate', function() {
				$(this).parents('.comment_wrap').addClass('my');
				$(this).parents('.comment_wrap').empty();
				/*
				var a = $('<div>')
				.append($('<input type="text" name="commentUpdate"/>'))
				.append($('<input type="button" value="수정완료"/>'))
				.append($('<input type="button" value="취소"/>'));
				
				$('#listComment_all').find('.my').append(a);
				*/
				var comment_no = $(this).parents('div').find('input:hidden[name="comment_no"]').val();
				var comment_content = $(this).parents('div').find('input:hidden[name="comment_content"]').val();
				
				$('<div>').addClass('commentUpdateScreen')
				.append($('<input type="text" name="commentUpdate" id="commentUpdate"/>').val(comment_content))
				.append($('<input type="hidden" name="comment_no"/>').val(comment_no))
				.append($('<input type="button" value="수정완료" id="commentUpdateEnd"/>'))
				.append($('<input type="button" value="취소" id="commentUpdateCancel"/>'))
				.appendTo('.my');
			});
		}
				
		/***** 댓글 수정 *****/
		function commentUpdate2() {
				$(document).on('click', '#commentUpdateEnd', function() {
					
					var commentUpdate = $(this).parent('div').find('input:text[name="commentUpdate"]').val();
					var comment_no = $(this).parent('div').find('input:hidden[name="comment_no"]').val();
					
					var sendObj = {
										"comment_content" : commentUpdate,
										"comment_no" : comment_no
									   };
					$.ajax({
						
							url: 'commentUpdate.leo',
							type: 'post',
							data: JSON.stringify(sendObj),
							dataType: 'json',
							contentType: 'application/json; charset=utf-8',
							success: function(responseObj) {
								if (responseObj.result == true) {
									alert('수정되었습니다.');
									commentList();
								} else {
									alert('수정되지 않았습니다.');
								}
							},
							error:function(){alert('실패3');}
					});
				});
			}
		
		// 수정버튼 눌렀을때 나오는 취소 버튼 처리
		function commentUpdateCancel() {
			$(document).on('click', '#commentUpdateCancel', function() {
				commentList();			
			});	
		}
		
		// 작성버튼 옆에 취소 버튼 처리
		function commentInsertCancel() {
			$('#commentInsertCancel').click(function(){
					$('input:text[name="comment_content"]').val('');
			});
		}
		
	</script>
	
	
	<br/><br/><br/><br/><br/>

		<form>
			<div>댓글&nbsp;<span id="totalCount"></span>개</div><br/>
			<!-- 댓글 작성란 -->
			<div class="createComment_all">
				<div class="myPhoto"><img alt="내 프로필" src="" /></div>
				<div id="createComment"><input type="text" name="comment_content" id="comment_content" placeholder="댓글작성.."></textarea></div>
				<div class="btns">
					<input type="button" value="취소" id="commentInsertCancel"/>
					<input type="button" value="댓글달기" id="commentBtn" /> 
				</div>
			</div>
		</form>
	
	<!-- 댓글 리스트란 -->
	<div id="listComment_all">
	
	</div>
	
    
<%@ include file="../template/footer.jsp" %>
