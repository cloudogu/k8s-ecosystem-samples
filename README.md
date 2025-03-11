# k8s-ecosystem-samples

A collection of commonly used k8s resources around MN-CES.

## How-to

if not stated otherwise (f.e. dogurestarts), these resources can be applied with the following command:

```bash
kubectl apply -f <RESOURCE_FILE> -n ecosystem
```

Changes to those resources will be noticed by our operators and handled accordingly. This can be achieved with another 
`kubectl apply` or the resource is changed directly like this:

```bash
kubectl edit <RESOURCE> <RESOURCE_NAME> -n ecosystem
```

Where RESOURCE means the kind, f.e. "dogu" or "component" and RESOURCE_NAME means the specific name, f.e. 
"bluespice" or "k8s-dogu-operator".

### Generic Resource Examples

Where helpful, this repository provides generic resource examples with explanatory comments. These are located in the 
root of each resource folder and are named like the resource itself, f.e. [k8s_v2_dogu.yaml](dogus/k8s_v2_dogu.yaml).

## automation scripts

This repository also contains some automation scripts for easier handling of MN-CES. For further information, see 
[here](scripts/README.md).

---

## What is the Cloudogu EcoSystem?
The Cloudogu EcoSystem is an open platform, which lets you choose how and where your team creates great software. Each service or tool is delivered as a Dogu, a Docker container. Each Dogu can easily be integrated in your environment just by pulling it from our registry.

We have a growing number of ready-to-use Dogus, e.g. SCM-Manager, Jenkins, Nexus Repository, SonarQube, Redmine and many more. Every Dogu can be tailored to your specific needs. Take advantage of a central authentication service, a dynamic navigation, that lets you easily switch between the web UIs and a smart configuration magic, which automatically detects and responds to dependencies between Dogus.

The Cloudogu EcoSystem is open source and it runs either on-premises or in the cloud. The Cloudogu EcoSystem is developed by Cloudogu GmbH under [AGPL-3.0-only](https://spdx.org/licenses/AGPL-3.0-only.html).

## License
Copyright © 2020 - present Cloudogu GmbH
This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.
See [LICENSE](LICENSE) for details.


---
MADE WITH :heart:&nbsp;FOR DEV ADDICTS. [Legal notice / Imprint](https://cloudogu.com/en/imprint/?mtm_campaign=ecosystem&mtm_kwd=imprint&mtm_source=github&mtm_medium=link)
