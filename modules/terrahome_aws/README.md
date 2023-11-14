## Terrahome AWS

```tf
 module "home_fallout3" {
   source              = "./modules/terrahome_aws"
   user_uuid           = var.teacherseat_user_uuid
   public_path = var.fallout3_public_path
   content_version     = var.content_version
 }
```
The public directory expects the following:
    - index html
    - error.html
    - assets

All top level files in assets will be cpied, but not any subdirectories
