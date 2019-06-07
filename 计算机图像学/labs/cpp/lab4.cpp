/*
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
*/
#include <opencv2/imgproc/imgproc.hpp>
#include<opencv2/opencv.hpp>
#include<iostream>
#include<map>
#include "dft.h"

using namespace std;
using namespace cv;

Mat & padding(Mat & I)
{
    Mat padded; 

    int m = getOptimalDFTSize( I.rows ); // 当尺寸为2,3,5的倍数时，计算快
    int n = getOptimalDFTSize( I.cols ); // 在边缘添加0
    copyMakeBorder(I, padded, 0, m - I.rows, 0, n - I.cols, BORDER_CONSTANT, Scalar::all(0));
    return padded;
}

int main(int argc, char** argv)
{
    Mat I1 = imread("images/rect1.bmp", IMREAD_GRAYSCALE);
    Mat I2 = imread("images/rect2.bmp", IMREAD_GRAYSCALE);

    //cvtColor(img, dstImg,COLOR_BGR2GRAY);
    
    //padding
    Mat &padded = padding(I1); 

    //alocate space for real and imaginary parts of  Frequency
    Mat planes[]={Mat_<float>(padded), im=zeros(padded.size(),CV_32F)};
    Mat complexI;
    merge(planes,2,complexI);

    // fourier transform
    dft fft;
    fft.dft2d(complexI,complexI);  


    // compute the magnitude: ||F||
    split(complexI, planes);// planes[0] = Re(DFT(I), planes[1] = Im(DFT(I))
    magnitude(planes[0], planes[1], planes[0]);// planes[0] = magnitude
    Mat magI = planes[0];

    // switch to logarithmic scale, because the origin span is too wide
    // M1 = log(1+M)
    magI += all(1);
    log(magI,magI); 

    //magI = magI(Rect(beginCol,beginRow, colNum,rowNum));

    normalize(magI, magI, 0, 1, NORM_MINMAX); // 将float类型的矩阵转换到可显示图像范围 (float [0， 1]).

    return 0;
}
