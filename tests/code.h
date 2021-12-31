#include <vector>
using NumberType = double;
using NumberVector = std::vector<NumberType>;
using NumberVectorArg = std::vector<NumberType>&;
extern NumberVector get_nbinom_pdf(NumberVectorArg size, NumberVectorArg prob, NumberVectorArg xs);

/*
Local Variables:
mode: c++
coding: utf-8-unix
tab-width: nil
c-file-style: "stroustrup"
End:
*/
