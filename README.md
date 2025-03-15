# terraform-sample

### terraform

```sh
asdf install terraform latest
```

### AWS profileの作成

localはダミーでOK

```sh
aws configure --profile nerusan-local
aws configure --profile nerusan-stg
aws configure --profile nerusan-prd
```


### 管理画面
motoには管理がある

[http://localhost:5001/moto-api/#](http://localhost:5001/moto-api/#)


### 開発方法

motoサーバー起動する。

```sh
make up
```

各ディクトリサービスに移動し、tfstate用のs3を作成する。

```sh
make bucket
```

そのまま、planを実行できます。

```sh
make plan
Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.55.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.nat_gateway["a"] will be created
  + resource "aws_eip" "nat_gateway" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
...
```

デフォルトでは、env=localが設定されており、ローカルに起動したmotoに対して実行します。

stgにしたい場合は、ENV=stgをつけます。

```sh
make plan ENV=stg
```
