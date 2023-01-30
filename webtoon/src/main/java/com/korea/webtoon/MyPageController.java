package com.korea.webtoon;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import util.Common;
import vo.MemberVO;

@Controller
public class MyPageController {

	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession login;
	
	MemberDAO member_dao;					
	//Webtoon_UserDAO의 setter 인젝션 생성
	public void setMember_dao(MemberDAO member_dao) {
		this.member_dao = member_dao;
	}
	
	// 마이페이지
	@RequestMapping("Mypage")					
	public String loginTest(Model model) {						
		
		String id ="false";
		HttpSession login = request.getSession();
		
		// Session
		if(login != null) {
			String binding_tmp = (String)login.getAttribute("id");
			id=binding_tmp;
		}
		
		// 저장된 id값으로 db에 저장되어있는 user정보 한개 반환
		MemberVO user = member_dao.selectOne(id);				
			
		// 반환 받은값을 "vo"에 바인딩
		model.addAttribute("vo", user);							
		
		// 마이페이지로 이동
		return Common.Mypg_PATH+"myPage.jsp";						
	}
	
	// '정보 수정' 버튼 클릭시 호출
	@RequestMapping("modify_form.do")							
	public String modify_form(Model model, String id) {			
		
		// id값으로 db에 저장되어있는 user정보 한개 반환
		MemberVO vo = member_dao.selectOne(id);				
		
		// 반환된 user 정보 바인딩
		model.addAttribute("vo", vo);							
		
		// 정보수정 페이지로 이동
		return Common.Mypg_PATH+"modify_form.jsp";			
		
	}
	
	// 정보수정 페이지에서 '수정하기' 버튼 클릭시 호출
	@RequestMapping("modify.do")								
	@ResponseBody
	public String modify(MemberVO vo) {					
		
		// 받아온 데이터들을 DB에 업데이트하고 업데이트가 되었다면 '1' 반환
		int res = member_dao.update(vo);							

		String result = "no";
		
		// 데이터 수정이 잘되었다면
		if(res == 1) {											
			result = "yes";										
		}
		
		return result;											
	}
	
	// email, 전화번호 수정
	@RequestMapping("modify_email_phone.do")
	@ResponseBody
	public String modify_email_phone(MemberVO vo) {
		
		//vo에서 email과 휴대폰번호 받아오기
		String email = vo.getEmail();
		String phonenum = vo.getPhonenum();
		
		//랜덤한 키 생성
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 6; i++) { 
			int index = rnd.nextInt(3);
			switch (index) {
			case 0:
				key.append((char) (rnd.nextInt(26) + 97));
				break;
			case 1:
				key.append((char) (rnd.nextInt(26) + 65));
				break;
			case 2:
				key.append((rnd.nextInt(10)));
				break;
			}
		}
		
		//key 체크용 
		int res = 0;											
		String sKey = key.toString();
		if(email!= null) {
			res = service.MailService.sendmail(email, sKey);
		}else {
			res = service.MessageService.sendMessage(phonenum, sKey);
		}

		String result = "no";
		
		//key가 잘 보내졌으면 
		if(res == 1) {											
			result = "yes";										
		}
		
		login.setAttribute("sKey", sKey);
		return result;
	}
	
	//인증 화면에서 클라이언트 입력메시지와 서버가 송신한 메시지가 일치한지 확인
	@RequestMapping("myKey_check.do")
	@ResponseBody
	public String sKey_check(String Key) {
		String sKey = (String) login.getAttribute("sKey");
		if(sKey.equals(Key)) {
			login.removeAttribute("sKey");
			return "{'result':'clear'}";
		}
		return "{'result':'false'}";

	}
	
}
