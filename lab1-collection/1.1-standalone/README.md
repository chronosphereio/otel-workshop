# Standalone collector
1. Follow steps in the [doc](https://opentelemetry.io/docs/collector/installation/#manual-linux-installation) to install collector on your system.
2. Set environment variables and launch the collector using otel-collector-config.yaml. You can [clone this repo](../../README.md#12-clone-this-repo) or [download the individual](https://raw.githubusercontent.com/chronosphereio/otel-workshop/main/lab1-collection/1.1-standalone/otel-collector-config.yaml) file.
    ```sh
    export CHRONOSPHERE_ORG_NAME=
    export CHRONOSPHERE_API_TOKEN=
    ```
    `export HOSTNAME=$(HOSTNAME) && ./otelcol --config=otel-collector-config.yaml`
3. Install telemetrygen utility

    `docker pull ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest`

    or if you have go compiler

    `go install github.com/open-telemetry/opentelemetry-collector-contrib/cmd/telemetrygen@latest`
4. Send some data and verify collector is configured successfully.

    `docker run ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen metrics --otlp-insecure --duration 5s --otlp-endpoint host.docker.internal:4317`

    `docker run ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen traces --otlp-insecure --duration 5s --child-spans 10 --otlp-endpoint host.docker.internal:4317`

    or if compiled locally

    `~/go/bin/telemetrygen metrics --otlp-insecure --duration 5s`

    `~/go/bin/telemetrygen traces --otlp-insecure --duration 5s --child-spans 10`
5. Verify data are received at Chronosphere by viewing these pages:

    [Metrics Explorer](https://partner-threec.chronosphere.io/metrics/explorer?orgId=1&left=%5B%22now-1h%22,%22now%22,%22Chronosphere%20Prometheus%22,%7B%22redirect%22:1,%22expr%22:%22gen%22%7D%5D)
    
    [Traces Explore](https://partner-threec.chronosphere.io/traces/explorer?tab=Traces&scopeFilters=%5B%7B%22matchType%22%3A%22INCLUDE%22%7D%5D&v=%7B%22timeMode%22%3A%7B%22type%22%3A%22within%22%2C%22value%22%3A3600000%7D%2C%22minTime%22%3A%222024-07-18T18%3A18%3A03.182Z%22%2C%22maxTime%22%3A%222024-07-18T19%3A18%3A03.182Z%22%2C%22spanFilters%22%3A%5B%7B%22matchType%22%3A%22INCLUDE%22%2C%22service%22%3A%7B%22match%22%3A%22EXACT%22%2C%22value%22%3A%22telemetrygen%22%2C%22inValues%22%3A%5B%5D%7D%7D%5D%2C%22limit%22%3A25%2C%22groupBy%22%3A%5B%22Service%22%5D%2C%22metric%22%3A%22REQUEST_COUNT%22%2C%22statsComparison%22%3A2%2C%22serviceScope%22%3A%5B%5D%7D)