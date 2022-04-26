# Locust Load Test

This component is not deploying anything. Instead it will generate a load test. You can follow test progress by accessing [http://localhost:8080](localhost:8080) with your browser. However this endpoint will be shut down after test completion.

So, instead you can access test report: in the `test-results.html` generated in this directory

## Structure

The component has the following directory structure:

```text
./
├── deploy.sh               # installs locust into venv and runs a test suite
├── hub-component.yaml      # hubfile with parameters
├── locust.conf.template    # locust configuration file
├── locustfile.py           # test script
├── test-result.html        # <generated> a test report
└── undeploy.sh             # at present does nothing
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.wp-loadgenerator.targetHost` | FQDN of http endpoint where to send some loads | `https://<stack domain name>` | x |
| `component.wp-loadgenerator.users` | number of users to simulate load | `50` | x |
| `component.wp-loadgenerator.spawnRate` | Rate to spawn users at (users per second) | `10` | x |
| `component.wp-loadgenerator.runTime` | Stop after the specified amount of time | `5m` | x |

Additional configuration parameters can added. Please see [locust reference guide](https://docs.locust.io/en/stable/configuration.html)

## Ouptusts

| Name      | Description |
| :-------- | :--------   |
| `component.wp-loadgenerator.testReport` | Absolute path to the test reportfile |

## Dependencies

Requires:

* python v3
* venv
* locust

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [locust](https://docs.locust.io/en/stable/configuration.html)
