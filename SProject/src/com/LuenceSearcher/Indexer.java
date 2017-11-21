package com.LuenceSearcher;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import com.beans.SDataBean;
import com.google.gson.Gson;

import org.apache.lucene.analysis.cn.*;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;

import java.io.*;
import java.nio.file.Paths;
import java.util.*;
public class Indexer {
public static void main(String[] args )throws Exception{
	Directory directory = FSDirectory.open(Paths.get("WebContent/LuenceDoc"));
	
	IndexWriterConfig conf=null;
	try{
		 conf= new IndexWriterConfig(new SmartChineseAnalyzer());
	}
	catch(Exception e){
		System.out.println(e.getMessage());
	}
			
	 	IndexWriter w=new IndexWriter(directory,conf);
	 	ArrayList<Document> docs=getDocument();
	 	for(Document d:docs)
	 		w.addDocument(d);
	 	w.close();
	
}

private static ArrayList<Document> getDocument() throws IOException,FileNotFoundException{
	ArrayList<Document> docs=new ArrayList<Document>();
	InputStreamReader in=new InputStreamReader(new FileInputStream(new File("WebContent/ExcTarget/ktest.txt")));
	String tempLine="";
	BufferedReader buf=new BufferedReader(in);
	Gson g=new Gson();
	int count=0;
	while((tempLine=buf.readLine())!=null){
		try{
			SDataBean s=g.fromJson(tempLine, SDataBean.class);
			Document doc=new Document();
			doc.add(new Field("summary",s.getSummary(),TextField.TYPE_STORED));
			doc.add(new Field("author",s.getAuthor(),TextField.TYPE_STORED));
			doc.add(new Field("tags",(s.getTags().size()==2)?s.getTags().get(0)+"/"+s.getTags().get(1):"nothing",TextField.TYPE_STORED));
			doc.add(new Field("price",s.getPrice(),TextField.TYPE_STORED));
			doc.add(new Field("rating",s.getRating(),TextField.TYPE_STORED));
			doc.add(new Field("Img",s.getImg(),TextField.TYPE_STORED));
			doc.add(new Field("isbn",s.getIsbn(),TextField.TYPE_STORED));
			doc.add(new Field("bookname",s.getTitle(),TextField.TYPE_STORED));
			docs.add(doc);
		}
		catch(Exception e){
			count++;
			continue;
		}
		
	}
	System.out.println(count);
	return docs;
	
}

}
