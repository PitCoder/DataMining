package admin;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

/**
 * Servlet implementation class CreateMDDBServlet
 */
@WebServlet(urlPatterns="/CreateMDDBServlet")
public class CreateMDDBServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateMDDBServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintStream output = new PrintStream(new File("logDB.txt"));		
		AdminDashboardService admonservice = new AdminDashboardService();
		PrintStream console = System.out;
		System.setOut(console);
		
		HashMap<String,ArrayList<ArrayList<String>>> dimensions = new HashMap<String,ArrayList<ArrayList<String>>>();
		HashMap<String,ArrayList<ArrayList<String>>> measures = new HashMap<String,ArrayList<ArrayList<String>>>();
		ArrayList<String> set = new ArrayList<>();
		ArrayList<ArrayList<String>> setData = new ArrayList<>();
		String data = "";
		String name = "";
		
		try {
		    BufferedReader reader = request.getReader();
		    JSONArray jsonArray = new JSONArray(reader.readLine());
		    JSONArray innerJsonArray;
		    JSONArray deeperJsonArray;
		    JSONArray finalJsonArray;
		    
		    for(int i = 0; i < jsonArray.length(); i++) {
		    	innerJsonArray = jsonArray.getJSONArray(i);
		    	if(i == 0) {
		    		for(int j = 0; j < innerJsonArray.length(); j++) {
		    			deeperJsonArray = innerJsonArray.getJSONArray(j);
		    			for(int k = 0; k < deeperJsonArray.length(); k++) {
		    				if(k == 0) {
		    					name = deeperJsonArray.getString(k);
		    					setData = new ArrayList<ArrayList<String>>();
		    					dimensions.put(name, setData);
		    					System.out.println(name);
		    				}
		    				else {
		    					finalJsonArray = deeperJsonArray.getJSONArray(k);
		    					set = new ArrayList<>();
		    					for(int w=0; w < finalJsonArray.length(); w++) {
		    						data = finalJsonArray.getString(w);
		    						set.add(data);
		    						System.out.println(data);
		    					}
		    					setData.add(set);
		    					System.out.println("");
		    				}
		    			}
		    			dimensions.replace(name, setData);
		    		}
		    	}
		    	else {
		    		for(int j = 0; j < innerJsonArray.length(); j++) {
		    			deeperJsonArray = innerJsonArray.getJSONArray(j);
		    			for(int k = 0; k < deeperJsonArray.length(); k++) {
		    				if(k == 0) {
		    					name = deeperJsonArray.getString(k);
		    					setData = new ArrayList<ArrayList<String>>();
		    					measures.put(name, setData);
		    					System.out.println(name);
		    				}
		    				else {
		    					finalJsonArray = deeperJsonArray.getJSONArray(k);
		    					set = new ArrayList<>();
		    					for(int w=0; w < finalJsonArray.length(); w++) {
		    						data = finalJsonArray.getString(w);
		    						set.add(data);
		    						System.out.println(data);
		    					}
		    					setData.add(set);
		    					System.out.println("");
		    				}
		    			}
		    			measures.replace(name, setData);
		    		}	
			    }
		     }
		    System.setOut(output);
		    admonservice.createMDDB(dimensions, measures);
		    System.setOut(console);
		  }
		  catch (IOException e) { 
			  e.printStackTrace();
		  }
	}

}
