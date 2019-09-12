package kr.or.connect.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import kr.or.connect.dao.TodoDao;
import kr.or.connect.dto.TodoDto;

public class TodoTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		Long id = null;
		String type = "";

		InputStream inputStream = request.getInputStream();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
		
		String jsonData = bufferedReader.readLine();
		
		JSONParser parer = new JSONParser();
		JSONObject object;
				
		try {
			object = (JSONObject) parer.parse(jsonData);
			id = (Long) object.get("id");
			type = (String) object.get("type");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if (type.equals("TODO")) {
			type = "DOING";
		} 
		else if (type.equals("DOING")) {
			type = "DONE";
		}

		// update
		TodoDto dto = new TodoDto();
		dto.setId(id);
		dto.setType(type);
		
		TodoDao dao = new TodoDao();
		dao.updateTodo(dto);

		response.sendRedirect("MainServlet");
	}
}
