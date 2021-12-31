#include <gtest/gtest.h>
#include "code.h"

class TestDist : public ::testing::Test {};

TEST_F(TestDist, Failed) {
    const NumberVector expected {
        0.56250000, 0.42187500, 0.28125000, 0.17578125, 0.10546875,
        0.06152344, 0.03515625, 0.01977539, 0.01098633
    };

    NumberVector size {2.0};
    NumberVector prob {0.75};
    NumberVector x_set;
    NumberType x = 0.0;
    for (const auto& i : expected){
        x_set.push_back(x);
        x += 0.5;
    }

    auto actual = get_nbinom_pdf(size, prob, x_set);
    ASSERT_EQ(expected.size(), actual.size());
}

int main(int argc, char *argv[]) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

/*
Local Variables:
mode: c++
coding: utf-8-unix
tab-width: nil
c-file-style: "stroustrup"
End:
*/
