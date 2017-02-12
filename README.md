# Stack

This is the Student Robotics Google Cloud stack.

In short, it sets up the following:

1. Creates a network, and a subnet in Europe
2. Opens up parts of the network
3. Creates a Google Container Engine (GKE) cluster, which runs our apps

## Setting up

To setup, you need to have the following installed:

* [Terraform (v0.8.6+)][terraform]
* [GCloud][gcloud]
* [jq][jq]

You'll need to log into GCloud, which you can do by running:

```bash
gcloud auth application-default login
```

## Make a service account

The following script makes an account, gives it editor permissions in your 
Google Cloud account, and then generates a key and puts it in the secrets
folder.

```bash
./scripts/account.sh <project_name>
```

## Setup your secret config (Optional)

**If you don't run this step, you'll be prompted for your config when you run
Terraform.**

If you want to store this in a file, you run the following:

```bash
cp terraform.tfvars.template terraform.tfvars
vim terraform.tfvars
```

### Get a public IP

We've kept the public IP out of terraform, because we don't want it to be swept
away by some terraform magic.

```bash
gcloud compute addresses create srobo-public-ip \
    --region europe-west1
```

## Provision our environment

To check your changes before applying them to the environment:

```bash
terraform get && terraform plan
```

To apply them:

```bash
terraform get && terraform apply
```

[terraform]: https://www.terraform.io/
[gcloud]: https://cloud.google.com/sdk/downloads
[jq]: https://stedolan.github.io/jq/