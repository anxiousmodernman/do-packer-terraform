# do-packer-terraform

The simplest vm image deploy I can think of.

## Step 1: Build VM Image

```
cd packer-builds/centos-base
export DIGITALOCEAN_API_TOKEN=<THIS IS A SECRET>
./build.sh
```

This will take a couple of minutes. When finished, you'll see something like

```
--> digitalocean: A snapshot was created: 'centos-base-1520030694' (ID: 32254966)
```

Make note of the `ID`. We'll need to provide this to terraform.


## Step 2: Configure and Run Terraform

First make a copy of the example tfvars file.

```
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

Next, edit **terraform.tfvars**, and provide the correct values for `do_token` and
`centos_base_image_id`. The latter is that integer ID printed at the end of the
packer build.

```
vim terraform.tfvars
```

Next, we must initialize terraform. 

```
# from inside the terraform directory
terraform init
```

By default, terraform will store its state locally on disk. This means only one
developer, the owner of this machine, can work on this terraform repo. Of 
course, there is a way to store **shared** state in databases, S3, and elsewhere, 
but that is beyond the scope of this tutorial. Luckily, it's fairly simple to 
migrate state from local disk to remote storage.

We're ready to launch some droplets. First let's look at our execution plan.

```
terraform plan
```

Since this is our first run, Terraform will show us creating two resources: a
single droplet, and a single floating IP that points at that droplet. If 
something goes wrong here, make sure that your tfvars file is formatted correctly.

The plan looks good, so we apply it.

```
terraform apply
```

Terraform knows we're reckless, so it makes us type "yes" at the prompt before
actually going through with creating the droplet and floating IP.

If we're successful, we'll see the following message.

```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## Some helpful doctl commands

If we have Digital Ocean's `doctl` command line installed we can get some 
useful data at any time.

Review our image IDs at any time, in case we didn't grab it after the packer build

```
doctl compute image list
```

Look at our running droplets

```
doctl compute droplet list
```

Finally, look at our floating ips

```
doctl compute floating-ip list
```

You should be able to ssh into your VM through the floating IP.

## Tear Everything Down

Terraform makes it terrifyingly simple to destroy everything it has under
management. Note that this will only apply to this specific terraform state.
Other projects on disk can remain running. Terraform manages them separately.

```
terraform destroy   # see ya
```

