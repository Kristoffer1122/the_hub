# The Hub

### Description
The Hub is a webapp for IM, built with Nextjs and Rust (Axum, Diesel). It uses MariaDB as the database, and uses Azure AI Foundry for AI features. The Hub is designed to be a central hub for all your IM needs.

### Project Structure
This repository uses git submodules for the application code:
- **[backend](https://github.com/Kristoffer1122/the_hub_backend)** – Rust (Axum, Diesel) API server
- **[frontend](https://github.com/Kristoffer1122/the_hub_frontend)** – Next.js web client

### Getting Started

1. Clone the repository **with submodules**:
   ```bash
   git clone --recurse-submodules https://github.com/Kristoffer1122/the_hub.git
   ```
   If you've already cloned without submodules, pull them in with:
   ```bash
   git submodule update --init --recursive
   ```

2. Start all services (frontend, backend, and database):
   ```bash
   docker compose up --build
   ```
   This builds and starts:
   | Service    | Port  |
   |------------|-------|
   | Frontend   | 3000  |
   | Backend    | 7878  |
   | MariaDB    | 3367  |

3. To stop the services:
   ```bash
   docker compose down
   ```
