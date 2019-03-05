package lucene;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import ICTCLAS_Analyzer.*;

public class Search {

    final private static String indexPath = "D:/2017.2/searchEngine/index";

    private static Directory directory;
    private static Analyzer analyzer;

    public static ArrayList<Map<String,String>> search(String text) throws IOException{

        analyzer = new NLPIRTokenizerAnalyzer("", 1, "", "", false);
        directory = FSDirectory.open(Paths.get(indexPath));
        DirectoryReader reader = DirectoryReader.open(directory);
        IndexSearcher searcher = new IndexSearcher(reader);
        QueryParser parser = new QueryParser("contents", analyzer);
        ArrayList<Map<String, String>> result = new ArrayList<>();
        String contents;

        try{
            Query query = parser.parse(text);
            ScoreDoc[] hits = searcher.search(query, 1000000).scoreDocs;
            for (int i = 0; i < hits.length; i++) {
                Document hitDoc = searcher.doc(hits[i].doc);

                Map<String,String> map = new HashMap<>();
                map.put("url", hitDoc.get("url"));
                String strTitle = hitDoc.get("title");
                strTitle = hightlight(text, strTitle);
                map.put("title", strTitle);
                map.put("subjectid", hitDoc.get("subjectid"));
                map.put("publishid", hitDoc.get("publishid"));
                String strDesc = hitDoc.get("description");
                strDesc = hightlight(text, strDesc);
                map.put("description", strDesc);
                String strKeyword = hitDoc.get("keywords");
                strKeyword = hightlight(text, strKeyword);
                map.put("keywords", strKeyword);
                String score = Float.toString(hits[i].score);
                score = score.substring(0, 5);
                map.put("score", score);
                contents = hitDoc.get("contents");
                if(contents.length() > 200)
                    contents = contents.substring(0, 200) + "...";
                contents = hightlight(text, contents);

                map.put("contents", contents);
                result.add(map);
            }

            reader.close();
            directory.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 为了搜索结果的
    private static String hightlight(String text, String data)throws IOException{
        // 防止token生成错误,设立flag
        // flag = true - 已找到匹配
        //      = false - 尚未找到匹配
        boolean flag = false;
        if(data == null)
            return data;
        NLPIRTokenizerAnalyzer nta = new NLPIRTokenizerAnalyzer("", 1, "", "", false);
        TokenStream ts = nta.tokenStream("word", text);
        ts.reset();
        CharTermAttribute term = ts.getAttribute(CharTermAttribute.class);
        while(ts.incrementToken()){
            String pattern = term.toString();

            if(pattern.equals(""))
                break;
            if(data.indexOf(pattern) < 0)
                break;
            flag = true;
            data = data.replaceAll(pattern, "<font color=\"red\">" + pattern + "</font>");
        }
        ts.end();
        ts.close();
        nta.close();
        // 万一生成token的时候出错,导致没有匹配,那么就再试一下text本身.
        if(flag == false && data.indexOf(text) > -1)
            data = data.replaceAll(text, "<font color=\"red\">" + text + "</font>");
        return data;
    }

}
