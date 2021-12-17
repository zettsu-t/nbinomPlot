// [[Rcpp::depends(BH)]]
#include <Rcpp.h>
#include <boost/math/distributions/negative_binomial.hpp>

// [[Rcpp::export]]
Rcpp::NumericVector get_nbinom_pdf(Rcpp::NumericVector size, Rcpp::NumericVector prob, Rcpp::NumericVector xs) {
    Rcpp::NumericVector results;
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
