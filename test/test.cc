#include <iostream>
#include "ttHReco/core.h"


int main()
{
  ttHReco::Test* test = new ttHReco::Test();
  std::cout << test->test(42.) << std::endl;
  delete test;
  return 0;
}
