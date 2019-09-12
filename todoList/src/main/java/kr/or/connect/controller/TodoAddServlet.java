package kr.or.connect.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.connect.dao.TodoDao;
import kr.or.connect.dto.TodoDto;

public class TodoAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("registerName");
		String title = request.getParameter("registerTodo");
		int sequence = Integer.parseInt(request.getParameter("registerSequence"));
		
		TodoDto dto = new TodoDto();
		dto.setName(name);
		dto.setSequence(sequence);
		dto.setTitle(title);
		dto.setType("TODO");
		
		TodoDao dao = new TodoDao(); 
		dao.addTodo(dto);
		
		response.sendRedirect("MainServlet");
	}

}
