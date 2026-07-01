# At Your Service

## Project Context

This is a Flutter rebuild of the **At Your Service** home services marketplace.

The previous local project folder was lost from:

`/Users/thuthukaninxumalo/Downloads/at_your_service_mvp1_flutter`

We are rebuilding inside:

`/Users/thuthukaninxumalo/Documents/Codex/2026-05-21/home-services`

## Product Direction

At Your Service is a South African home services marketplace for customers, service providers, and administrators.

The app should feel premium, trustworthy, practical, and investor-ready. It should avoid a generic dashboard look. The target quality bar is closer to modern consumer marketplace and banking apps: clear flows, strong spacing, polished cards, useful icons, and concise wording.

Currency should use South African Rand: `R`.

### Visual design reference

There were two design references in this project's history. **The second
supersedes the first — use it as the source of truth:**

1. ~~A screenshot mockup (2026-06-19) with a navy/gold-then-blue palette~~ —
   superseded by #2 below. The structural lesson from it still stands (see
   below), but its exact colors/typography do not.
2. **`/Users/thuthukaninxumalo/Downloads/design_handoff_at_your_service/`**
   (2026-06-19/20) — a proprietary-format interactive HTML prototype
   (`At Your Service.dc.html`) plus `README.md` with the full design-token
   spec, covering ~28 screens across all three roles. **This is the
   authoritative spec.** Read the README's Design Tokens section and search
   the HTML for `<!-- ===== ROLE · SCREEN ===== -->` comment banners before
   building any new screen — copy exact copy, spacing, and data shapes from
   there rather than improvising. The HTML/JS itself is a reference, not
   code to lift directly (see the README's "About the Design Files").

Structural lesson that carried over from #1 and still applies: **it must
read as a mobile app, not a responsive website.** A persistent bottom
navigation bar per role, and (when running in a browser during development)
content constrained to a phone-width column rather than stretched
edge-to-edge. See `lib/core/widgets/mobile_frame.dart` and
`lib/core/widgets/role_nav_shell.dart`.

Current design tokens (from the handoff, see `lib/core/theme/`):
- **Fixed accents** (same light & dark) — `AppColors`: primary blue
  `#2E7DFF`, amber `#FFC107` (brand mark + "do the thing now" CTAs: Book
  Now, Accept — see `AppTheme.amberAction`), success green `#2ECC71`,
  danger `#FF4D67`, purple `#9B59B6` (Painting category).
- **Theme-variant surface/text tokens** — `AppTokens`
  (`lib/core/theme/app_tokens.dart`, a `ThemeExtension`), named to match the
  handoff's own `--bg/--surface/--card/--elev/--line/--tx/--mut/--chip`
  vocabulary. Look these up via `context.tokens` (see the
  `AppTokensContext` extension) rather than hardcoding colors — that's what
  makes light/dark both work from one widget tree.
- **The app ships dark-by-default** (`ThemeMode.dark` in `app.dart`); light
  theme exists (`AppTheme.light()`) but there's no in-app toggle yet.
- **Typography:** Manrope via `google_fonts` (`GoogleFonts.manropeTextTheme`
  in `AppTheme._build`). Note: `google_fonts` fetches/caches at runtime by
  default — fine for this stage, revisit (bundle as assets) before a
  no-network-on-first-launch production release.
- **Icons:** Lucide via the `lucide_icons` pub package, not Material icons,
  for any new screen work — matches the handoff exactly. Note this package
  version doesn't have every modern Lucide name; confirmed substitutions:
  `house`→`LucideIcons.home`, `paint-roller`→`LucideIcons.paintbrush2`,
  `user-round`→`LucideIcons.user`, `ellipsis`→`LucideIcons.moreHorizontal`,
  `circle-check`→`LucideIcons.checkCircle2`. Check
  `~/.pub-cache/hosted/pub.dev/lucide_icons-*/lib/lucide_icons.dart` if a
  name from the spec doesn't resolve.
- Bottom nav tabs beyond the first (Home/Jobs/Overview) are intentionally
  `ComingSoonTab` placeholders until their milestone lands — that's the
  agreed scope, not an oversight.

## Core User Roles

- Customer: browses services, books jobs, tracks bookings, reviews job details.
- Provider: applies to join, waits for approval, manages profile, accepts jobs, updates job status.
- Admin: reviews provider applications, manages service categories and services, tracks bookings and marketplace health.

## Initial Rebuild Milestones

1. Recreate the Flutter app structure cleanly.
2. Build high-quality mock/local flows before reconnecting Firebase.
3. Add role selection and role-based navigation.
4. Implement customer marketplace screens.
5. Implement provider onboarding and jobs.
6. Implement admin approval and service management.
7. Reconnect Firebase Auth and Firestore after the local flows are stable.
8. Add QA tests for role flow and marketplace booking flow.

## Important Constraints

- Keep changes scoped and readable.
- Prefer Flutter Material 3 and native Flutter widgets unless a package clearly earns its place.
- Do not add Firebase back until the local UX and navigation structure are stable.
- Avoid hardcoding future production secrets or credentials.
- Run `flutter analyze` after meaningful code changes.
- Update tests when visible flow behavior changes.

## Collaboration Notes

Codex and Claude Code may both work in this project. Before changing files:

- Read the current directory structure.
- Check `git status` if this project has been initialized as a git repo.
- Do not overwrite user or other-agent work blindly.
- If proposing design changes, preserve the app's role flow: customer, provider, admin.

## Current State

Milestones 1-3 are done. Milestone 4 (customer marketplace screens) is
in progress, being built screen-by-screen against the design handoff's
Customer flow: splash → onboarding → auth → **home (done)** → service →
book → pay → track → rate. Provider/Admin still have their pre-handoff
placeholder home screens (functional, but not yet re-built against the
handoff's `prov_*`/`admin_*` screen specs — that's next, role by role).

- `lib/core/` — theme (`AppColors` fixed accents, `AppTheme` light/dark
  builder + `AppTheme.amberAction`, `AppTokens` theme-variant surface/text
  tokens — see Visual design reference above), currency formatting, and
  shared widgets (`AppCard`, `SectionHeader`, `StatusChip`, `StatTile`,
  `MobileFrame`, `RoleNavShell`/`NavTab` (with `showBadge`), `ComingSoonTab`).
- `lib/models/` — `UserRole`, `ServiceCategory` (now carries `tint` +
  `price`), `ServiceListing` (`providerName` is nullable — null means
  "verified pros" generally, not one named provider), `Booking`,
  `JobRequest`, `ProviderApplication` (plain Dart, no backend coupling).
- `lib/features/role_select/` — `RoleSelectScreen` (the handoff's
  "chooser"), rebuilt pixel-accurate to the handoff: amber house-mark logo,
  "I need a service / Customer / ..." card hierarchy (action phrase is the
  bold title, role name is the colored tag below it — not the other way
  round), trust badge row.
- `lib/features/customer/` — `CustomerShell` (bottom nav: Home,
  Bookings\*, Messages\* with red badge dot, Profile\*) wrapping
  `CustomerHomeScreen`, rebuilt pixel-accurate to the handoff's `cust_home`:
  location pill, greeting, search bar + filter button (both tap targets,
  not yet wired to real search/filter — show a "coming soon" snackbar,
  matching the prototype where these aren't interactive either), 4-up
  category grid (Cleaning/Plumbing/Electrical/Painting, exact handoff
  data), gradient promo card (whole card is one tap target, not just the
  "Book Now" pill — matches the prototype's `onClick` placement), single
  Recommended listing card. Category tap, promo tap, and recommended-card
  tap all go to Service Details next (not built yet) — show "coming soon"
  honestly rather than faking navigation.
- `lib/features/provider/` — `ProviderShell` (bottom nav: Jobs,
  Schedule\*, Earnings\*, Profile\*) wrapping `ProviderHomeScreen`
  (pre-handoff design, still functional): application status banner,
  stats, job requests with working Accept/Decline (local state).
- `lib/features/admin/` — `AdminShell` (bottom nav: Overview, Bookings\*,
  Providers\*, More\*) wrapping `AdminHomeScreen` (pre-handoff design,
  still functional): marketplace stats, provider approval queue with
  working Approve/Reject (local state).

  (\* = `ComingSoonTab` placeholder — intentional, see design reference above.)

State management is plain `StatefulWidget`/`setState` (or plain
`StatelessWidget` for screens with no interaction yet, e.g.
`CustomerHomeScreen`) — no state management package added. New pub deps:
`lucide_icons`, `google_fonts` (both justified by the handoff's explicit
icon/typography spec — see Visual design reference above).

Verified with:

```sh
/Users/thuthukaninxumalo/development/flutter/bin/flutter analyze
/Users/thuthukaninxumalo/development/flutter/bin/flutter test
```

Both pass (4 widget tests covering role navigation). Also manually verified
by running on Chrome (`flutter run -d chrome`) and screenshotting all four
screens.

Gotchas hit and fixed (still apply going forward):
- A `Text` placed directly in a `Row` (without `Expanded`/`Flexible`) gets
  *unbounded* width during layout and can overflow even when the visible
  space looks plenty wide — wrap header/title text in `Expanded`/`Flexible`
  with `overflow: TextOverflow.ellipsis`. Hit this repeatedly (search bar,
  section headers, location pill) — check every new `Row` containing a
  `Text` sibling.
- Avoid `Spacer()`-based vertical centering in a plain `Column`; on short
  viewports (small phones, or the default ~600px-tall widget-test surface)
  it overflows instead of shrinking — use a scrollable `Column` with fixed
  gaps, or a `ConstrainedBox(minHeight:)` + `SingleChildScrollView` pattern
  instead (see `RoleSelectScreen`).
- When changing anything in `AppColors`/`AppTokens`, run `flutter analyze`
  immediately — every screen referencing an old field name fails loudly
  and the fix list is mechanical but easy to miss one of.

Next up per the milestone list: Service Details → Book & Schedule → Review
& Pay → Track Booking → Rate & Review (the rest of the Customer flow, in
that order per the handoff), then Splash/Onboarding/Auth as the real entry
flow ahead of `RoleSelectScreen`, then Provider/Admin screens rebuilt
against the handoff, then reconnect Firebase.
