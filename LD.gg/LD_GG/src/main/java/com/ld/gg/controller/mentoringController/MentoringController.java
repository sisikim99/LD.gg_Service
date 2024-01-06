package com.ld.gg.controller.mentoringController;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dao.mentoringdao.MyMentoringDAO;
import com.ld.gg.dao.mentoringdao.TagListDAO;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.mentoringdto.LikeMentorDTO;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.SummonerService;
import com.ld.gg.service.mentoringService.MentorProfileService;

@Controller
@RequestMapping("/mentor")
public class MentoringController {
	
	@Autowired
	private MentorProfileService mtpService;
	@Autowired
	private MemberService mbService;
	@Autowired
	private MemberDao mbdao;
	@Autowired
	private MyMentoringDAO myMtDao;
	@Autowired
	private MentorProfileDAO mtpdao;
	@Autowired
	private SummonerService summonerService;
	@Autowired
	private TagListDAO tagdao;
	
	
	//마이멘토링 페이지로 이동
	@GetMapping("/my-mentoring")
	public ModelAndView go_my_mentoring(HttpServletRequest request) {
		System.out.println("마이멘토링 페이지로 이동합니다.");
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		if (mbdto.getUser_type() == 2) { //멘토일 경우
			return new ModelAndView("mentoringView/myMentoring")
					.addObject("member", mbdto);
		} else if (mbdto.getUser_type() == 1) { //일반 회원일 경우
			return new ModelAndView("mentoringView/myMentoringMemberOnly")
					.addObject("member", mbdto);
		}else if (mbdto.getUser_type() == 3) { // 관리자일 경우
			return new ModelAndView("mentoringView/myMentoringMemberOnly")
					.addObject("member", mbdto);
		}else {
			return new ModelAndView("/");
		}
		
	}
	
	//맞춤 멘토 페이지로 이동
	@GetMapping("/custom-mentor")
	public ModelAndView go_custom_mentor(HttpServletRequest request) {
		System.out.println("컨트롤러 : 맞춤멘토 페이지로 이동합니다.");
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		String summoner_name = mbdto.getLol_account();
		SummonerDto sd = summonerService.get_summoner_info(summoner_name);
		String lowerTier = sd.getTier();
		String upperTier = lowerTier.toUpperCase();
		sd.setTier(upperTier);
		List<TagListDTO> target_tag = tagdao.select_by_tag_type("target");
		List<TagListDTO> class_method_tag = tagdao.select_by_tag_type("class_method");
		List<TagListDTO> style_tag = tagdao.select_by_tag_type("style");
		List<TagListDTO> style2_tag = tagdao.select_by_tag_type("style2");
		List<TagListDTO> careers_tag = tagdao.select_by_tag_type("careers");
		return new ModelAndView("mentoringView/customMentor") 
				.addObject("target_tag", target_tag)
				.addObject("class_method_tag", class_method_tag)
				.addObject("style_tag", style_tag)
				.addObject("style2_tag", style2_tag)
				.addObject("careers_tag", careers_tag)
				.addObject("summoner", sd)
				.addObject("member", mbdto);
	}
	
	//멘토 찾기 페이지로 이동
	@GetMapping("/list")
    public String go_find_mentor() {
		System.out.println("컨트롤러 : 멘토찾기 페이지로 이동합니다.");
        return "mentoringView/mentorSearch";
    }
	
	//멘토 아이디를 입력해서 멘토 프로필 페이지로 이동
	@GetMapping("/profile/{lol_account}")
    public ModelAndView go_mentor_profile(@PathVariable String lol_account, HttpServletRequest request) {
		System.out.println("컨트롤러 : 멘토 프로필 페이지로 이동합니다.");
		HttpSession session = request.getSession(); // 현재 접속중인 회원의 아이디 확인
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		List<MemberDto> mbList = mbService.findUserLolAccount(lol_account);
		String mentor_email = mbList.get(0).getEmail();
		List<MentorClassDTO> mentor_class_list = mtpService.select_by_email_mentor_class(mentor_email);
		MentorProfileDTO mtp = mtpdao.select_by_email_mentor_profile(mentor_email);
		List<LikeMentorDTO> like_mentor_list = myMtDao.select_by_email_like_mentor(email);
		return new ModelAndView("mentoringView/mentorInfo")
				.addObject("mentor_profile", mtp) //해당 페이지 멘토 프로필
				.addObject("class_list", mentor_class_list) //해당 페이지 멘토 클래스
				.addObject("mentor", mbList.get(0)) //해당 페이지 멘토 회원정보
				.addObject("member", mbdto) //접속한 사람 회원정보
				.addObject("like_mentor", like_mentor_list); //접속한 사람 찜한 멘토 목록
    }
	
	//멘토 프로필 작성 페이지로 이동
	@GetMapping("/write-profile")
    public ModelAndView go_mentor_profile_edit(HttpServletRequest request) {
		System.out.println("컨트롤러 : 멘토 프로필 작성 페이지로 이동합니다.");
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		Integer user_type = (Integer)session.getAttribute("user_type");
		MentorProfileDTO mtp = mtpdao.select_by_email_mentor_profile(email);
		MemberDto mbdto = mbdao.getMemberInfo(email);
		List<MentorClassDTO> mentor_class_list = mtpService.select_by_email_mentor_class(email);
		List<TagListDTO> tagList = mtpService.select_all_tag();
		if (user_type==2) { //멘토 회원인 경우에만 접근 허용
			if(mtp == null) { //프로필이 없는 경우 빈 프로필 생성
				mtpService.insert_mentor_profile(email);
				return new ModelAndView("mentoringView/mentorProfileForm") 
						.addObject("mentor_profile", mtp)
						.addObject("tag_list", tagList)
						.addObject("class_list", mentor_class_list)
						.addObject("member", mbdto);
			}else {
			return new ModelAndView("mentoringView/mentorProfileForm") 
					.addObject("mentor_profile", mtp)
					.addObject("tag_list", tagList)
					.addObject("class_list", mentor_class_list)
					.addObject("member", mbdto);
			}
		}else {
			return new ModelAndView("redirect:/member/changeUserType");
		}
    }
}
