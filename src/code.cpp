// [[Rcpp::depends(BH)]]
#include <boost/math/distributions/negative_binomial.hpp>

#ifdef UNIT_TEST_CPP
#include "code.h"
NumberVector get_nbinom_pdf(NumberVectorArg size, NumberVectorArg prob, NumberVectorArg xs)
#else
#include <Rcpp.h>
// [[Rcpp::export]]
Rcpp::NumericVector get_nbinom_pdf(Rcpp::NumericVector size, Rcpp::NumericVector prob, Rcpp::NumericVector xs)
#endif // UNIT_TEST_CPP
{
#ifndef UNIT_TEST_CPP
    using NumberVector = Rcpp::NumericVector;
#endif
    NumberVector results;
    try {
        if ((size.size() == 1) && (prob.size() == 1)) {
            boost::math::negative_binomial_distribution<> dist(size.at(0), prob.at(0));
            for (const auto& x : xs) {
                results.push_back(boost::math::pdf(dist, x));
            }
        }
    } catch (std::exception& e) {
        // Bad size or prob parameters
    }

    return results;
}

/*
Local Variables:
mode: c++
coding: utf-8-unix
tab-width: nil
c-file-style: "stroustrup"
End:
*/
