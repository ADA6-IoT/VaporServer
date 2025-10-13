# Repository Guidelines

## Project Structure & Module Organization
Executable code lives in `Sources/AppleAcademyChallenge6`, with feature layers split into `Controllers`, `Models`, `DTOs`, and `Migrations`. `entrypoint.swift`, `configure.swift`, and `routes.swift` wire the server and register routes. Static assets sit in `Public`, while automated checks live in `Tests/AppleAcademyChallenge6Tests/AppleAcademyChallenge6Tests.swift`. Docker assets (`Dockerfile`, `docker-compose.yml`) supply a production-like image and a Postgres dependency.

## Build, Test, and Development Commands
- `swift build` — compile the Vapor target.
- `swift run AppleAcademyChallenge6 serve --hostname 127.0.0.1 --port 8080` — boot the API locally.
- `swift run AppleAcademyChallenge6 migrate --yes` — run pending Fluent migrations.
- `docker compose up db -d` — start the Postgres dependency.
- `docker compose up app` — run the production-like container.

## Coding Style & Naming Conventions
Follow the Swift patterns in `README.md`: four-space indentation, wrapped parameter lists aligned on the label, and long `if let` chains broken across lines. Prefer PascalCase for types, lowerCamelCase for values, and keep database field keys snake_case to match migrations. Annotate sections with `// MARK: -`, leave `// TODO: -` breadcrumbs for follow-ups, and add short doc comments to public functions.

## Testing Guidelines
Tests use the new `Testing` framework and run as a serialized suite to avoid DB races. Ensure Postgres is running (`docker compose up db -d`) or override `DATABASE_*` variables before `swift test`. Each case auto-migrates and reverts schema state, so seed fixtures through Fluent and compare payloads via `TodoDTO`.

## Commit & Pull Request Guidelines
Match the existing history: begin commits with an emoji plus `[Tag]`, e.g. `✨ [Feat] 구현한 기능 요약`, using tags from the README table. Branches follow `feat/xx`, `refac/xx`, `hotfix/xx`, etc. Complete every PR template section—type checklist, work summary, follow-ups, review points—and repeat the `[Tag]` prefix in the title. Link issues, add UI screenshots, and call out database or config changes.

## Environment & Configuration Tips
Default database credentials live in `configure.swift`; override `DATABASE_HOST`, `DATABASE_NAME`, `DATABASE_USERNAME`, and `DATABASE_PASSWORD` to target other instances. For local debugging, set `LOG_LEVEL=debug` to mirror the compose setup. Keep secrets out of source control and share team overrides through ignored `.env` files.
