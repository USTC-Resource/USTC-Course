package ICTCLAS_Analyzer;

import com.sun.jna.Library;
import com.sun.jna.Native;

public interface CNLPIRLibrary extends Library {

    CNLPIRLibrary Instance = (CNLPIRLibrary) Native.loadLibrary("NLPIR", CNLPIRLibrary.class);

    public boolean NLPIR_Init(String sDataPath, int encoding, String sLicenceCode);

    public String NLPIR_ParagraphProcess(String sParagraph, int bPOSTagged);

    public int NLPIR_ImportUserDict(String dictFileName, boolean bOverwrite);

    public String NLPIR_GetLastErrorMsg();
}