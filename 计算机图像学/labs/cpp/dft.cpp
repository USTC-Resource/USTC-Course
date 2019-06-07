#include "dft.h"

dft::dft()
{
}
dft::~dft()
{
}

int computeLayer(int n2)
{
    int m = 0;

    while (n2 > 1) {
        n2 >>= 1;
        m += 1;
    }

    return m;
}


void computeWeights(vector<comp>& weights, int n)
{
    double fixed_factor = -2 * PI / n;
    weights.clear();
    int half = n / 2;

    for (int i = 0; i < half; ++i) {
        double angle = i * fixed_factor;
        weights.push_back(comp{cos(angle), sin(angle)});
    }

    for (int i = half; i < n; ++i) {
        weights.push_back(-weights[i - half]);
    }
}

void computeInvertCode(vector<int> dst, int layer)
{
    dst.clear();
    int n = 1 << layer;

    for (int i = 0; i < n; ++i) {
        int index = 0, r = i;

        for (int j = 0; j < layer; ++j) {
            index <<= 1;

            if (r & 1) {
                index += 1;
            }

            r >>= 1;
        }

        dst.push_back(index);
    }
}

bool dft::dft1d(vector<comp>& dst, vector<comp> const &src)
{
    // fast fourier transform
    int n = src.size();

    if (n == 0 || ~(n & (n - 1)))
        return false;

    vector<comp> weights;
    computeWeights(weights, n);
    int layer = computeLayer(n);
    vector<int> invertCode;
    computeInvertCode(invertCode, src, layer);
    vector<comp> inData;

    for (int i = 0; i < n; ++i)
        inData[i] = src[invertCode[i]];

    dst = vecotr<comp>(comp{0, 0}, n);

    // compute fast fourier transform
    for (int L = 1; L <= layer; L++) {
        int distance = 1 << (L - 1);
        int W = 1 << (layer - L);
        int B = n >> L;
        int N = n / B;
        int index;

        for (int i = 0; i < B; i++) {
            int mid = i * N;

            for (int j = 0; j < N / 2; j++) {
                index = j + mid;
                dst[index] = inData[index] + (Weights[j * W] * inData[index + distance]); // Fe + W*Fo
            }

            for (int j = N / 2; j < N; j++) {
                index = j + mid;
                dst[index] = inData[index - distance] + (Weights[j * W] * inData[index]); // Fe - W*Fo
            }
        }

        inData = dst;
    }

    return true;
}
bool dft::idft1d(vector<comp>& dst, vector<comp> const &src)
{
    //invert  fast fourier transform
    int n = src.size();

    if (n == 0 || ~(n & (n - 1)))
        return false;

    vector<comp> weights;
    computeWeights(weights, n);
    int layer = computeLayer(n);
    vector<comp> inData(src);
    dst = vecotr<comp>(comp{0, 0}, n);

    // compute invert fast fourier transform
    for (int L = 1; L <= layer; L++) {
        int distance = 1 << (L - 1);
        int W = 1 << (layer - L);
        int B = n >> L;
        int N = n / B;
        int index;

        for (int i = 0; i < B; i++) {
            int mid = i * N;

            for (int j = 0; j < N / 2; j++) {
                index = j + mid;
                dst[index] = (inData[index] + inData[index + distance]) / 2; // Fe + W*Fo
            }

            for (int j = N / 2; j < N; j++) {
                index = j + mid;
                dst[index] = (inData[index] - inData[index + distance]) / 2; // Fe - W*Fo

                if (abs(weights[j * W]))
                    dst[index] = weights[j * W] * dst[index]; //(a+bi)/(c+di)
            }
        }

        inData = dst;
    }

    vecotr<int> invertCode;
    computeInvertCode(invertCode, src, layer);

    for (int i = 0; i < n; ++i)
        dst[i] = inData[invertCode[i]];

    return true;
}

bool dft::_dft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src,bool isInvert)
{
    auto fft=dft::dft1d;
    if(isInvert)
        fft = dft::idft1d; 
    int row = src.size();
    if(row<1)
        return false; 
    int col = src[0].size(); 
    if(col<1 || ~(row&(row-1)) || ~(col&(col-1)))
        return false; 
    vector<vector<comp>> dftrow(vector<comp>(),row); 
    for(int i=0;i<n;++i)
        fft(dftrow[i],src[i]); 
    dst.clear();
    dst = vector<vector<comp>>(vector<comp>(comp(),col),row); 
    for(int c=0;c<col;++c){
        vector<comp> inData,outData; 
        for(int r=0;r<row;++r)
            inData.push_back(dftrow[r][c]);
        fft(outData,inData);
        for(int r=0;r<row;++r)
            dst[r][c] = outData[r]; 
    }
    return true; 
}
}
bool dft::dft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src)
{
    return _dft2d(dst,src); 
}
bool dft::idft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src)
{
    return _dft2d(dst,src,true); 
}
