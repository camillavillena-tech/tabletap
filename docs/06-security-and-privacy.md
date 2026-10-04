# Security and privacy

This repository is public. We filled this in honestly and dated it because it is
checked as part of grading.

**Last checked:** 2026-10-04

## What this app stores

| Data | Where it lives | Who can see it |
| --- | --- | --- |
| Customer orders | on the device/browser using `shared_preferences` | users of the same browser/device storage |
| Order items, quantities, totals, notes, queue numbers, table numbers, and order status | on the device/browser using `shared_preferences` | Customer and Staff modes running in the same browser/device |
| Staff demo login credentials | inside the app code for demonstration purposes | anyone who can view the public source code |

TableTap currently does not send order data to an external server or cloud
database. The Customer and Staff sides only share data because they use the same
local browser or device storage.

## Secrets

- Values our app needs at run time: none
- Where they live locally: no `.env` file is currently required because our app does not use private API keys or backend credentials
- Where the deploy workflow gets them: no repository secrets are currently required
- Anything our deployed web build carries that a visitor could read, and why that is acceptable: the app contains demo Staff login credentials and other prototype values that are visible in the public source code. These are not real credentials and are only used for demonstration purposes

Our current project does not use Firebase, Supabase, or another hosted backend.

## What protects the data on the service side

Nothing leaves the device in the current TableTap prototype.

Our app stores order data locally using `shared_preferences`, so there are no
Firestore rules, Supabase RLS policies, or other service-side access rules to
configure.

Because our repository is public, no real passwords, API keys, tokens, service
account files, or personal user data should be committed.

## Checklist

- [x] `.env` (or `env.json`) is in `.gitignore`, and `.env.example` is committed
- [x] `git log -p | grep -i "api_key\|secret\|password\|token"` was reviewed and contains no real API keys, tokens, or private credentials
- [x] No service account file, keystore or `service_role` key anywhere in the repo
- [x] Security rules or RLS policies written and tested, not left open
- [x] No real personal data in sample data, screenshots or the video
- [x] No course or university credentials anywhere
- [x] Anyone whose data appears in a test was asked first

The security rules/RLS checklist item is marked complete because TableTap does
not currently use a cloud database or hosted backend. There are therefore no
service-side security rules for us to configure.

We reviewed the Git history for API keys, secrets, passwords, and tokens. The matches were limited to demo credentials, placeholder values, workflow examples, and documentation. We did not find any real API key, token, service account credential, or private backend secret that needed to be revoked.