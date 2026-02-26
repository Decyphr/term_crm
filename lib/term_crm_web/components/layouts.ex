defmodule TermCrmWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use TermCrmWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="flex h-screen bg-black overflow-hidden">
      <%!-- Sidebar --%>
      <aside class="w-[230px] shrink-0 flex flex-col bg-black border-r border-green-900/40">
        <%!-- Logo --%>
        <div class="px-5 py-5 border-b border-green-900/40">
          <.link href={~p"/clients"} class="flex items-center gap-2 group">
            <.icon name="hero-command-line" class="size-5 text-green-400" />
            <span class="text-green-400 font-bold text-sm tracking-[3px] uppercase group-hover:text-green-300 transition-colors">
              TermCRM
            </span>
          </.link>
        </div>

        <%!-- Nav --%>
        <nav class="flex-1 px-2 py-4 space-y-0.5 overflow-y-auto">
          <.nav_item icon="hero-squares-2x2" label="Dashboard" href={~p"/clients"} />
          <.nav_item icon="hero-user-group" label="Clients" href={~p"/clients"} active={true} />
          <.nav_item icon="hero-tag" label="Contracts" href={~p"/clients"} />
          <.nav_item icon="hero-folder" label="Projects" href={~p"/clients"} />
          <.nav_item icon="hero-check-circle" label="Tasks" href={~p"/clients"} />
          <.nav_item icon="hero-document-text" label="Invoices" href={~p"/clients"} />
        </nav>

        <%!-- User --%>
        <%= if @current_scope do %>
          <div class="dropdown dropdown-right dropdown-end flex items-center gap-3 rounded px-2 py-2 hover:bg-green-900/20 transition-colors group">
            <div tabindex="0" role="button" class="btn bg-transparent border-none m-1">
              <div class="size-8 rounded-full bg-yellow-500 flex items-center justify-center shrink-0">
                <span class="text-black text-xs font-bold">
                  {String.first(@current_scope.user.email) |> String.upcase()}
                </span>
              </div>
              <div class="flex flex-col min-w-0">
                <span class="text-green-400 text-xs font-medium truncate group-hover:text-green-300 transition-colors">
                  {@current_scope.user.email}
                </span>
                <span class="text-green-700 text-[10px] uppercase tracking-widest">Freelancer</span>
              </div>
            </div>
            <ul
              tabindex="-1"
              class="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm"
            >
              <li>
                <.link
                  href={~p"/users/settings"}
                  class=""
                >
                  Account Settings
                </.link>
              </li>
              <li><a>Item 2</a></li>
            </ul>
          </div>
        <% end %>
      </aside>

      <%!-- Main content --%>
      <main class="flex-1 overflow-y-auto bg-black">
        <div class="p-6 max-w-7xl mx-auto">
          {render_slot(@inner_block)}
        </div>
      </main>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  attr :icon, :string, required: true
  attr :label, :string, required: true
  attr :href, :string, required: true
  attr :active, :boolean, default: false

  defp nav_item(assigns) do
    ~H"""
    <.link
      href={@href}
      class={[
        "flex items-center gap-3 px-3 py-2 rounded text-xs font-medium tracking-widest uppercase transition-colors",
        @active && "bg-green-900/30 text-yellow-400",
        !@active && "text-green-600 hover:text-green-400 hover:bg-green-900/20"
      ]}
    >
      <.icon name={@icon} class="size-4 shrink-0" />
      {@label}
    </.link>
    """
  end

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  slot :inner_block, required: true

  def auth(assigns) do
    ~H"""
    <.marketing_header current_scope={@current_scope} />

    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <div class="mx-auto max-w-2xl space-y-4">
        {render_slot(@inner_block)}
      </div>
    </main>

    <.flash_group flash={@flash} />
    """
  end

  attr :flash, :map, required: true
  attr :current_scope, :map, default: nil
  slot :inner_block, required: true

  def marketing(assigns) do
    ~H"""
    <.marketing_header current_scope={@current_scope} />
    <main>
      {render_slot(@inner_block)}
    </main>
    <.footer />

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="term_crm"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end

  attr :current_scope, :map, default: nil

  def marketing_header(assigns) do
    ~H"""
    <div class="navbar fixed top-0 left-0 right-0 bg-base-100 border-b border-b-primary/20 shadow-sm z-40 px-4 sm:px-6 lg:px-8">
      <div class="navbar-start">
        <div class="dropdown">
          <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h8m-8 6h16"
              />
            </svg>
          </div>
          <ul
            tabindex="-1"
            class="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow"
          >
            <li><a>Features</a></li>
            <li><a>Pricing</a></li>
            <li><a>Docs</a></li>
          </ul>
        </div>
        <.link href={~p"/"} class="btn font-semibold text-base tracking-[1px] uppercase">
          $ termcrm<span class="animate-pulse">_</span>
        </.link>
        <div class="px-4 hidden lg:flex mr-auto">
          <ul class="menu menu-horizontal px-1 text-xs text-base-content/70 uppercase">
            <li><a>Features</a></li>
            <li><a>Pricing</a></li>
            <li><a>Docs</a></li>
          </ul>
        </div>
      </div>

      <div class="navbar-end">
        <ul class="menu menu-horizontal w-full relative flex items-center gap-4 justify-end">
          <%= if @current_scope do %>
            <li>
              <.link href={~p"/clients"}>Dashboard</.link>
            </li>
          <% else %>
            <li>
              <.link href={~p"/users/log-in"} class="btn btn-outline btn-primary">Log in</.link>
            </li>
            <li>
              <.link href={~p"/users/register"} class="btn btn-primary">&gt;_ Register</.link>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def footer(assigns) do
    ~H"""
    <div class="bg-base-300 px-4 sm:px-6 lg:px-8">
      <footer class="max-w-7xl mx-auto text-base-content py-10 flex flex-col sm:flex-row gap-10">
        <aside class="flex-1">
          <p class="font-semibold text-base tracking-[1px] uppercase">
            $ termcrm<span class="animate-pulse">_</span>
          </p>
          <p class="text-muted">For developers who ship.</p>
        </aside>
        <div class="flex flex-col sm:flex-row gap-10 lg:gap-24 text-sm text-base-content/70">
          <nav class="flex flex-col gap-2">
            <h4 class="mb-2 text-base-content text-xs uppercase tracking-[1px]">Product</h4>
            <a class="link link-hover">Features</a>
            <a class="link link-hover">Pricing</a>
            <a class="link link-hover">Changelog</a>
            <a class="link link-hover">Roadmap</a>
          </nav>
          <nav class="flex flex-col gap-2">
            <h4 class="mb-2 text-base-content text-xs text-base-content uppercase tracking-[1px]">
              Resources
            </h4>
            <a class="link link-hover">Documentation</a>
            <a class="link link-hover">API Reference</a>
            <a class="link link-hover">Github</a>
            <a class="link link-hover">Status</a>
          </nav>
          <nav class="flex flex-col gap-2">
            <h4 class="mb-2 text-base-content text-xs text-primary uppercase tracking-[1px]">
              Legal
            </h4>
            <a class="link link-hover">Privacy policy</a>
            <a class="link link-hover">Terms of use</a>
          </nav>
        </div>
      </footer>
      <div class="w-full h-[1px] bg-muted max-w-7xl mx-auto" />
      <div class="max-w-7xl mx-auto text-base-content py-10 flex flex-col sm:flex-row sm:justify-between gap-10">
        <p class="text-xs text-muted">
          &copy; 2026 TERMCRM. All rights reserved.
        </p>
        <p class="text-xs text-muted">BUILD #2026.02.24 // SHA:a3f8c1d</p>
      </div>
    </div>
    """
  end
end
