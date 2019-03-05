package lucene;

import java.io.*;

import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.ArrayList;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field.Store;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig.OpenMode;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.*;
import org.jsoup.Jsoup;

import ICTCLAS_Analyzer.*;

public class Index{
    // indexPath - 存放index
	final public static String indexPath = "D:/2017.2/searchEngine/index";
    // originDataPath - 存放.txt
	final private static String originDataPath = "D:/2017.2/searchEngine/originData";

    final private static String[] uselessTags = {"<a ","</a>","<em>","</em>","<span ","</span>","<strong>","</strong>","<iframe ","</iframe>","&nbsp"};
    final private static Pattern ptTitle = Pattern.compile("(<title>)(.*)(</title>)");
    final private static Pattern ptUrl = Pattern.compile("(<url>)(.*)(</url>)");
    final private static Pattern ptHtml = Pattern.compile("(<[^>]*>)");

	private static Analyzer analyzer;
	private static Directory ramDirectory;              // 在RAM中进行操作,加快速度,最后将创建的索引放在磁盘上.
	private static Directory fsDirectory;               // 最后存在这里
	private static IndexWriterConfig iwc;
	private static IndexWriter writer;
    private static File[] files;

    // 初始化
    private static void init()throws IOException {
        ramDirectory = new RAMDirectory();
        analyzer = new NLPIRTokenizerAnalyzer("", 1, "", "", false);
        iwc = new IndexWriterConfig(analyzer);
        iwc.setOpenMode(OpenMode.CREATE_OR_APPEND);
        iwc.setRAMBufferSizeMB(4096.0);
        writer = new IndexWriter(ramDirectory, iwc);
        files = new File(originDataPath).listFiles();
        fsDirectory = FSDirectory.open(Paths.get(indexPath));
    }

    // 过滤无效标签
	public static String filterTags(String s){
	    StringBuilder sb = new StringBuilder(s);
	    // uselessTags中的前五对一起处理
	    for(int i = 0; i < 10; i+=2){
            int j = sb.indexOf(uselessTags[i]);
            // 一直删除,直到sb里找不到.
	        while(j > -1) {
	            int k = sb.indexOf(uselessTags[i + 1]);
	            if(k < 0) {
                    sb.delete(j, j + uselessTags[i].length());
                    j = sb.indexOf(uselessTags[i]);
                    continue;
                }
                if (k <= j) {
                    sb.delete(k, k + uselessTags[i + 1].length());
                    continue;
                }
                sb.delete(j, k + uselessTags[i + 1].length());
                j = sb.indexOf(uselessTags[i]);
            }
        }
        //"&nbsp" 单独处理
        String nbsp = "&nbsp;";
	    int i = sb.indexOf(nbsp);
        while(i > -1) {
            sb.delete(i, i + nbsp.length());
            i = sb.indexOf(nbsp);
        }
	    return sb.toString();
    }

    // 预处理文件,去掉无效标签,
    // 针对有效标签,以及content
    // 创建索引,存入writer
	public static void createIndexPerFile(File file) throws IOException{
        BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));

        // count - 统计docs数量,方便输出进度
        int count = 0;
        String content;
        boolean flag = false;
        while((content = br.readLine()) != null) {
            // 一次循环处理一个doc
            if(!content.equals("<doc>"))
                continue;
            if(count %400 == 0){
                // 输出进度,每400个doc输出一个'.'
                System.out.print(".");
            }
            count++;

            Document docLucene = new Document();
            StringBuffer body = new StringBuffer();
            //
            while((content = br.readLine()) != null){
                // 过滤无效标签
                content = filterTags(content);
                if(content.length() == 0)
                    // blank
                    continue;
                if(content.equals("</doc>")) {
                    // </doc> - doc结束
                    break;
                }
                if(content.charAt(0) != '<'){
                    // 找到content body,加入StringBuffer
                    body.append(content);
                    continue;
                }
                if(content.charAt(1) == 'm'){
                    // <meta attr>
                    org.jsoup.nodes.Document doc = Jsoup.parse(content);
                    org.jsoup.select.Elements attribute = doc.select("meta");
                    if(attribute.size() == 0)
                        continue;
                    if(attribute.attr("name").equals("keywords"))
                        docLucene.add(new TextField("keywords", attribute.attr("content"), Store.YES));
                    else if(attribute.attr("name").equals("description") && (docLucene.get("description")==null || docLucene.get("description").length() == 0))
                        docLucene.add(new TextField("description", attribute.attr("content"), Store.YES));
                    else if(attribute.attr("name").equals("publishid")&& (docLucene.get("publishid")==null || docLucene.get("publishid").length() == 0))
                        docLucene.add(new StringField("publishid", attribute.attr("content"), Store.YES));
                    else if(attribute.attr("name").equals("subjectid")&& (docLucene.get("subjectid")==null || docLucene.get("subjectid").length() == 0))
                        docLucene.add(new StringField("subjectid", attribute.attr("content"), Store.YES));
                }
                else{
                    Matcher m = ptTitle.matcher(content);
                    String tmp;
                    if(m.find()){
                        tmp = m.group(2).trim();
                        if(docLucene.get("title") == null || docLucene.get("title").length() == 0)
                        docLucene.add(new TextField("title", tmp, Store.YES));
                    }
                    m = ptUrl.matcher(content);
                    if(m.find()){
                        tmp = m.group(2).trim();
                        if(docLucene.get("url") == null || docLucene.get("url").length() == 0)
                        docLucene.add(new StringField("url", tmp, Store.YES));
                    }
                }
            }

            // 删除意料之外的标签.
            Matcher m = ptHtml.matcher(body);
            StringBuffer sb = new StringBuffer();
            while(m.find()){
                // 用StringBuffer,不用StringBuilder的原因,就在于这里要用前者.
                // 将m匹配到的部分用""替代,并且把""与""之间的部分加到sb里.
                m.appendReplacement(sb, "");
            }
            // 将body剩下的部分加入到sb中.
            m.appendTail(sb);
            body = sb;

            // 标签彻底处理完毕
            docLucene.add(new TextField("contents", body.toString(), Store.YES));
            flag = false;
            try {
                writer.addDocument(docLucene);

            }catch(RuntimeException e){
                System.out.println(docLucene.getField("title"));
                flag = true;
//                writer.delete
            }
            if(flag == false){
                writer.flush();
                writer.commit();
            }

        }
        br.close();
    }


    // 用于测试 - 在console中输出search结果,方便与tomcat结果比较.
    public static ArrayList<Map<String, String>> search(String q)throws IOException{
        DirectoryReader reader = DirectoryReader.open(fsDirectory);
        IndexSearcher searcher = new IndexSearcher(reader);
        QueryParser parser = new QueryParser("contents", analyzer);
        ArrayList<Map<String, String>> result = new ArrayList<>();
        try {
            Query query = parser.parse(q);
            // 前10个
            ScoreDoc[] hits = searcher.search(query, 10).scoreDocs;

            String contents;
            for (ScoreDoc hit : hits) {

                Document hitDoc = searcher.doc(hit.doc);

                Map<String, String> map = new HashMap<String, String>();
                map.put("url", hitDoc.get("url"));
                map.put("title", hitDoc.get("title"));
                map.put("subjectid", hitDoc.get("subjectid"));
                map.put("publishid", hitDoc.get("publishid"));
                map.put("description", hitDoc.get("description"));
                map.put("keywords", hitDoc.get("keywords"));
                map.put("score", Float.toString(hit.score));
                contents = hitDoc.get("contents");
                if (contents.length() > 100)
                    contents = contents.substring(0, 100) + "...";
                map.put("contents", contents);

//                highlighter.setTextFragmenter(new SimpleFragmenter(contents.length()));

//                TokenStream tokenStream = analyzer.tokenStream("contents", new StringReader(contents));
//                highLightText = highlighter.getBestFragment(tokenStream, contents);
//                map.put("contents", highLightText);
                result.add(map);
            }

            result = Search.search(q);


            reader.close();
            fsDirectory.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return result;
    }

	public static void main(String[] args)throws IOException {

	    init();
        if(fsDirectory.listAll().length == 0) {
            // 迭代处理每个.txt文件
            for (File file : files) {
                System.out.print("creating index for " + file.getName());
                createIndexPerFile(file);
                System.out.println("\n      " + file.getName() + " done!");
            }
            writer.forceMerge(1);
            writer.close();
        }
        for (String file : ramDirectory.listAll()) {
            fsDirectory.copyFrom(ramDirectory, file, file, IOContext.DEFAULT);
        }

        search("篮球");
    }
}
