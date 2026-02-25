# Term CRM

This is a Phoenix application built to explore the framework and its capabilities. It serves as a simple CRM (Customer Relationship Management) system, allowing users to manage clients, projects, and invoices.

## Prerequisites

- Elixir 1.15 or higher
- Docker (for running the database and other services)

---

## Initial Setup

_You'll only need to do this once when first setting up the application locally_

1. Spin up locally database using docker compose:

   ```sh
   docker compose up -d
   ```

2. Install & setup dependencies:

   ```sh
   mix setup
   ```

3. Create and migrate the database:

   ```sh
   mix ecto.create
   mix ecto.migrate
   ```

4. Start development server (or start in IEx with `iex -S mix phx.server`):
   ```sh
   mix phx.server
   ```

## Spinning up the server

Start development server:

```sh
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
