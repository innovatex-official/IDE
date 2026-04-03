# InnovateX IDE: The VS Code Based Coding Environment for Students
# Developed By Suryanshu Nabheet.

FROM node:22-bullseye AS builder

WORKDIR /app

# Configure build environment
ENV VSCODE_SKIP_NODE_VERSION_CHECK=1
ENV NODE_OPTIONS="--experimental-strip-types --max-old-space-size=4096"
ENV VERSION=1.0.0

# Copy only what's needed for installation
COPY package*.json .gitmodules ./
COPY ci/ ci/
COPY patches/ patches/

# Initialize VS Code submodule independently
RUN apt-get update && apt-get install -y git jq patch && \
    git init && \
    git submodule add --depth 1 https://github.com/microsoft/vscode.git lib/vscode && \
    git submodule update --init --recursive

# Install and build
RUN npm install
RUN npm run build
RUN npm run build:vscode

# ---------------------------------------------------------
# Production Runtime
# ---------------------------------------------------------
FROM node:22-bullseye-slim

WORKDIR /app
COPY --from=builder /app/package.json .
COPY --from=builder /app/out/ out/
COPY --from=builder /app/lib/vscode/out/ lib/vscode/out/
COPY --from=builder /app/node_modules/ node_modules/
# Keep essential assets
COPY src/browser/media/ src/browser/media/

# Configuration for InnovateX IDE
ENV PORT=8080
ENV APP_NAME="InnovateX IDE"
EXPOSE 8080

ENTRYPOINT ["node", "out/node/entry.js", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
