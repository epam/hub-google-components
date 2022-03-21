# K6 SQL load test

## Description

The component uses [k6.io](https://k6.io/) testing framework with [xk6-sql extension](https://github.com/grafana/xk6-sql) to run an example load test against the given SQL server.

## Implementation details & Parameters
The component executes the given test scenario. Currently, there is only one scenario, please see [example](example-mysql.js.template)
The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` runs the load test
├── undeploy.sh                      # `undeploy` does nothing
└── example-mysql.js.template        # example test scenario that inserts some dummy data to the given mysql database and runs a simple select query against it                       
```

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
component.k6SQLloadTest.dbKind | SQL database kind | mysql | Yes
component.k6SQLloadTest.dbHost | SQL database hostname | n/a | Yes
component.k6SQLloadTest.dnName | SQL database name | n/a | Yes
component.k6SQLloadTest.dbUser | SQL database user | n/a | Yes
component.k6SQLloadTest.dbPassword | SQL database password | n/a | Yes
component.k6SQLloadTest.testName | Test name | example | Yes
component.k6SQLloadTest.testDuration | Test duration | 100s | Yes
component.k6SQLloadTest.numberOfUsers | Number of concurent users | 1000 | Yes
