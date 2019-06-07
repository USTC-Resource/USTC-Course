#ifndef __my_dft__
#define __my_dft__


#include <complex>
#include <vector>

#define MAX_MATRIX_SIZE 419304 // 2048*2048
#define MAX_VECTOR_LENGTH  10000
#define PI 3.1415926

using std::complex;
using std::vector;
typedef complex<double> comp ;

class dft
{
public:
    dft();
    ~dft();
    bool dft1d(vector<comp>&, vector<comp> const &);
    bool dft2d(vector<comp>&, vector<comp> const &);
    bool idft1d(vector<comp>&, vector<comp> const &);
    bool dft::_dft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src,bool isInvert=false)
    bool dft::dft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src)
    bool dft::idft2d(vector<vector<comp>>& dst, vector<vector<comp>> const &src)
}; 

#endif
