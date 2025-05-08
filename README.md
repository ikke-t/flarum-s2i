# Flarum forum container image build

This repo hosts containerfile purposed to build up to date images of
[Flarum](https://flarum.org) discussion board. I use
[S2I](https://github.com/openshift/source-to-image) automation to take
Flarum from git and
[Red Hat Apache PHP image](https://catalog.redhat.com/software/containers/ubi9/php-82/657b0176999f2e3662c8159b?container-tabs=overview)
as base.

# Build

To build this locally, use the appropriate branch, main for 2.x and 1.x for
the older version. Then do:

```
podman build . -t flarum:v2.0.0-beta.3
```

# Quay automated builds

I also setup Quay to build the images from git trigger, See the
[repository](https://quay.io/repository/ikke/flarum) for images.

# Run the forum

You need mariadb for the forum. If you don't have such, start it like e.g:

```
podman run -d --name mariadb_flarum -e MYSQL_USER=flarum -e MYSQL_PASSWORD=flarum -e MYSQL_DATABASE=flarum -p 3306:3306 registry.redhat.io/rhel9/mariadb-1011
```

Run the Flarum:

```
podman run -d --rm --name flarum --replace -p 8080:8080 flarum:2.0.0-beta.3
```

You might want to mount the `settings.php` and perhaps the upload directory if using such. 
If you want to test some extensions before building such container with
modified composer.json, do:

```
podman exec -ti flarum sh -c 'php composer.phar require fof/upload:"*"'
```

# S2I

If you just want to quickly build similar manually, this is the way:

```
s2i build \
  -U unix://${XDG_RUNTIME_DIR}/podman/podman.sock .\
  https://github.com/flarum/flarum \
  -r master \
   registry.access.redhat.com/ubi9/php-82:latest
  -e DOCUMENTROOT=/public \
  flarum:latest
```
