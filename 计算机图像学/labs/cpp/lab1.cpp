#include<opencv2/opencv.hpp>
#include<iostream>
#include<string>
#include<map>

using namespace std;
using namespace cv;

void trans(Mat & img, int k, int b)
{
    Mat img2 = Mat::zeros(img.size(), img.type());

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            int n = img.at<uchar>(i, j) * k + b;
            img2.at<uchar>(i, j) = n > 255 ? 255 : n;
        }

    namedWindow("transformed", 1);
    imshow("transformed", img2);
    waitKey();
}

void scale(Mat&img, uchar x1, uchar y1, uchar x2, uchar y2)
{
    Mat img2 = Mat::zeros(img.size(), img.type());

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            uchar x =  img.at<uchar>(i, j);

            if (x < x1) {
                img2.at<uchar>(i, j) = y1 / x1 * x;
            } else if (x1 <= x && x <= x2) {
                img2.at<uchar>(i, j) = (y2 - y1) / (x2 - x1) * (x - x1) + y1;
            } else {
                img2.at<uchar>(i, j) = (255 - y2) / (255 - x2) * (x - x2) + y2;
            }
        }

    namedWindow("scaleing", 1);
    imshow("scaling", img2);
    waitKey();
}

void histogram(Mat&img, uchar high, uchar low)
{
    int channels[] = {0};
    int nHistSize[] = {high - low + 1};
    float range[] = {low, high};
    const float* fHistRanges[] = {range};
    Mat hist;
    /*
     * images： 多幅图，只要深度相同，通道可以不同
     * channels： 通道数， 从0开始，
     * histSize: 直方图中每个维度级别数量, 即将 多少个灰度作为一个横坐标
     CV_EXPORTS void calcHist( const Mat* images,
     int nimages,
     const int* channels,
     InputArray mask,
     OutputArray hist,
     int dims,
     const int* histSize,
     const float** ranges,
     bool uniform = true,
     bool accumulate = false );
     */
    calcHist(&img, 1, channels, Mat(), hist, 1, nHistSize, fHistRanges, true);
    // canvas
    int nHistWidth = 800, nHistHeight = 600;
    int nBinWidth = (nHistWidth+nHistSize[0]-1) / nHistSize[0];
    Mat matHistImage(nHistHeight, nHistWidth, CV_8UC3, Scalar(255, 255, 255));
    //uniform
    normalize(hist, hist, 0.0, matHistImage.rows, NORM_MINMAX, -1, Mat());

    //draw histogram
    for (int i = 1; i < nHistSize[0]; ++i) {
        line(matHistImage, Point(nBinWidth * (i - 1), nHistHeight - cvRound(hist.at<float>(i - 1))), Point(nBinWidth * (8), nHistHeight - cvRound(hist.at<float>(i))), Scalar(255, 0, 0), 2, 8.0);
    }

    imshow("histogram", matHistImage);
    waitKey();
}


void histogram_enhance(Mat & img)
{
    cout << "before histogram enhancing..." << endl;
    namedWindow("before histogram enhancing...", 1);
    imshow("before", img);
    waitKey();
    int L1 = 255;
    long tot = img.rows * img.cols;
    //get cdf: cumulletive  distribute func
    map<uchar, long> cdf;

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j) {
            uchar p = img.at<uchar>(i, j);

            if (cdf.find(p) == cdf.end())
                cdf[p] = 1;
            else
                cdf[p] += 1;
        }

    int acc = 0;
    long min_cdf = tot;

    for (auto it = cdf.begin(); it != cdf.end(); ++it) {
        //map is sorted defaultly
        if (it->second < min_cdf)
            min_cdf = it->second;

        it->second += acc;
        acc = it->second;
    }

    double N1 = tot - min_cdf;
    //get gray mapping
    map<uchar, uchar> gray_map;

    for (auto it = cdf.begin(); it != cdf.end(); ++it) {
        gray_map[it->first] = (int)((it->second - min_cdf) * L1 / N1 + 0.5) ;
    }

    //substitute  and enhance
    Mat img2 = Mat::zeros(img.size(), img.type());

    for (int i = 0; i < img.rows; ++i)
        for (int j = 0; j < img.cols; ++j)
            img2.at<uchar>(i, j) = gray_map[ img.at<uchar>(i, j)];

    imshow("enhanced", img2);
    waitKey();
}

int main(int argc, char** argv)
{
    cout << "Input file path: ";
    string path;
    cin >> path;
    Mat img = imread(path, IMREAD_GRAYSCALE);

    cout << "Linear Transforming..." << endl;
    cout << "Input k,b: ";
    int k, b;
    cin >> k >> b;
    trans(img, k, b);

    cout << "Scaling..." << endl;
    cout << "Input x1,y1,x2,y2: ";
    int x1, x2, y1, y2;
    cin >> x1 >> y1 >> x2 >> y2;
    scale(img, x1, y1, x2, y2);

    cout << "Creating Histogram..." << endl;
    cout << "Input range low,high: ";
    int low, high;
    cin >> low, high;
    histogram(img, low, high);

    Mat mat = imread("images/pout.bmp", IMREAD_GRAYSCALE);
    histogram_enhance(mat);
    return 0;
}
