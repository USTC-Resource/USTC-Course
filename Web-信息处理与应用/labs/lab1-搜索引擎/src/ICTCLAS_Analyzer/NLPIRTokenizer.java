package ICTCLAS_Analyzer;

import java.io.IOException;

import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.analysis.tokenattributes.OffsetAttribute;
import org.apache.lucene.analysis.tokenattributes.TypeAttribute;
import org.apache.lucene.util.AttributeFactory;

public class NLPIRTokenizer extends Tokenizer {

    private final CharTermAttribute termAtt = addAttribute(CharTermAttribute.class);
    private final OffsetAttribute offsetAtt = addAttribute(OffsetAttribute.class);
    private final TypeAttribute typeAtt = addAttribute(TypeAttribute.class);

    private String[] buffer = null;
    private StringBuffer cbuffer = null;
    int start = 0;
    int end = 0;
    int current = 0;

    String data=null;
    int encoding=1;
    String sLicenceCode=null;
    String userDict=null;
    boolean bOverwrite=false;

    public void defaultInit() {
    }

    public NLPIRTokenizer(AttributeFactory factory) {
        super(factory);
        this.defaultInit();
        this.init(data, encoding, sLicenceCode, userDict, bOverwrite);
    }

    public NLPIRTokenizer(String data, int encoding, String sLicenceCode, String userDict, boolean bOverwrite) {
        this.init(data, encoding, sLicenceCode, userDict, bOverwrite);
    }

    public NLPIRTokenizer(AttributeFactory factory, String data, int encoding, String sLicenceCode, String userDict, boolean bOverwrite) {
        super(factory);
        this.init(data, encoding, sLicenceCode, userDict, bOverwrite);
    }

    private void init(String data, int encoding, String sLicenceCode, String userDict, boolean bOverwrite) {
        boolean flag = CNLPIRLibrary.Instance.NLPIR_Init(data, encoding, sLicenceCode);
        if (!flag) {
            try {
                throw new NLPIRException(CNLPIRLibrary.Instance.NLPIR_GetLastErrorMsg());
            } catch (NLPIRException e) {
                e.printStackTrace();
            }
        } else if (userDict != null && !userDict.isEmpty()&&!userDict.equals("\"\"")) {
            int state = CNLPIRLibrary.Instance.NLPIR_ImportUserDict(userDict, bOverwrite);
            if (state == 0)
                try {
                    throw new NLPIRException(CNLPIRLibrary.Instance.NLPIR_GetLastErrorMsg());
                } catch (NLPIRException e) {
                    e.printStackTrace();
                }
        }
    }

    @Override
    public boolean incrementToken() throws IOException {
        if (buffer != null && buffer.length < current + 1) {
            cbuffer = null;
            buffer = null;
            start = 0;
            end = 0;
            current = 0;
            return false;
        }
        if (cbuffer == null) {
            cbuffer = new StringBuffer();
            int c = 0;
            while ((c = input.read()) != -1) {
                cbuffer.append((char) c);
            }
            buffer = CNLPIRLibrary.Instance.NLPIR_ParagraphProcess(cbuffer.toString(), 0).split("\\s");
        }
        clearAttributes();
        int length = buffer[current].length();
        end = start + length;
        termAtt.copyBuffer(buffer[current].toCharArray(), 0, length);
        offsetAtt.setOffset(correctOffset(start), correctOffset(end));
        typeAtt.setType("word");
        start = end;
        current += 1;
        return true;
    }

}