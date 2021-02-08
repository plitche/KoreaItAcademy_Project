package com.koreait.project.yongsoo.command.trainerReview;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.project.common.CommonMapCommand;
import com.koreait.project.dto.ReviewDto;
import com.koreait.project.yongsoo.dao.TrainerReviewDao;

public class WriteReviewCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		ReviewDto reviewDto = (ReviewDto)map.get("reviewDto");
		
		TrainerReviewDao trainerReviewDao = sqlSession.getMapper(TrainerReviewDao.class);
		int result = trainerReviewDao.wrtieReview(reviewDto);
		
		Map<String, Object> writeReviewResult = new HashMap<String, Object>();
		if (result > 0) {
			writeReviewResult.put("result", true);
		} else {
			writeReviewResult.put("result", false);
		}
		
		return writeReviewResult;
	}

}
