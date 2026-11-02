# 42 API reference — fields Swifty Companion actually uses

Working notes on the JSON shapes we're coding against. Confidence level noted per
field — anything "assumed" gets checked against a real response once the
networking layer exists (see Verification plan below), and this file gets
corrected if reality disagrees.

## POST /oauth/token (client_credentials grant)

`access_token`, `token_type`, `expires_in`, `created_at` — used by `OAuthToken.swift`.

## GET /v2/users/:login

**Confirmed** against api.intra.42.fr/apidoc: `id`, `email`, `login`, `image`,
`correction_point`, `wallet`, `cursus_users`, `projects_users`.

**Assumed, not yet independently confirmed** (matches strong general convention,
but not verified against a live response yet): `phone`, `displayname`, `location`.

### image

**Assumed shape** (matches general convention, not yet verified against a
live response): `{ "link": String?, "versions": { "large": String?,
"medium": String?, "small": String?, "micro": String? } }` — every field a
plain URL (text), not image data. Unconfirmed: whether a student with no
uploaded photo gets `null` here or a default placeholder URL.

### cursus_users[]

**Confirmed**: `id`, `begin_at`, `end_at`.
**Assumed**: `level` (Double), `skills` (array of `{id, name, level}`), `cursus` (`{id, name}`).

### projects_users[]

**Confirmed**: `id`, `occurrence`, `final_mark`, `status`, `"validated?"` (literal
question mark in the key — confirmed, not a typo), `current_team_id`, `project`,
`cursus_ids`, `user`, `teams`. We only model: `id`, `final_mark`, `status`,
`validated?`, `project.id`, `project.name`.

## Verification plan

Once `TokenManager` + `APIClient` exist, we log one real raw JSON response for a
known login and diff it against this file — anything "assumed" above gets
promoted to "confirmed" or corrected.

## Sources

- https://api.intra.42.fr/apidoc
- https://api.intra.42.fr/apidoc/2.0/users/show.html
- https://api.intra.42.fr/apidoc/2.0/projects_users/show.html
- https://api.intra.42.fr/apidoc/2.0/cursus_users/index.html
