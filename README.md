# DevOps E2E Terraform Azure

Production-style Terraform layout for Azure: reusable modules, per-environment roots, drift detection, and CI with Checkov plus Azure DevOps approval gates.

## Layout

```
modules/
  network/    # VNet, subnets, NSG
  app/        # App Service + plan
  monitoring/ # Log Analytics, App Insights
environments/
  dev/ staging/ prod/
```

## Prerequisites

- Terraform >= 1.6
- Azure CLI logged in (`az login`)
- Remote state storage (configure per environment `backend.tf`)

## Usage

```bash
cd environments/dev
terraform init
terraform plan -var-file=terraform.tfvars.example
```

## CI/CD

- **GitHub Actions** — `terraform fmt`, `validate`, `plan`, Checkov on PRs
- **Azure DevOps** — multi-stage apply with manual approval for staging and prod

## Drift detection

```bash
./scripts/drift-check.sh environments/prod
```

## Learnings

- Module boundaries: network vs app vs observability
- Environment-specific sizing via tfvars
- Policy-as-code with Checkov before apply
