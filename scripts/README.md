# Automation Scripts

These scripts call https://registry.cloudogu.com or https://dogu.cloudogu.com to query data about specific objects 
(f.e. dogus/components). These scripts require the use of credentials from the aforementioned sites. To provide those, 
copy the `.env.template`-file and rename it to `.env`. This file will be ignored by git. Fill the newly created `.env`-file
with your login data, with teh passwords base64-encoded.

Tip: Put the scripts-directory on your path to be able to call them from anywhere.

## Usage

### getAllDoguVersions
Lists all current dogu versions from the following namespaces: hallowelt, itz-bund, k8s, official, openproject, premium
```bash
getAllDoguVersions.sh
```

### getDoguVersions
Lists the last 10 dogu versions of a specific dogu.
```bash
getDoguVersions.sh official/postgresql
```

### getDoguDependencies
Lists the dependencies of a specific dogu.
```bash
getDoguDependencies.sh official/postgresql
```

### installDogu
Install a specific dogu in its latest version with no further configuration.
```bash
installDogu.sh official/postgresql
```

### getComponentVersions
Lists the last 10 component versions of a specific component.
```bash
getComponentVersions.sh official/postgresql
```

### getComponentDependencies
Lists the dependencies of a specific component.
```bash
getComponentDependencies.sh official/postgresql
```

### installComponent
Install a specific component from the k8s namespace in its latest version with no further configuration.
```bash
installComponent.sh k8s-dogu-operator
```