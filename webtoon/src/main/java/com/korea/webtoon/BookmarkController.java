package com.korea.webtoon;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.BookmarkDAO;
import dao.WebtoonDAO;
import util.Common;
import vo.BookmarkVO;
import vo.WebtoonVO;

@Controller
public class BookmarkController {

	@Autowired
	HttpServletRequest request;
	
	HttpSession login;
	
	WebtoonDAO webtoon_DAO;
	public void setWebtoon_DAO(WebtoonDAO webtoon_DAO) {
		this.webtoon_DAO = webtoon_DAO;
	}
	BookmarkDAO bookmark_dao;
	public void setBookmark_dao(BookmarkDAO bookmark_dao) {
		this.bookmark_dao = bookmark_dao;
	}
	
	// 북마크(즐겨찾기, 즐겨찾기 삭제) 버튼 클릭시 호출
	@RequestMapping("/addBookmark.do")						
	@ResponseBody
	public String addBookmark(BookmarkVO vo) {											
			
		// vo값을 DB에 넘겨 동일한 값을 가진 데이터가 있는지 확인
		BookmarkVO res = bookmark_dao.select(vo);			
															
		String bookmark = "yes";						
		
		// 같은 값이 있다면 데이터 삭제(즐겨찾기 취소)
		if(res != null) {									 
			bookmark_dao.del(vo);							
			bookmark="no";										
			return bookmark;
		}
			
		// 북마크 추가
		bookmark_dao.insert(vo);							
			
		//"yes","no"값 반환
		return bookmark;									
				
	}
		
	// 북마크 페이지
	@RequestMapping("/bookmark.do")							
	public String bookmark(Model model) {				
						
		// Session
		login = request.getSession();
		System.out.println((String)login.getAttribute("id"));
		String id = (String)login.getAttribute("id");

		//id값을 DB로 넘겨 user_id=#{id}인 모든 데이터를 list에 저장
		List<BookmarkVO> webtoon_name = bookmark_dao.selectList(id);
		
		//list 생성
		List<WebtoonVO> list = new ArrayList<WebtoonVO>();			
	
		//for문을 이용해 북마크 등록한 웹툰 불러오기
		for(int i=0; i<webtoon_name.size(); i++) {			
				
			//ref(webtoon_idx)
			int ref = webtoon_name.get(i).getRef();			
				
			//ref를 Webtoon table로 보내 일치하는 웹툰 데이터 하나씩 가져오기
			WebtoonVO vo = webtoon_DAO.select(ref);			

			//list에 하나씩 저장
			list.add(vo);									
		}						
			
		model.addAttribute("bm", list);						
		model.addAttribute("user", id);						

		return Common.Mypg_PATH+"bookMark.jsp";
	}
	
}
