# Learn Terraform (AWS) — Exam-Style Structure

This repo started as a single root module that launches an EC2 instance.
It now also includes a more “real-world” layout so you can practice the patterns you’ll see on the Terraform Associate exam:

- `modules/` for reusable building blocks
- `live/dev` and `live/prod` as environment roots
- `locals`, `data` sources, derived CIDRs, module outputs wiring, optional features via booleans

## Folder layout

| Path | What it is |
|---|---|
| `main.tf`, `variables.tf`, `output.tf`, `terraform.tf` | Your original simple root module (kept for comparison) |
| `modules/network` | VPC + public/private subnets + IGW + (optional) NAT |
| `modules/compute_ec2` | AMI lookup + security group + EC2 instance |
| `modules/storage_s3` | S3 bucket with versioning + encryption + public access block |
| `live/dev` | Environment root that composes the modules (dev defaults) |
| `live/prod` | Environment root that composes the modules (prod-ish defaults) |

## How to run (recommended)

Run Terraform from an environment folder (each has its own state):

### Dev

PowerShell:

```powershell
cd .\live\dev
terraform init
terraform plan
terraform apply
```

Destroy:

```powershell
terraform destroy
```

### Prod

```powershell
cd .\live\prod
terraform init
terraform plan
terraform apply
```

## Notes / common gotchas (useful for studying)

- **SSH access is disabled by default** (more secure). To enable it, set `ssh_ingress_cidr_blocks` (e.g. `["YOUR_PUBLIC_IP/32"]`).
- **HTTP is disabled by default**. Set `enable_http=true` to open port 80 and install nginx via `user_data`.
- **S3 bucket names must be globally unique**. The env config derives a name from your AWS account + region, but if you hit a collision, set `s3_bucket_name`.
- **NAT Gateway costs money**. You can set `enable_nat_gateway=false` in `live/dev` or via `-var` to avoid provisioning it.

## Remote state pattern (exam topic)

Each environment’s `terraform.tf` includes a commented `backend "s3"` block showing the common remote state + DynamoDB locking setup.
If you want, I can also add a small “bootstrap” configuration to provision the state bucket + lock table.