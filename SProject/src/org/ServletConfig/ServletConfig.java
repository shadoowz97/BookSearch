package org.ServletConfig;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.LuenceSearcher.Searcher;
import com.ansj.vec.Word2VEC;

public class ServletConfig implements ServletContextListener{

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		
		
	}


	public void contextInitialized(ServletContextEvent event) {
		
		System.out.println("Sproject application is initialized!");
		ServletContext context=event.getServletContext();
		Word2VEC w2v=new Word2VEC();
		try {
			w2v.loadJavaModel("D:/j2ee/SProject/WebContent/ExcTarget/vector.mod");
			System.out.println("Successful!");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		context.setAttribute("wv", w2v);
		Searcher searcher = null;
		try {
		searcher=new Searcher();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		context.setAttribute("searcher", searcher);
	}

	
	

}
