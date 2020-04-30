# CakePHP 3.x Apache 7.1 Docker with wkhtmltopdf and pdftk support

This is image is including the following

- PHP extensions
  - intl
  - mysqli
  - pdo
  - pdo_mysql
  - gd
  - mbstring
  - zip
- PHP Settings
  - date.timezone = Europe/Berlin
  - error_reporting = E_ALL & ~E_NOTICE & ~E_STRICT
  - upload_max_filesize = 100M
  - post_max_size = 100M
  - max_execution_time = 300
  - max_input_time = 600
- Apache 2
  - mod_rewrite
- PDF Tools
  - wkhtmltopdf
  - pdftk
- Image Tools
  - convert
- Composer