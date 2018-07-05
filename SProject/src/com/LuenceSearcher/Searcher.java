package com.LuenceSearcher;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

public class Searcher {
	public static void main(String[] args) throws IOException, ParseException{
		Searcher s=new Searcher();
		s.Search("中国");
	}
	public Searcher() throws IOException{
		this.dir="";
		Initial();
	}
	public Searcher(String dir) throws IOException{
		this.dir=dir+"/";
		Initial();
	}
	private void Initial() throws IOException{
		Directory directory = FSDirectory.open(Paths.get("E:/test.git/SProject/WebContent/LuenceDoc"));
		DirectoryReader ireader = DirectoryReader.open(directory);
	    this.isearcher = new IndexSearcher(ireader);
	    
	}
public ArrayList<Document> Search(String query) throws ParseException, IOException{
	ArrayList<Document> target=new ArrayList<Document>();
	Query q=qp.parse(query);
	ScoreDoc[] hits = isearcher.search(q, 50).scoreDocs;
	for(ScoreDoc s:hits){
		target.add(isearcher.doc(s.doc));
		//System.out.println(isearcher.doc(s.doc).getField("Img").stringValue());
	}
	return target;
	
}
private String dir;
private IndexSearcher isearcher=null;
private QueryParser qp=new QueryParser("summary", new SmartChineseAnalyzer());
}
