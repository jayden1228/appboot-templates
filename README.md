# appboot-templates

> [appboot](https://github.com/appboot/appboot) 自定义模板仓库。

模板说明详见 [appboot template](https://github.com/appboot/templates/blob/master/README-CN.md)

## 访问

<http://ci.makeblock.com:3000/>

## 部署

appboot 部署在 <http://ci.makeblock.com> 这台机器上

### 后端

```shell
docker run --restart=always \
 -d --name backend \
 -e HOST_IP=ci.makeblock.com \
 -v $HOME/appboot/ssh:/root/.ssh \
 -v $HOME/appboot/.gitconfig:/root/.gitconfig \
 -v $HOME/appboot/appboot:/root/.appboot \
 -v $HOME/appboot/jenkinsapi:/root/.jenkinsapi \
 -v $HOME/appboot/gitlab:/root/.gitlab \
 -p 8888:8888 \
 registry.cn-hangzhou.aliyuncs.com/makeblock/appboot-backend:1.0.0
```

> 注：由于我们使用 gitlab，因此在 appboot 官方镜像的基础上又加进了 gitlab 命令行工具，做成了自定义的镜像。详见 <https://gitlab.com/makeblock-devops/appboot-docker>

### 前端

```shell
docker run --restart=always \
 -d --name appboot \
 -p 3000:80 \
 -e WS_URL="ws://ci.makeblock.com:8888/appboot" \
 appboot/frontend
```