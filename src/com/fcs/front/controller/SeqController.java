package com.fcs.front.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.FrontLoginInterceptor;
import com.fcs.core.model.User;
import com.fcs.front.model.Answer;
import com.fcs.front.model.Seq;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class SeqController extends Controller{
	
	public void index(){
		String typeId = StringTools.getNoneNullString(getPara("type"));
		String strPage = getPara("page");
		int pageNo = 1;
		int pageSize = 8;
		String[] params = null;
		String where = "";
		if(strPage!=null){
			int intPage = Integer.parseInt(strPage);
			if(intPage>1){
				pageNo = intPage;
			}
		}
		if(!typeId.equals("")){
			where = "s.author=u.f_id and typeId=?";
			params = new String[1];
			params[0] = typeId;
		}else{
			where = "s.author=u.f_id";
		}
		String cols = "s.*,TIMESTAMPDIFF(hour,s.pubTime,now()) as sub,TIMESTAMPDIFF(minute,s.pubTime,now()) as subm,u.f_name";
		Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_seq s ,t_user u",cols, where, "s.pubTime desc", params);
		int total = pageSet.getTotalRow();
		int totalPage = (total-1)/pageSize+1;
		setAttr("seqList",pageSet.getList());
		setAttr("current",pageNo);
		setAttr("total",total);
		setAttr("totalPage",totalPage);
		render("seq.jsp");
	}
	
	public void detail(){
		String id = getPara("id");
		Seq seq = Seq.me.findById(id);
		User user = User.dao.findById(seq.getStr("author"));
		List<Record> answerList = Answer.me.findBySeq2(id);
		setAttr("seq",seq );
		setAttr("user", user);
		setAttr("answerList",answerList );
		render("seq_detail.jsp");
	}
	
	/**
	 * TODO 默认情况下直接发表回答
	 * 严格模式下应该审核
	 */
	public void answer(){
		HttpServletRequest request = getRequest();
		Answer answer = null;
		try {
			answer = getModel(Answer.class);
			String id = UUIDGenerator.getUUID();
			User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			answer.set("id", id);
			answer.set("author", user.getStr("f_id"));
			answer.set("pubTime", date);
			boolean flag = answer.save();
			if(flag){//回答数加一
				Seq seq = Seq.me.findById(answer.getStr("seqId"));
				seq.set("answerNum", seq.getInt("answerNum")+1);
				seq.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirect("/seq/detail?id="+answer.getStr("seqId"));
	}
	
	@Before(FrontLoginInterceptor.class)
	public void toAdd(){
		render("seq_add.jsp");
	}
	
	public void add(){
		HttpServletRequest request = getRequest();
		try {
			Seq seq = getModel(Seq.class);
			String id = UUIDGenerator.getUUID();
			User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			seq.set("id", id);
			seq.set("author", user.getStr("f_id"));
			seq.set("pubTime", date);
			seq.save();
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirect("/seq/index");
	}
	
	
}
