
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

//#include<opencv2/opencv.hpp>
#include<iostream>
#include<string>
#include<map>
#include<random>
#include<ctime>

using namespace std;
using namespace cv;

int mean_filter(Mat &img, int window_size = 3)
{
    if (window_size % 2 == 0)window_size += 1;

    if (img.rows < 2 * window_size || img.cols < 2 * window_size) {
        cout << "[Error]: filter window is too large!" << endl;
        exit(1);
    }

    Mat img2 = Mat::zeros(img.size(), img.type());
    int half = window_size / 2, tot = window_size * window_size;
    int m = img.rows - half, n = img.cols - half;
    long sm;

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            if (i < half || j < half || i >= m || j >= n) {
                img2.at<uchar>(i, j) = img.at<uchar>(i, j);
            } else {
                if (j == half) {
                    sm = 0;

                    for (int i2 = i - half; i2 <= i + half; ++i2)
                        for (int j2 = 0; j2 < window_size; ++j2)
                            sm += img.at<uchar>(i2, j2);
                } else {
                    for (int r = i - half; r <= i + half; ++r)
                        sm += img.at<uchar>(r, j + half) - img.at<uchar>(r, j - half - 1);
                }

                img2.at<uchar>(i, j) = (sm + tot - 1) / tot;
            }
        }

    imshow("filtered", img2);
    waitKey();
}

uchar find_median(vector<uchar> vec)
{
    //return the median of an array
    int mid = vec.size() / 2;
    int i = 0, j = vec.size() - 1;

    while (1) {
        int p = i;
        auto pivot = vec[p];

        while (j > i) {
            while (j > i && vec[j] > pivot)--j;

            if (j > i)
                vec[i++] = vec[j];

            while (j > i && vec[i] < pivot)++i;

            if (j > i)
                vec[j--] = vec[i];
        }

        vec[i] = pivot;

        if (i == mid)
            return pivot;
        else if (i > mid) {
            i = 0;
            j -= 1; 
        } else {
            i += 1;
            j = vec.size() - 1;
        }
    }
}
int median_filter(Mat &img, int window_size = 3)
{
    if (window_size % 2 == 0)window_size += 1;

    if (img.rows < 2 * window_size || img.cols < 2 * window_size) {
        cout << "[Error]: filter window is too large!" << endl;
        exit(1);
    }

    Mat img2 = Mat::zeros(img.size(), img.type());
    int half = window_size / 2, tot = window_size * window_size;
    int m = img.rows - half, n = img.cols - half;
    vector<uchar> queue;

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            if (i < half || j < half || i >= m || j >= n) {
                img2.at<uchar>(i, j) = img.at<uchar>(i, j);
            } else {
                if (j == half) {
                    queue.clear();

                    // push_back by columns
                    for (int j2 = 0; j2 < window_size; ++j2) // important
                        for (int i2 = i - half; i2 <= i + half; ++i2)
                            queue.push_back(img.at<uchar>(i2, j2));
                } else {
                    for (int k = 0, r; k < window_size; ++k) {
                        r =  i - half + k;
                        queue[k + (j + half) % window_size] = img.at<uchar>(r, j + half) ;
                    }
                }

                img2.at<uchar>(i, j) = find_median(queue);
            }
        }

    imshow("filtered", img2);
    waitKey();
}

void noise(Mat img,unsigned rate=3)
{
    default_random_engine e(time(0));
    uniform_int_distribution<unsigned> u(1, 100);// 定义一个范围为0~9的无符号整型分布类型
    uchar mn=255,mx=0; 
    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            auto p = img.at<uchar>(i,j); 
            if(mn>p)
                mn = p;
            if(mx<p)
                mx = p;
        }

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            if(u(e)<=rate){
                if(u(e)<=50)
                    img.at<uchar>(i,j) = mx;
                else
                    img.at<uchar>(i,j) = mn;
            }
        }
}


int main(int argc, char** argv)
{
    Mat img = imread("images/lena.bmp", IMREAD_GRAYSCALE);

    noise(img,3); 

    namedWindow("before", 1);
    imshow("before", img);
    waitKey();
    cout << "Mean filter..." << endl;
    mean_filter(img);
    cout << "median filter..." << endl;
    median_filter(img);
    return 0;
}
