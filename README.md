# fundor333/hugo

[![license](https://img.shields.io/github/license/fundor333/docker-hugo.svg)]()


![Docker Stars](https://img.shields.io/docker/stars/fundor333/hugo.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/fundor333/hugo.svg)
![Docker Automated build](https://img.shields.io/docker/automated/fundor333/hugo.svg)
![Docker Build Status](https://img.shields.io/docker/build/fundor333/hugo.svg)
[![](https://images.microbadger.com/badges/image/fundor333/hugo.svg)](https://microbadger.com/images/fundor333/hugo "Get your own image badge on microbadger.com")


`fundor333/hugo` is a [Docker](https://www.docker.io) base image for static sites generated with [Hugo](http://gohugo.io) fork from `publysher/hugo`. 

Images derived from this image can either run as a stand-alone server, or function as a volume image for your web server. 

For my personal use I make smaller the image of _publysher_ because I use it in my automation service and I want a more fast pipeline.

## Prerequisites


The image is based on the following directory structure:

	.
	├── Dockerfile
	└── site
	    ├── config.toml
	    ├── content
	    │   └── ...
	    ├── layouts
	    │   └── ...
	    └── static
		└── ...

In other words, your Hugo site resides in the `site` directory, and you have a simple Dockerfile:

	FROM fundor333/hugo 


## Building your site

Based on this structure, you can easily build an image for your site:

	docker build -t my/image .

Your site is automatically generated during this build. 


## Using your site


There are two options for using the image you generated: 

- as a stand-alone image
- as a volume image for your webserver

Using your image as a stand-alone image is the easiest:

	docker run -p 1313:1313 my/image

This will automatically start `hugo server`, and your blog is now available on http://localhost:1313. 

If you are using `boot2docker`, you need to adjust the base URL: 

	docker run -p 1313:1313 -e HUGO_BASE_URL=http://YOUR_DOCKER_IP:1313 my/image

The image is also suitable for use as a volume image for a web server, such as [nginx](https://registry.hub.docker.com/_/nginx/)

	docker run -d -v /usr/share/nginx/html --name site-data my/image
	docker run -d --volumes-from site-data --name site-server -p 80:80 nginx
