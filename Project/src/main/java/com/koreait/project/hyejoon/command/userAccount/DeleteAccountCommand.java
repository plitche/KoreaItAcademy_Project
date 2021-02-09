package com.koreait.project.hyejoon.command.userAccount;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.project.common.CommonMapCommand;
import com.koreait.project.hyejoon.dao.UsersDao;

public class DeleteAccountCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		
		int user_no = (int)session.getAttribute("user_no");
		
		UsersDao usersDao = sqlSession.getMapper(UsersDao.class);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("result", usersDao.deleteAccount(user_no));
		
		return result;
		
	}

}
