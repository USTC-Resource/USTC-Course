package ICTCLAS_Analyzer;


import java.util.Map;

import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.util.TokenizerFactory;
import org.apache.lucene.util.AttributeFactory;

public class NLPIRTokenizerFactory extends TokenizerFactory {

    public NLPIRTokenizerFactory(Map<String, String> args) {
        super(args);
        if (!args.isEmpty()) {
            throw new IllegalArgumentException("Unknown parameters: " + args);
        }
    }

    public Tokenizer create(AttributeFactory factory, String data, int encoding, String sLicenceCode, String userDict,
                            boolean bOverwrite) {
        return new NLPIRTokenizer(factory, data, encoding, sLicenceCode, userDict, bOverwrite);
    }

    @Override
    public Tokenizer create(AttributeFactory factory) {
        return new NLPIRTokenizer(factory);
    }
}