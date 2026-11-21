# Agent Guidelines for `llmclt`

This document provides instructions, conventions, and context for AI coding agents working on the `llmclt` gem repository.

## Project Overview

- **Name**: `llmclt`
- **Description**: A lightweight, minimal-dependency Ruby client for Google Cloud Vertex AI Gemini API (supporting both Service Account JSON credentials and Vertex AI Studio API keys).
- **Supported Ruby Versions**: Ruby 3.1 to Ruby 4.0 (`TargetRubyVersion: 3.1`).
- **Core Dependencies**: Kept intentionally minimal. Only `googleauth` is currently a runtime dependency. External libraries should be introduced only when necessary.

## Architecture & Code Structure

```
lib/
├── llmclt.rb                  # Main library entry point (require definitions)
└── llmclt/
    ├── client.rb              # Main interface for users (Llmclt::Client)
    ├── config.rb              # Configuration holder (Llmclt::Config)
    ├── config/
    │   ├── generation_config.rb
    │   └── safety_config.rb
    ├── fetcher.rb             # HTTP transport & authentication header management
    ├── helper.rb              # Internal utilities (e.g. camelize_keys, without ActiveSupport)
    ├── http/
    │   ├── connection.rb
    │   └── connection_pool.rb
    ├── request/               # Request builders (Base, Chat, Streaming, NonStreaming, Batch)
    ├── response/              # Response wrappers (Base, Chat, Streaming, NonStreaming, Batch)
    ├── syntax/                # Syntax helpers (Chat)
    └── version.rb             # Version constant (Llmclt::VERSION)
spec/                          # RSpec tests and mock fixtures
```

## Development & Verification Commands

Always run verification commands using the project's bundled Ruby environment.

- **Run all checks (RSpec + RuboCop)**:
  ```bash
  bundle exec rake
  ```
- **Run RSpec tests**:
  ```bash
  bundle exec rspec
  ```
- **Run a specific spec file**:
  ```bash
  bundle exec rspec spec/llmclt/client_spec.rb
  ```
- **Run RuboCop linting**:
  ```bash
  bundle exec rubocop
  ```
- **Run RuboCop auto-correction**:
  ```bash
  bundle exec rubocop -A
  ```

## Coding Conventions & Guidelines

1. **Dependencies**:
   - Prefer keeping external dependencies minimal. Add new external gems only when necessary.
   - For lightweight utility functions, prefer implementing them cleanly inside `Llmclt::Helper` or domain-specific classes.
2. **Coding Style**:
   - Strictly follow the RuboCop rules defined in `.rubocop.yml`.
   - Every Ruby source file must start with `# frozen_string_literal: true`.
   - Always verify that `bundle exec rubocop` passes without offenses.
3. **Require Order in `lib/llmclt.rb`**:
   - `require_relative 'llmclt/helper'` must be placed immediately before `require_relative 'llmclt/version'`.
4. **Testing Standards**:
   - Use RSpec. Every new feature or bug fix should be covered by unit tests.
   - Use WebMock and JSON fixtures in `spec/fixtures/` to mock HTTP interactions. Never make live network requests in specs.
   - Maintain high test coverage (SimpleCov is enabled).
5. **Security & Clean Working Tree**:
   - NEVER stage or commit credential files (`*.json` service account keys), API keys, or temporary output dumps (`*.txt`, `*.jsonl`).
   - Keep test and fixture directories clean.
6. **Commit Style**:
   - Commit messages should be concise, written in English with the imperative mood (e.g., `Remove ActiveSupport dependency`, `Change default model`).
