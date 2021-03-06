package com.secubot.article.command;

import java.util.HashMap;
import java.util.Map;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.ParseConversionEvent;

import com.secubot.article.model.Writer;
import com.secubot.article.service.WriteArticleService;
import com.secubot.article.service.WriteRequest;
import com.secubot.noti.service.UpdateMyNotiService;
import com.secubot.auth.service.User;
import com.secubot.mvc.command.CommandHandler;

public class WriteArticleHandler implements CommandHandler {

	private static final String FORM_VIEW = "/WEB-INF/aside/desk/writeComplaints.jsp";
	private WriteArticleService writeService = new WriteArticleService();
	private UpdateMyNotiService notiService = new UpdateMyNotiService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		} else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}
	
	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}
	
	private String processSubmit(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Boolean> errors = new HashMap<>();
		req.setAttribute("errors", errors);
		
		User user = (User)req.getSession(false).getAttribute("authUser");
		WriteRequest writeReq = createWriteRequest(user, req);
		writeReq.validate(errors);
		
		if (!errors.isEmpty()) {
			return FORM_VIEW;
		}
		
		int newArticleNo = writeService.write(writeReq);
		//notiService.insert(newArticleNo, writeReq); 
		req.setAttribute("newArticleNo", newArticleNo);
		
		return "/WEB-INF/aside/desk/writeSuccess.jsp";
	}
	
	private WriteRequest createWriteRequest(User user, HttpServletRequest req) {
		return new WriteRequest(
				new Writer(user.getId(), user.getName(), user.getEmail()),
				req.getParameter("title"),
				req.getParameter("content"),
				req.getParameter("type").equals("TCP")?0:1, // TCP=0, UDP=1
				req.getParameter("src_ip"),
				req.getParameter("dst_ip"),
				Integer.parseInt(req.getParameter("dst_port")),
				new Date());
	}
}
