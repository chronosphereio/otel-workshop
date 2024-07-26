# OpenTelemetry Workshop

*OTel with Chronosphere easy! Here's how.*

* [Prerequisites](#prerequisites)
* [Lab1 - Collection](lab1-collection)
* [Lab2 - Instrumentation](lab2-instrumentation)


<a name="prerequisites"></a>
## Prerequisites


<a name="1-prepare-your-local-environment"></a>
### 1. Prepare your local environment


<a name="1.1-install-dependencies"></a>
#### 1.1. Install dependencies

You will need a Kubernetes cluster to deploy the workshop applications. You will need a laptop or VM with the following software installed (use the links for installation instructions):

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [docker](https://docs.docker.com/engine/install/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [helm](https://helm.sh/docs/intro/install/)
* [yarn](https://classic.yarnpkg.com/en/docs/install#mac-stable)

Verify your installations by running these commands in your terminal:

* `git --version` (expected output: `2.32.1` or higher)
* `docker --version` (expected output: `20.10.12` or higher)
* `kubectl version` (expected output: `1.27` or higher)
* `helm version` (expected output: `3.1` or higher)


<a name="1.2-clone-this-repo"></a>
#### 1.2. Clone this repo

You will need to clone this repository:

```sh
git clone https://github.com/chronosphereio/otel-workshop.git
```


<a name="1.3-confirm-internet-access"></a>
#### 1.3. Confirm internet access

Your laptop or VM will need outbound public internet access to these hosts, protocols, and ports:

|Hostname|Protocol|Port|
|--------|--------|----|
|*.docker.com|HTTPS|443|
|*.docker.io|HTTPS|443|
|*.github.com|HTTPS|443|
|*.chronosphere.io|HTTPS|443|

<a name="1.4-obtain-environment-variables"></a>
#### 1.4. Obtain environment variables

You will be provided the tenant org name and token. You will need to set the following environment variables with the provided values.

|Environment Variable|Description|
|--------------------|------------|
|**`CHRONOSPHERE_ORG_NAME`**|Tenant Organization Name|
|**`CHRONOSPHERE_API_TOKEN`**|Provide by your contact at Chronosphere|
