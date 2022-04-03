# ECR Pull
Use this plugin to pull a container image from your private ECR registry during a Drone build pipeline.

The purpose of _this_ plugin is for it to be as small as I could make it, and have it behave (in interface) as a native drone plugin.

## Usage
When using this plugin, a minimal invocation looks like:
```
kind: pipeline
type: docker
name: Do the thing in a container from my private ECR registry

steps:
- name: pull private ecr image
  image: bkyoung/ecr-pull
  settings:
    region: us-xxxx-X
    registry: XXXXXXXXXXXX.dkr.ecr.us-xxxx-X.amazonaws.com
    repo: my_repo_name
    image_tag: 1.2.3
  volumes:
    - name: docker
      path: /var/run/docker.sock

- name: do the thing
  image: XXXXXXXXXXXX.dkr.ecr.us-xxxx-X.amazonaws.com/my_repo_name:1.2.3
  pull: never                       # <- THIS IS IMPORTANT
  environment:
    SECRET_INFO:
      from_secret: SUPER_SECRET
  commands:
    - /usr/local/bin/bam --wut
  depends_on:
    - pull private ecr image

volumes:
  - name: docker
    host:
      path: /var/run/docker.sock
```

## Settings
This plugin supports the following settings:

| Setting   | Notes                         |
|-----------|-------------------------------|
| profile   | _optional_                    |
| region    | _required_                    |
| registry  | _required_                    |
| repo      | _required_                    |
| image_tag | _optional_ (_default_: latest)|