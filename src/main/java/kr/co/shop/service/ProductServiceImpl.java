package kr.co.shop.service;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.shop.mapper.ProductMapper;
import kr.co.shop.vo.BaesongVO;
import kr.co.shop.vo.DaeVO;
import kr.co.shop.vo.GumaeVO;
import kr.co.shop.vo.JungVO;
import kr.co.shop.vo.MemberVO;
import kr.co.shop.vo.ProductVO;
import kr.co.shop.vo.ProductViewVO;
import kr.co.shop.vo.QuestionVO;
import kr.co.shop.vo.ReviewVO;
import kr.co.shop.vo.SoVO;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductMapper mapper;
	@Override
	public String pro_write(Model model) {
		// dae 테이블을 읽어와서 view에 전달
		ArrayList<DaeVO> list=mapper.pro_write();
		model.addAttribute("list",list);
		return "/product/pro_write";
	}
	
	@Override
	public void getjung(HttpServletRequest request, PrintWriter out) {
		String daecode=request.getParameter("daecode");
		ArrayList<JungVO> list=mapper.getjung(daecode);
		//option태그를 생성해도 전달
		String str="";
		//ArrayList => list.get(0) ..
		for(int i=0;i<list.size();i++) {
			JungVO jvo=list.get(i);
			//문자열과 변수는 +연산을 통해 연결
			str=str+"<option value='"+jvo.getCode()+"'>"+URLEncoder.encode(jvo.getTitle())+"</option>";
									// <option value='01'> 야채류 </option>
		}
		out.print(str);
	}
	@Override
	public void getso(HttpServletRequest request,PrintWriter out) {
		String daejung=request.getParameter("daejung");
		ArrayList<SoVO> list = mapper.getso(daejung);
		String str="";
		for(int i=0;i<list.size();i++) {
			SoVO svo=list.get(i);
			str=str+"<option value='"+svo.getCode()+"'>"+URLEncoder.encode(svo.getTitle())+"</option>";
		}
		out.print(str);
	}
	
	@Override
	public void getbunho(HttpServletRequest request,PrintWriter out) {
		String code=request.getParameter("code");
		Integer bunho=mapper.getbunho(code);
		out.print(bunho);
	}
	
	@Override
	public String product_ok(HttpServletRequest request) {
		//product테이블에 pvo에있는값들을 저장
		String path=request.getRealPath("resources/img");
		int size=1024*1024*20;
		ProductVO pvo=new ProductVO();
		try {
		MultipartRequest multi=new MultipartRequest
				(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		//폼값 가져오기 => ProductVO에 넣기
			pvo.setPcode(multi.getParameter("pcode"));
			pvo.setPimg(multi.getFilesystemName("pimg"));
			pvo.setCimg(multi.getFilesystemName("cimg"));
			pvo.setTitle(multi.getParameter("title"));
			pvo.setPrice(Integer.parseInt(multi.getParameter("price")));
			pvo.setMade(multi.getParameter("made"));
			pvo.setHalin(Integer.parseInt(multi.getParameter("halin")));
			pvo.setJuk(Integer.parseInt(multi.getParameter("juk")));
			pvo.setSu(Integer.parseInt(multi.getParameter("su")));
			pvo.setBaesong(Integer.parseInt(multi.getParameter("baesong")));
			pvo.setBaeday(Integer.parseInt(multi.getParameter("baeday")));
		} catch(Exception e) {
			// return "redirect:error";
		}
		mapper.product_ok(pvo);
		return "product/pro_list";
	}
	
	@Override
	public String pro_list(HttpServletRequest request,Model model) {
		//필요한 상품리스트를 가져와서 view에 전달
		String pcode=request.getParameter("pcode");
		ArrayList<ProductVO> list=mapper.pro_list(pcode);
		model.addAttribute("list",list);
		return "/product/pro_list";
	}
	
	@Override
	public String pro_content(HttpSession session,HttpServletRequest request,Model model) {
		// 하나의 에코드를 읽어와서 model에 전달 view를 리턴
		String pcode=request.getParameter("pcode");
		ProductVO pvo=mapper.pro_content(pcode);
		model.addAttribute("pvo",pvo);
		
		//현재상품의 review를전부 읽어오기
		ArrayList<ReviewVO> rlist=mapper.getReview(pcode);
		for(int i=0;i<rlist.size();i++)
		{
			rlist.get(i).setContent(rlist.get(i).getContent().replace("\r\n", "<br>"));
			// 아이디 4자 + **
			//String imsi=rlist.get(i).getUserid().substring(0,4)+"**";
			//rlist.get(i).setUserid(imsi);
		}
		model.addAttribute("rlist",rlist);
			// 총별점
		if(rlist.size()!=0) // 비어있을경우 실행X
			model.addAttribute("chong_star",rlist.get(0).getAvg());
		//현재 사용자의 wush테이블에 상품이 저장되어있는지 확인해서 view에전달
		int wishcnt;
		if(session.getAttribute("userid")==null) {
			wishcnt=0;
		} else {
			String userid=session.getAttribute("userid").toString();
			int num=mapper.checkwish(userid,pcode);
			if(num==0) {
				wishcnt=0;
			}else {
				wishcnt=1;
			}
		}
		model.addAttribute("wishcnt",wishcnt);
		//상품문의 읽어서 전달
		ArrayList<QuestionVO> qlist=mapper.getQuestion(pcode);
		/*content 에 br붙이기*/
		for(int i=0;i<qlist.size();i++) {
			qlist.get(i).setContent(qlist.get(i).getContent().replace("\r\n", "<br>"));
		}
		model.addAttribute("qlist",qlist);
		return "/product/pro_content";
	}
	
	@Override
	public void wish_add(HttpSession session, HttpServletRequest request,PrintWriter out) {
		String userid=session.getAttribute("userid").toString();
		String pcode=request.getParameter("pcode");
		
		mapper.wish_add(userid, pcode);
		
		out.print("0");
	}
	
	@Override
	public void cart_add(HttpSession session, HttpServletRequest request,PrintWriter out) {
		String userid=session.getAttribute("userid").toString();
		String pcode=request.getParameter("pcode");
		String su=request.getParameter("su");
		
		mapper.cart_add(userid,pcode,su);
		out.print("0");
	}
	
	@Override
	public String pro_gumae(HttpServletRequest request,Model model,HttpSession session) {
		//해당상품의 정보를 뷰에 전달
		String[] pcode=request.getParameter("pcode").split(",");
		String[] su=request.getParameter("su").split(",");
		String gchk=request.getParameter("gchk");
		ArrayList<ProductVO> list=new ArrayList<ProductVO>();
		for(int i=0;i<pcode.length;i++) {
			ProductVO pvo=mapper.pro_gumae(pcode[i]);
			pvo.setSu(Integer.parseInt(su[i]));
			list.add(pvo);
		}
		model.addAttribute("gchk",gchk);
		model.addAttribute("list",list);
		//model.addAttribute("su",su);
		
		//회원정보
		String userid=session.getAttribute("userid").toString();
		MemberVO mvo=mapper.getmember(userid);
		model.addAttribute("mvo",mvo);
			
		//배송지정보
		BaesongVO bvo=mapper.getbaesong(userid);
		model.addAttribute("bvo",bvo);
		return "/product/pro_gumae";
	}
	
	@Override //배송지테이블에 정보가 없을때 한번 사용
	public void bae_chuga(HttpSession session,PrintWriter out) {
		// member테이블에서 필요한 정보를 읽어온다.
		String userid=session.getAttribute("userid").toString();
		MemberVO mvo=mapper.getmember(userid);
		// member테이블의 주소를 baesong테이블에 전달 
		
		mapper.bae_chuga(mvo);
		// out을 통해 주소를 view에 전달
		String str="";	//ex :  홍길동,고양시 ..... , 01055555555
		str=URLEncoder.encode(mvo.getName())+",";
		str=str+URLEncoder.encode(mvo.getJuso())+" "+URLEncoder.encode(mvo.getJuso_etc())+",";
		str=str+mvo.getPhone();
		
		str=str.replace("+", " ");
		
		out.print(str);
	}
	
	@Override
	public String baesong_list(HttpSession session,Model model) {
		//배송테이블에서 해당 사용자의 주소를 전부 가져와서 전달
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongVO> list=mapper.baesong_list(userid);
		model.addAttribute("list",list);
		return "/product/baesong_list";
	}
	
	@Override
	public String juso_add_ok(BaesongVO bvo,HttpSession session) {
		bvo.setUserid(session.getAttribute("userid").toString());
		mapper.juso_add_ok(bvo);
		
		return "redirect:/product/baesong_list";
	}
	
	@Override
	public String baesong_edit(HttpServletRequest request,Model model) {
		String id=request.getParameter("id");
		BaesongVO bvo=mapper.baesong_edit(id);
		model.addAttribute("bvo",bvo);
		return "/product/baesong_edit";
	}
	
	@Override
	public String basong_edit_ok(BaesongVO bvo) {
		mapper.baesong_edit_ok(bvo);
		return "redirect:/product/baesong_list";
	}
	
	@Override
	public String pro_gumae_ok(GumaeVO gvo,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		gvo.setUserid(userid);
		
		
		// 주문번호생성 => 아이디+4자리
		// 가장 높은 주문번호를 가져오기
		Integer number=mapper.getjumun(userid);
		number++;
		
		String num=number.toString();
		if(num.length()==1) {
			num="000"+num;
		} else if(num.length()==2) {
			num="00"+num;
		} else if(num.length()==3) {
			num="0"+num;
		}
		String jumuncode=userid+num;
		
		gvo.setJumuncode(jumuncode);
		
		// pcode,su,chong금액을 배열로저장
		String[] pcode=gvo.getPcode().split(",");
		String[] su=gvo.getSu_imsi().split(",");
		String[] chong=gvo.getChong_imsi().split(",");
		//위의 배열의 있는값을 gvo의 pcode,su,chong setter
		for(int i=0;i<pcode.length;i++) {
			gvo.setPcode(pcode[i]);
			gvo.setSu(Integer.parseInt(su[i]));
			gvo.setChong(Integer.parseInt(chong[i]));
			mapper.pro_gumae_ok(gvo);
			if(gvo.getGchk()==2) {
				//cart테이블에서 삭제
				mapper.cart_del(pcode[i],userid);
			} else if(gvo.getGchk()==1){
				//wish테이블에서 삭제
				mapper.wish_cancel(pcode[i],userid);
			}
		}
		return "redirect:/product/product_view?jumuncode="+jumuncode;
	}
	
	@Override
	public String product_view(HttpServletRequest request,Model model) {
		//구매정보를 전달
		String jumuncode=request.getParameter("jumuncode");
		ArrayList<ProductViewVO> list=mapper.product_view(jumuncode);
		model.addAttribute("list",list);
		return "/product/product_view";
	}
	
	@Override
	public String wish_cancel(HttpSession session,HttpServletRequest request) {
		String pcode=request.getParameter("pcode");
		//이메일 구하기
		String userid=session.getAttribute("userid").toString();
		mapper.wish_cancel(pcode,userid);
		return "redirect:/product/pro_content?pcode="+pcode;
	}
	@Override
	public String qwrite_ok(QuestionVO qvo,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		// 이메일 구하기
		String email=mapper.getEmail(userid);
		qvo.setEmail(email);
		
		//grp구하기
		int grp=mapper.getGrp();
		grp++;
		qvo.setGrp(grp);
		//question테이블에 저장
		mapper.qwrite_ok(qvo);
		return "redirect:/product/pro_content?pcode="+qvo.getPcode();
	}
}
