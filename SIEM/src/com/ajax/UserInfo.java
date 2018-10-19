package com.ajax;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jdbc.connection.ConnectionProvider;
import jdbc.JdbcUtil;
import member.dao.MemberDao;

@WebServlet("/user")
public class UserInfo extends HttpServlet {

	Connection conn = null;
	MemberDao memberDao = null;
	
	public void init() throws ServletException {
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException {
		try {
			PrintWriter out = res.getWriter();
			out.println("Hello");
			conn = ConnectionProvider.getConnection();
			memberDao = new MemberDao();
			int countNum = 0;
			countNum = memberDao.select(conn); // TODO: MemberDao에 List<Member>에 회원정보 담아서 반환하는 메서드 만들기
			
			res.getWriter().write("Hello");
			req.getSession().setAttribute("userCount", countNum);
		} catch(SQLException e) {
			JdbcUtil.rollback(conn);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException {
		
	}
}
