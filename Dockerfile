# 使用 Node.js 16 的 Alpine 镜像（显式指定 ARM64 架构）
FROM --platform=linux/arm64 node:16-alpine

# 1. 直接接收代理参数（无需替换地址）
ARG HTTP_PROXY_ARG
ARG HTTPS_PROXY_ARG
ENV HTTP_PROXY=${HTTP_PROXY_ARG} \
    HTTPS_PROXY=${HTTPS_PROXY_ARG} \
    NO_PROXY="localhost,127.0.0.1,.docker.internal"

# 2. 强制使用官方源 + 代理配置
RUN npm config set registry https://registry.npmjs.org && \
    npm config set proxy ${HTTP_PROXY} && \
    npm config set https-proxy ${HTTPS_PROXY} && \
    npm config set strict-ssl false

# 3. 配置 npm 超时参数
RUN npm config set fetch-retry-mintimeout 20000 && \
    npm config set fetch-retry-maxtimeout 120000

# 设置工作目录
WORKDIR /app

# 复制 package 文件
COPY package*.json ./

# 安装依赖（显式指定代理）
RUN npm install 

# 复制项目文件
COPY . .

# 暴露端口
EXPOSE 8013

# 启动命令
CMD ["npm", "run", "dev"]