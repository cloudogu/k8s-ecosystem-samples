grep -rl --include="*.yaml" --include="*.yml" "apiVersion: k8s.cloudogu.com/v2" . | xargs grep -l "kind: Dogu" | while IFS= read -r file; do
  echo "Set label k8s.cloudogu.com/dogu.name in v2 Dogu: $file"
  yq -i '.metadata.labels."k8s.cloudogu.com/dogu.name" = (.spec.name | split("/") | .[-1])' "$file"
done

grep -rl --include="*.yaml" --include="*.yml" "apiVersion: k8s.cloudogu.com/v3beta1" . | xargs grep -l "kind: Dogu" | while IFS= read -r file; do
  echo "Set label k8s.cloudogu.com/dogu.name in v3beta1 Dogu: $file"
  yq -i '.metadata.labels."k8s.cloudogu.com/dogu.name" = (.spec.name)' "$file"
done