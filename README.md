# PR Reviewer Microservice

This is the backend service for the PR Reviewer system. It receives GitHub webhook events for opened/updated PRs, extracts context, and triggers AI-powered code reviews via a Claude API integration.

## 🧰 Stack

- [NestJS](https://nestjs.com/)
- [TypeScript](https://www.typescriptlang.org/)
- [Claude API](https://www.anthropic.com/index/introducing-claude)
- [Google Cloud Pub/Sub](https://cloud.google.com/pubsub)
- [Docker](https://www.docker.com/)
- CI/CD: GitHub Actions

## 🔧 Features

- Webhook endpoint compatible with GitHub PR events
- Secure secret loading from environment or GCP Secret Manager
- Pub/Sub publisher for PR review dispatch
- Modular code structure (controller, service, utils)

## 📦 Installation

```bash
npm install
```

🧪 Local Development
You can run the service locally using:

```bash
npm run start:dev
```

For testing with Google Pub/Sub locally, use the [emulator](https://cloud.google.com/pubsub/docs/emulator?hl=es-419).

🐳 Docker Build

```bash
docker build -t pr-reviewer .
```

For GCP deploys:

```bash
docker build -t us-east1-docker.pkg.dev/<PROJECT_ID>/pr-reviewer/pr-reviewer:latest .
docker push us-east1-docker.pkg.dev/<PROJECT_ID>/pr-reviewer/pr-reviewer:latest
```

🚀 Deploy
The container is deployed via Terraform using the image URI provided as a variable (pr_reviewer_image).

🔐 Secrets
The following secrets must be configured in Google Secret Manager:

- github-pat: GitHub token with repo, pull_requests, write:discussion
- anthropic-key: API key for Claude integration
