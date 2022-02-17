#!/bin/bash

cd Calculator
dotnet restore
dotnet clean
dotnet build
cd ../Calculator.Specs
rm -f TestResults/*
dotnet restore
dotnet clean
dotnet test
#livingdoc test-assembly bin/Debug/net5.0/Calculator.Specs.dll   --test-execution-json bin/Debug/net5.0/TestExecution.json
#open LivingDoc.html
cd ..

