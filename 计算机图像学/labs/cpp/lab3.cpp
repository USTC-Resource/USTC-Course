/*
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
*/
#include<opencv2/opencv.hpp>
#include<iostream>
#include<string>
#include<map>
#include<cmath>

#define abs(a)  ((a)>0?(a):(-(a))
using namespace std;
using namespace cv;


int roberts(Mat &img)
{
    Mat img2 = Mat::zeros(img.size(), img.type());
    int m = img.rows - 1, n = img.cols - 1;

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            if (i >= m || j >= n) {
                img2.at<uchar>(i, j) = img.at<uchar>(i, j);
            } else {
                img2.at<uchar>(i, j) = abs(img2.at<uchar>(i + 1, j + 1) - img2.at<uchar>(i, j))) + abs(img2.at<uchar>(i, j + 1) - img2.at<uchar>(i + 1, j)));
            }
        }

    imshow("roberts", img2);
    waitKey();
}

int prewitt(Mat &img)
{
    Mat img2 = Mat::zeros(img.size(), img.type());
    int m = img.rows - 1, n = img.cols - 1;

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            if (i < 1 || j < 1 || i >= m || j >= n) {
                img2.at<uchar>(i, j) = img.at<uchar>(i, j);
            } else {
                int dx = img2.at<uchar>(i + 1, j + 1) + img2.at<uchar>(i + 1, j) + img2.at<uchar>(i + 1, j - 1) - img2.at<uchar>(i - 1, j) - img2.at<uchar>(i - 1, j + 1) - img2.at<uchar>(i - 1, j - 1);
                int dy = -img2.at<uchar>(i + 1, j + 1) + img2.at<uchar>(i + 1, j - 1) + img2.at<uchar>(i, j - 1) - img2.at<uchar>(i, j + 1) - img2.at<uchar>(i - 1, j + 1) + img2.at<uchar>(i - 1, j - 1);
                img2.at<uchar>(i, j) = (int)(sqrt(dx * dx + dy * dy) + 0.5);
            }
        }

    imshow("roberts", img2);
    waitKey();
}


int main(int argc, char** argv)
{
    Mat img = imread("images/bolld1.bmp", IMREAD_GRAYSCALE);
    namedWindow("origin", 1);
    imshow("origin", img);
    waitKey();
    roberts(img);
    prewitt(img);
    return 0;
}
