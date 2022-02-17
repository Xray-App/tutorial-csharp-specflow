#!/bin/bash

docker build . -t specflow_specrun_net5_tests
docker run --rm -v $(pwd)/TestResults:/source/SpecFlowCalculator.Specs/TestResults -t specflow_specrun_net5_tests
