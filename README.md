# Tutorial with SpecFlow test scenarios implemented in C#, integrated with Xray

[![build workflow](https://github.com/Xray-App/tutorial-csharp-specflow/actions/workflows/main-cloud.yml/badge.svg)](https://github.com/Xray-App/tutorial-csharp-specflow/actions/workflows/main-cloud.yml)
[![build workflow](https://github.com/Xray-App/tutorial-csharp-specflow/actions/workflows/main-serverdc.yml/badge.svg)](https://github.com/Xray-App/tutorial-csharp-specflow/actions/workflows/main-serverdc.yml)
[![license](https://img.shields.io/badge/License-BSD%203--Clause-green.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/Xray-App/community)

## Overview

This repo contains code that supports the tutorial [Testing using SpecFlow and Gherkin Scenarios in C#](https://docs.getxray.app/pages/viewpage.action?pageId=82468422) showcasing the integration between [Xray Test Management](https://www.getxray.app/) on Jira and SpecFlow (C#).

The test automation code implements some basic tests (i.e. scenarios/scenario outlines) for a dummy calculator, using a story (i.e. addition) as the feature(s) we aim to deliver.

## Prerequisites

The code for this tutorial is written in C#. In order to run this tutorial, you need to have Net 5 (i.e. .NET Core 5.0) and mono; mono is required by SpecFlow to generate the Cucumber compatible JSON report.
Dependencies are installed automatically whenever running `dotnet restore`.

## Notes

- to generate the Cucumber compatible JSON report, we need to use the "SpecFlow+ Runner" test runner, which supports .NET Core up to .NET 5.0, and take advantage of the possibility of generating custom reports
- in January 2021, SpecFlow team [decided](https://specflow.org/using-specflow/the-retirement-of-specflow-runner/) to end up with development of the "SpecFlow+ Runner" test runner
- for .NET 6.0 there is no way of generating Cucumber JSON reports, as the supported test runners (e.g., NUnit, xUnit, MSTest) don't support it; if using SpecFlow and integrating it with Xray, or any other tool that uses Cucumber JSON reports, is important to you, then you should [reach out SpecFlow team](https://support.specflow.org/)

## Running

The straighforward approach to run everything in a single shot is to invoke the auxiliary script [run_all_cloud_standard_workflow.sh](run_all_cloud_standard_workflow.sh).
You need to update the client_id and client_secret to interact with your Xray cloud instance (obtainable from Xray API Keys section); you also need to update the issue keys of the corresponding stories in Jira, that you'll use as basis to generate the .feature file(s).

Remember that to be able to run the scenarios, we need to have the corresponding .feature files. The previous script assumes you are using Xray to manage the specification of the scenarios, so you need to extract them from Jira (more on the possible workflows [here](https://docs.getxray.app/pages/viewpage.action?pageId=31622264)).

When you have the .feature files, containing the Feature along with the Scenario properly tagged, you can finally run the tests using the `dotnet` tool.

```bash
dotnet restore
dotnet clean
dotnet test
```

We need to specify that we want a Cucumber JSON report as output, and also the path where the .feature files are at.

Tests can also run inside a Docker container; local directory/file should be mounted so that Cucumber results are stored locally.

```bash
docker build . -t specflow_specrun_net5_tests
docker run --rm -v $(pwd)/TestResults:/source/SpecFlowCalculator.Specs/TestResults -t specflow_specrun_net5_tests
```

## Submitting results to Jira

Results can be submitted to Jira so that they can be shared with the team and their impacts be easily analysed.
This can be achieved using [Xray Test Management](https://www.getxray.app/) as shown in further detail in this [tutorial](XXXXXXXX).
This repo contains an auxiliary script [import_results_cloud.sh](import_results_cloud.sh) that does that; it uses a configuration file to have Xray's client_id and client_secret.
You can also have a look at the [workflows implemented in this repo](.github/workflows) using GitHub Actions.

## Auxiliary scripts

This repo also contains some auxiliary shell scripts, provided as an example; feel free to download and customize them to your needs.
You may find scripts for interacting both with Xray server/DC or Xray cloud, which have slightly different APIs.

## Contact

Any questions related with this code, please raise issues in this GitHub project. Feel free to contribute and submit PR's.
For Xray specific questions, please contact [Xray's support team](https://jira.getxray.app/servicedesk/customer/portal/2).

## References

- [SpecFlow docs](https://docs.specflow.org/projects/specflow/en/latest/)
- [Possible workflows for implementing Cucumber](https://docs.getxray.app/pages/viewpage.action?pageId=31622264)
- [Detailed tutorial for Xray Cloud showcasing the integration with Jira Cloud](https://docs.getxray.app/pages/viewpage.action?pageId=82468422)
- [Detailed tutorial for Xray server/DC showcasing the integration with Jira server/DC](https://docs.getxray.app/pages/viewpage.action?pageId=82461603)
- [SpecFlow Examples, from the SpecFlow team](https://github.com/SpecFlowOSS/SpecFlow-Examples)

## LICENSE

[BSD 3-Clause](LICENSE)
