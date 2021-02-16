package com.koreait.project.yongsoo.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QnATemDto {

	private int trainer_qna_no;
	private int question_user_no;
	private int trainer_user_no;
	private String trainer_qna_title;
	private String trainer_qna_content;
	private Timestamp created_at;
	private int is_published;	// 공개:1, 비공개:0
	private int is_answered;	// 답변아직:0, 답변완료:1 
	private String trainer_qna_answered;
	private Timestamp answered_date;
	private int on_hide;	// 안숨김:0, 숨김:1 
	
	private String user_nickname;
	private int user_separator;
	private String profile_photo;
	
	private String created_at2;
	private String answered_date2;
}
