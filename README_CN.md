# 特色

本工程是为了针对 beego 工程做持续集成，支持直接开发或者在 CI/CD 链中使用

> 当然你可以改造这个工程使用别的 web 框架，这只是一种 golang依赖管理 渗透到生产的方案，落地后的产物

- 开箱即用，所见即可开发
- 更少的依赖更新获取，增加开发效率
- 依赖管理不在透明化，可跟踪依赖问题

# 设计原则

将依赖管理分离清晰，包括

依赖记录，依赖来源，版本锁定，更新版本，依赖部署

## 依赖记录

使用 git 仓库和 docker 仓库，git 仓库必须有的是依赖来源管理文件，版本锁定文件， docker 仓库以 tag 提交来记录部署依赖

## 依赖来源

使用 `go dep` 或者其他能确认并且记录依赖的工具，或者直接源码放置到镜像制作过程中
不要把依赖放任到本地环境的 GOPATH 中，非要开发过程使用，也尽量做到隔离使用

## 版本锁定

版本锁定，使用了隔离 `$GOPATH`(利用 docker 容器环境隔离的效果)，代码资源隔离，是相对软隔离方式，开发和部署分离

> 代码资源隔离细节，隔离的代码，一部分是在镜像内置了代码资源，当然允许开发过程中修改这些资源，但是在 CI/CD 时强制校验，来达到管理的目的，所以，做自动化部署检查是必须的

## 更新版本

更新版本，这个需要先制作一个依赖链才可以做到，对应镜像是这种结构

```sh
env_image ->  framework_1  -> work_group_one_framework_1  ->  work_containt_group_one_framework_1
          |
          \   framework_2  -> work_group_one_framework_2  ->  work_containt_group_one_framework_2
                            |
                            |
                            \ work_group_two_framework_2  ->  work_containt_group_two_framework_2
```

别被图吓到，其实就三层，这里分别涉及到 (框架镜像，业务组镜像，业务镜像)

- env_image 基础镜像，一般是 golang 的官方镜像，不算管理层次
- framework_1 框架镜像，比如当前工程就是框架镜像，为第一层
- work_group_one_framework_1 就是业务组 group_one 使用的 framework_1 的镜像，为业务组层
- work_containt_group_one_framework_1 就是当前开发的业务的镜像， 为具体业务层

> 开发过程使用的是 work_containt_group_one_framework_1 某个 tag 的镜像，run 时的容器

当然上面制作的所有过程相对应的 git 仓库是有对应命名规则的，也便于记录和管理
更新版本，其实就是更新对应 docker 镜像的 tag

## 依赖部署

分为 测试部署，灰度部署，正式部署

- 测试部署是直接创建 对应开发业务的镜像的某个 tag，做的实时构建，要求，一旦有错，不得通过，必须修复检查
- 灰度部署，如果使用，就需要在 开发的业务的镜像 复制一份，做到最小依赖，甚至直接使用 二进制包来部署
- 正式部署，同灰度不少，区别是必须加入灾备和监控

> 我这里对于灰度部署，是技术上的灰度，不是业务上的，技术上的灰度是允许不做灾备，或者监控的，如果业务强行需要高安全和可用，那么使用正式部署模式

# 管理依赖文件夹

## bee-env

- beego 框架依赖，其中tag为框架的某个版本，见 [Dockerfile](bee-env/build-docker.sh)