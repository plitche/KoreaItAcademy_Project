let user_no;

$(document).ready(function() {
	user_no = $('#user_no').val();
	fn_preparingMeetingForm();
	fn_meetingDetail();
})

function fn_stampToDate2(timestamp) {
	let d = new Date(timestamp);
	let result = `${d.getFullYear()}-`;
	if(d.getMonth() < 10) {result += 0;}
	result += `${(d.getMonth() + 1)}-`;
	if(d.getDate() < 10) {result += 0;}
	result += `${d.getDate()}`;
	return result;
}

//클릭시 모임 상세페이지 이동
function fn_meetingDetail() {
	$('body').on('click', '.meeting', function() {
		let meeting_no = $(this).find('#meeting_no').val();
		location.href = `meetingViewPage.plitche?meeting_no=${meeting_no}`
	});
}

// 참여예정모임 - 참여예정 모임 인서트 폼 생성
function fn_preparingMeetingForm() {
	$('#contentBox').empty();
	let content = `
	<div class="content flex wrap"></div>
	<div class="paging"></div>`;
	$('#contentBox').html(content);
	fn_preparingMeetingList(1);
}

// 참여예정모임 - 리스팅 목록 불러오기 
function fn_preparingMeetingList(p) {
	$.ajax({
		url: 'preparingMeetingList.wooki',
		type: 'get',
		data: {
			user_no: user_no,
			page: p
		},
		dataType: 'json',
		success: function(list) {
			fn_addPreparingList(list.list, list.paging, list.page);
		},
		error: function() {
			alert('실패');
		}
	});
}

// 참여예정모임 - 리스팅 목록 삽입
function fn_addPreparingList(list, paging, page) {
	$('.content').empty();
	$('.paging').empty();
	if(list.length == 0) {
		let content = `
		<div>진행 예정인 모임이 없습니다.</div>`;
		$('#contentBox .content').append(content);
	} else {
		$.each(list, function(idx, meeting) {
			let date = fn_stampToDate2(meeting.meeting_date);
			let meetingCorver;
			if(meeting.meeting_filename == null) {
				meetingCorver = 'images/meeting_basic_corver.jpg';
			} else {
				meetingCorver = `storage/${meeting.meeting_filename}`;
			}
			let profilePhoto;
			if(meeting.profile_filename == null) {
				profilePhoto = 'images/blank-profile-picture.png';
			} else {
				profilePhoto = `storage/profile_photo/${meeting.profile_filename}`;
			}
			
			let content = `
			<div class="meeting">
				<div class="cover">
					<img src="resources/${meetingCorver}">
				</div>
				<div>
					<div>
						${meeting.meeting_title}
					</div>
					<div>
						<div>
							${meeting.exercise_name}
						</div>
						<div>
							${meeting.min}명 ~ ${meeting.max}명
						</div>
					</div>
					<div>
						<i class="fas fa-map-marker-alt"></i> ${meeting.location1} ${meeting.location2} ∙ ${date}
					</div>
					<div class="flex">
						<div class="profiePhoto"><img src="resources/${profilePhoto}"></div>
						<div>${meeting.nickname}</div>
					</div>
				</div>
				<input type="hidden" name="meeting_no" id="meeting_no" value="${meeting.meeting_no}" />
			</div>`;
			$('#contentBox .content').append(content);
		});
		let text = `
		${paging}
		<input type="hidden" id="now_page" value="${page}"/>`;
		$('.paging').append(text);
	}
}