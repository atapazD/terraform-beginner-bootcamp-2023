## Playing Audio
Modern Web browsers restric autoplaying audio and video to improve the user experience.
Since this is an issue originally I had autoplayed audio at the start of the site which was throwing a console error.

```
Autoplay is only allowed when approved by the user, the site is activated by the user, or media is muted. fake.cloudfront.net
```
To allow interactivity I added a button which is an image to allow the css to take effect along with the audio to fade in with the length of the audio.

```html
<img id="playButton" src="assets/Vaultboy.png" alt="Play">
```
Where `id` is referencing the styling block for the image resource in the css style sheet. 

This is the corresponding `css` for the image button
```cs
#playButton {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 50%;
    height: auto;
}
```
I centered the image and used some auto scaling for the image to keep it at 50% size and adust the height according to the browser size.

## Assets Upload issue
Uploading new assets with `css` and `js` along with the images and audio was a bit troublesome as the assets weren't loading with the proper content-type so the browser coudln't load those assets accordingly as it was being set to `application/octet-stream`.

This is the resource being created showing the incorrect `content-type` for the assets:
```tf
module.home_fallout3_hosting.aws_s3_object.upload_assets["style.css"] will be created
  + resource "aws_s3_object" "upload_assets" {
      + acl                    = (known after apply)
      + bucket                 = "terraform-20231114032939499900000001"
      + bucket_key_enabled     = (known after apply)
      + checksum_crc32         = (known after apply)
      + checksum_crc32c        = (known after apply)
      + checksum_sha1          = (known after apply)
      + checksum_sha256        = (known after apply)
      + content_type           = "application/octet-stream"
```
I attempted to use the following which resulted in the message above:
```tf 
resource "aws_s3_object" "upload_assets" {
  for_each     = fileset("${var.public_path}/assets", "*.{jpg,png,gif,mp3,js,css}")
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "assets/${each.key}"
  source       = "${var.public_path}/assets/${each.key}"
  etag         = filemd5("${var.public_path}/assets/${each.key}")

  content_type = lookup(local.mime_types, lower(trimsuffix(trimsuffix(each.key, ".gz"), ".br")), "application/octet-stream")

  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}
locals {
  mime_types = {
    "css" = "text/css",
    "js"  = "application/javascript",
    "mp3" = "audio/mpeg",
    "jpg" = "image/jpeg",
    "png" = "image/png",
    "gif" = "image/gif"
  }
}

```
Keeping the same `locals` configuration the correct method of mapping the  `content-type` required using `regex` inseated of `lower(trimsuffix()` as shown below:
```tf
resource "aws_s3_object" "upload_assets" {
...

content_type = lookup(local.mime_types, regex(".*\\.(.+)$", each.key)[0], "application/octet-stream")

...
}
```
This uses `lookup()` function in combination with `regex` which extracts the file extension of the assets being uploaded and matches them to the locals list of content-type:
- `.*\\.`: Matches any character (.) any number of times (*), followed by a literal dot `(\\.)`. This part of the regex is designed to find and ignore the preceding part of the filename, focusing on the extension.
-   `(.+)$`: Captures one or more characters (.+) at the end of the string ($). This is the file extension.
    each.key: The filename, including its extension (e.g., image.jpg, audio.mp3, style.css).
-   The result is that this function returns the file extension without the dot only leaving the extension (e.g., jpg, png, mp3,css, js)

