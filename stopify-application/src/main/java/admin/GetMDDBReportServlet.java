package admin;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetID3ReportServlet
 */
@WebServlet(urlPatterns="/GetMDDBReportServlet")
public class GetMDDBReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetMDDBReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			FileReader fr = new FileReader("logDB.txt");
			int i;
			StringBuilder sb = new StringBuilder();
			sb.append("");
			while((i=fr.read())!=-1) {
				sb.append((char)i);
			}
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(sb.toString());
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}

}
