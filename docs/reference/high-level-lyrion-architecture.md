---
layout: default
title: Lyrion Music Server core architecture
---

# Lyrion Music Server (LMS) core architecture

This guide provides an onboarding-oriented architectural map of the **Lyrion Music Server** core codebase. It favors a high-level mental model over exhaustive module documentation so you can navigate the codebase quickly.

!!! info "Audience"
    Developers who are comfortable with Perl and systems programming but are new to LMS internals.

!!! tip "How to use this guide"
    Skim the big-picture sections, then jump to the subsystem you are about to change. Follow the file breadcrumbs to dive deeper when needed.

## Big picture

LMS is an **event-driven server** that:

- accepts player connections over **SlimProto** (TCP 3483)
- serves a web UI plus APIs over **HTTP** (default TCP 9000)
- exposes a command/query CLI internally and externally
- maintains a library database (SQLite by default, MySQL optional)
- scans media and playlists, often through a separate scanner process
- streams audio to hardware/software players (direct, proxied, or transcoded)

### Processes

Two entrypoints run most workloads:

- **Main server** — [slimserver.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/slimserver.pl)
  - long-running process that owns networking, players, the web UI, and the primary event loop
- **Scanner** — [scanner.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/scanner.pl)
  - short-lived/background process that performs scans, updates the DB, and reports progress

Expensive operations either run inside the scanner or are implemented as cooperative background tasks that periodically yield back to the event loop.

### Event loop model

The runtime builds on **EV/AnyEvent** plus a custom select wrapper:

- socket readiness: [Slim/Networking/IO/Select.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Networking/IO/Select.pm) and [Slim/Networking/Select.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Networking/Select.pm)
- timers: [Slim/Utils/Timers.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/Timers.pm)
- cooperative jobs: [Slim/Utils/Scheduler.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/Scheduler.pm)

The main loop in [slimserver.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/slimserver.pl) rotates through IR events, pending requests, scheduled tasks, and an `EV::loop(...)` tick. Most subsystems therefore work in small chunks, then yield.

## Repository map

This repository bundles the core server and supporting assets/dependencies. For a deeper tour of the repo layout and development workflows, see [repository-dev.md](repository-dev.md).

### Top-level directories

- [slimserver.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/slimserver.pl) — main server entrypoint
- [scanner.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/scanner.pl) — scanning/import entrypoint
- [Slim/](https://github.com/LMS-Community/slimserver/tree/HEAD/Slim) — core application code
- [HTML/](https://github.com/LMS-Community/slimserver/tree/HEAD/HTML) — web UI skins and static assets
- [SQL/](https://github.com/LMS-Community/slimserver/tree/HEAD/SQL) — DB schema and migration scripts
- [prefs/](https://github.com/LMS-Community/slimserver/tree/HEAD/prefs) — example/default preferences (runtime prefs live elsewhere)
- [Cache/](https://github.com/LMS-Community/slimserver/tree/HEAD/Cache) — caches, downloaded plugins, artwork, temp files
- [CPAN/](https://github.com/LMS-Community/slimserver/tree/HEAD/CPAN) — vendored Perl modules (including architecture-specific builds)
- [Bin/](https://github.com/LMS-Community/slimserver/tree/HEAD/Bin) — helper binaries (codecs, tools)
- [convert.conf](https://github.com/LMS-Community/slimserver/blob/HEAD/convert.conf) / [types.conf](https://github.com/LMS-Community/slimserver/blob/HEAD/types.conf) — transcoding and media type mappings
- [t/](https://github.com/LMS-Community/slimserver/tree/HEAD/t) — tests and tooling

### Slim/ subsystem layout

`Slim/` is a constellation of cooperating subsystems:

- [Slim/bootstrap.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/bootstrap.pm) — bootstraps `@INC` and bundled CPAN modules
- `Slim/Utils/*` — prefs, cache, timers, scheduler, OS abstraction, logging, strings
- `Slim/Networking/*` — select/event loop integration, async HTTP/DNS, SlimProto server
- `Slim/Control/*` — the `Request` mechanism, CLI/JSON-RPC queries, Jive control logic
- `Slim/Player/*` — player model, streaming controller, protocol handlers, transcoding pipeline
- `Slim/Schema*` — ORM schema (DBIx::Class)
- `Slim/Music/*` — scanning orchestrators, metadata handling, virtual libraries
- `Slim/Web/*` — HTTP server, routing, templates, JSON-RPC, Cometd
- `Slim/Menu/*` — menu builders for hardware UIs and Jive flows
- `Slim/Plugin/*` — bundled plugins

## Startup and initialization

The canonical boot path:

1. **`BEGIN` block** in [slimserver.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/slimserver.pl)
   - loads [Slim/bootstrap.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/bootstrap.pm)
   - runs `Slim::bootstrap->loadModules()` to seed `@INC`
2. **`init()` phase**
   - initializes logging, OS detection, plugin manager, string subsystem
   - configures DB helpers and connects the schema
   - brings up networking (DNS, HTTP, SlimProto)
   - primes caches and web handlers (pages, JSON-RPC, Cometd)
   - loads plugins after core subsystems are stable

Plugins are discovered early but most code loads lazily unless a plugin is “enforced.”

## Request mechanism (internal API bus)

`Slim::Control::Request` acts as LMS’s internal message bus:

- implementation: [Slim/Control/Request.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Control/Request.pm)
- queries: [Slim/Control/Queries.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Control/Queries.pm)
- commands: `Slim/Control/Commands.pm`

Requests fall into three categories:

- **Commands** mutate state (eg. `['playlist', 'play']`, `['pause', 1]`)
- **Queries** return structured data (eg. `['albums', 0, 100, 'tags:...']`)
- **Notifications** publish events (eg. `['playlist', 'newsong']`, `['rescan', 'done']`)

Front-doors reuse the same mechanism:

- CLI (TCP / stdio)
- Web JSON-RPC via [Slim/Web/JSONRPC.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/JSONRPC.pm)
- Cometd (Jive) via [Slim/Web/Cometd.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/Cometd.pm)
- In-process calls via `Slim::Control::Request::executeRequest(...)`

When onboarding, find a request name in the docs table inside `Request.pm`, open its implementation in `Queries.pm` or the relevant command module, then follow how it touches players or the DB.
For end-user and troubleshooting context, pair this section with the [CLI introduction](cli/introduction.md) and the walkthrough in [using-the-cli.md](cli/using-the-cli.md).

## Player model and playback pipeline

### Player connections (SlimProto)

Physical and emulated players connect through SlimProto:

- listener: [Slim/Networking/Slimproto.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Networking/Slimproto.pm)
- default port: 3483/TCP

See [slimproto-protocol.md](slimproto-protocol.md) for the full message reference and framing details.

Each connection maps to a `Slim::Player::Client` owning a `Slim::Player::StreamingController` state machine.

### Streaming controller

Core location: [Slim/Player/StreamingController.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/StreamingController.pm).

It maintains two orthogonal state machines:

- **playing** — STOPPED, BUFFERING, PLAYING, PAUSED, …
- **streaming** — IDLE, STREAMING, STREAMOUT, TRACKWAIT

It reacts to playback commands, buffer events, sync updates, and end-of-stream signals.

### Song and track model

`Slim::Player::Song` ([Slim/Player/Song.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/Song.pm)) wraps a DB-backed `Track` ([Slim/Schema.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Schema.pm)) and selects the right protocol handler via [Slim/Player/ProtocolHandlers.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/ProtocolHandlers.pm). Remote URLs may be scanned on demand, separating the **track URL** (identity) from the **stream URL** (what is fetched).

### URL protocol handlers

Protocol handlers (`Slim/Player/Protocols/*`) describe how to scan and stream a URL type:

- registration/lookup: [Slim/Player/ProtocolHandlers.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/ProtocolHandlers.pm)
- common hooks: `scanUrl(...)`, `getMetadataFor`, socket construction helpers

This is a major plugin extension surface.

### Transcoding pipeline

When a player cannot decode a source format, LMS transcodes via configuration-driven pipelines:

- helper modules: `Slim/Player/TranscodingHelper`, `Slim/Player/Pipeline`
- rules: [convert.conf](https://github.com/LMS-Community/slimserver/blob/HEAD/convert.conf)
- helper binaries: [Bin/](https://github.com/LMS-Community/slimserver/tree/HEAD/Bin)

Rules describe format-to-format steps and usually avoid code changes.

## Web UI and HTTP APIs

### HTTP server

- implementation: [Slim/Web/HTTP.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/HTTP.pm)
- default port: 9000/TCP

Initialization registers routes, template engines, JSON-RPC, Cometd, static assets, and image proxying.

### Pages and templates

- routing glue: [Slim/Web/Pages.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/Pages.pm) and `Slim/Web/Pages/*`
- skins/assets: [HTML/](https://github.com/LMS-Community/slimserver/tree/HEAD/HTML)

Endpoints can be raw handlers or template-backed; plugins may add their own.

### JSON-RPC API

[Slim/Web/JSONRPC.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/JSONRPC.pm) wraps `Slim::Control::Request` so CLI knowledge transfers directly to JSON-RPC.

### Cometd (Bayeux)

[Slim/Web/Cometd.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/Cometd.pm) provides long-polling publish/subscribe channels, historically used by Jive clients.

## Library database and persistence

The server stores different state types in purpose-built layers.

### Library database

- entry: [Slim/Schema.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Schema.pm)
- ORM: DBIx::Class
- backends: SQLite (default) or MySQL
- migrations: DBIx::Migration plus scripts under [SQL/](https://github.com/LMS-Community/slimserver/tree/HEAD/SQL)

`Slim::Schema->init()` runs early and migrates older schemas automatically.
Reference [database-structure.md](database-structure.md) when you need detailed table descriptions, relationships, or example SQL queries.

### Preferences (configuration)

[Slim/Utils/Prefs.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/Prefs.pm) provides namespaced YAML-based preferences (eg. `server`, `plugin.*`). The subsystem supports migrations, validation, and change callbacks, letting plugins evolve independently.

### Caches

[Slim/Utils/Cache.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/Cache.pm) offers a SQLite-backed cache per namespace. Memory caches handle hot data; on-disk caches (under `Cache/`) store artwork, resized images, plugin payloads, and temp data.

## Scanning and import pipeline

Scanning runs out-of-process to keep the server responsive.

### Orchestration

- orchestrator: [Slim/Music/Import.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Music/Import.pm)
- scanner entrypoint: [scanner.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/scanner.pl)

The server launches the scanner via `Proc::Background`, which traverses media folders, parses tags, updates schema objects, computes artwork, and reports progress.

### Supported types and metadata

- type detection: [types.conf](https://github.com/LMS-Community/slimserver/blob/HEAD/types.conf) via [Slim/Music/Info.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Music/Info.pm)
- format logic: `Slim/Formats/*`

Protocol handlers and format modules decide seekability, header parsing, and related streaming/scanning logic.

## Plugins and extension points

Plugins are the primary extensibility vehicle.

### Locations

- bundled: [Slim/Plugin/](https://github.com/LMS-Community/slimserver/tree/HEAD/Slim/Plugin)
- installed-at-runtime: typically `Cache/InstalledPlugins/`

### Discovery and lifecycle

[Slim/Utils/PluginManager.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/PluginManager.pm) parses plugin manifests (`install.xml`), tracks per-plugin state (`plugin.state` prefs), and enforces safe modes (eg. failsafe loads only required plugins).

### Extension surfaces

Plugins can:

- add CLI commands/queries via the Request dispatcher
- add web pages/endpoints via `Slim::Web::Pages`
- register protocol handlers via `Slim::Player::ProtocolHandlers`
- participate in scanning/import
- contribute menus for hardware UIs

Reading representative plugins (eg. `Podcast`, `RandomPlay`) and the focused guidance in [music-service-plugin.md](music-service-plugin.md) are practical onboarding exercises.

## End-to-end flows

### Startup flow

1. `slimserver.pl` bootstraps bundled dependencies
2. core utilities initialize (logging, prefs, strings)
3. the schema connects and migrates if needed
4. networking stacks start (HTTP, SlimProto, async HTTP/DNS)
5. core subsystems come online (menus, alarms, Jive services)
6. plugins load
7. server enters the event loop

### Web UI or JSON-RPC request

1. HTTP request accepted by [Slim/Web/HTTP.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/HTTP.pm)
2. routed to a page handler or raw endpoint
3. JSON-RPC calls enter [Slim/Web/JSONRPC.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/JSONRPC.pm)
4. mapped to `Slim::Control::Request`
5. dispatched to queries/commands
6. serialized back over HTTP

### Player starts playback

1. user action issues a Request (eg. playlist play)
2. `Slim::Player::Song` instantiates from playlist + DB track
3. a protocol handler is selected
4. optional scan resolves redirects/metadata
5. `Slim::Player::StreamingController` manages buffering/start
6. data flows from source (direct/proxied/transcoded)
7. audio is delivered over SlimProto or HTTP streaming

### Library scan

1. user triggers `rescan`
2. server invokes [Slim/Music/Import.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Music/Import.pm)
3. [scanner.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/scanner.pl) runs importers and updates the DB
4. progress notifications fire
5. on `rescan done`, caches clear and UI/player views refresh

## Practical onboarding checkpoints

Start with the surface area you need to debug or extend.

### Playback issues

- player state/events: [Slim/Player/StreamingController.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/StreamingController.pm)
- per-track behavior: [Slim/Player/Song.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/Song.pm)
- URL handling: [Slim/Player/ProtocolHandlers.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Player/ProtocolHandlers.pm) and `Slim/Player/Protocols/*`
- remote scanning references: [DEVELOPERS.txt](https://github.com/LMS-Community/slimserver/blob/HEAD/DEVELOPERS.txt)

### API or UI issues

- HTTP server/routing: [Slim/Web/HTTP.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/HTTP.pm), [Slim/Web/Pages.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/Pages.pm)
- JSON-RPC plumbing: [Slim/Web/JSONRPC.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/JSONRPC.pm)
- Cometd/Jive: [Slim/Web/Cometd.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Web/Cometd.pm)
- core queries: [Slim/Control/Queries.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Control/Queries.pm)

### Library or scan issues

- orchestration: [Slim/Music/Import.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Music/Import.pm), [scanner.pl](https://github.com/LMS-Community/slimserver/blob/HEAD/scanner.pl)
- type detection: [Slim/Music/Info.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Music/Info.pm), [types.conf](https://github.com/LMS-Community/slimserver/blob/HEAD/types.conf)
- schema/ORM: [Slim/Schema.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Schema.pm) and `Slim/Schema/*`

### Plugin work

- lifecycle management: [Slim/Utils/PluginManager.pm](https://github.com/LMS-Community/slimserver/blob/HEAD/Slim/Utils/PluginManager.pm)
- reference plugins: explore [Slim/Plugin/](https://github.com/LMS-Community/slimserver/tree/HEAD/Slim/Plugin) implementations

## Glossary

- **Client / Player** — controllable playback device (hardware or software)
- **SlimProto** — binary protocol used by Squeezebox players to talk to LMS
- **Request** — internal command/query object
- **Query** — request that returns data without mutating state
- **Command** — request that mutates state and may emit notifications
- **Notification** — pub/sub event emitted on changes (playlist changes, scan done, etc.)
- **Track** — DB-backed object representing a library item
- **Song** — runtime playback wrapper around a `Track`
- **Protocol handler** — code that knows how to scan/stream a URL scheme
