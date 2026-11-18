---
name: RentFlow
description: A dark-first, platform-aware visual system for rental operations.
colors:
  blue-accent: "#155FC0"
  blue-accent-bright: "#3687FF"
  blue-cta-start: "#1F6FF0"
  blue-cta-end: "#145BD1"
  night-ground: "#050B14"
  night-panel: "#07111F"
  night-input: "#0B1726"
  night-border: "#1B2A3D"
  night-text: "#F3F6FC"
  night-muted: "#9AACC2"
  light-ground: "#F5F7FA"
  light-panel: "#FCFDFE"
  light-input: "#F7F9FC"
  light-border: "#E2E8F0"
  light-text: "#14263C"
  light-muted: "#62748A"
  night-scrim: "#03101E"
  night-error: "#FF9299"
  light-error: "#B42336"
  white-text: "#FFFFFF"
  night-toggle: "#091728B3"
typography:
  display:
    fontFamily: "RentFlowDisplay"
    fontSize: "31px"
    fontWeight: 800
    lineHeight: 1.15
    letterSpacing: "-0.7px"
  body:
    fontFamily: "SF Pro, Roboto, sans-serif"
  label:
    fontFamily: "SF Pro, Roboto, sans-serif"
rounded:
  provider: "14px"
  field: "15px"
  toggle: "24px"
  panel: "32px"
spacing:
  xs: "8px"
  sm: "12px"
  md: "16px"
  lg: "24px"
  xl: "32px"
components:
  auth-panel-dark:
    backgroundColor: "{colors.night-panel}"
    rounded: "{rounded.panel}"
    padding: "16px 23px 8px"
  auth-panel-light:
    backgroundColor: "{colors.light-panel}"
    rounded: "{rounded.panel}"
    padding: "16px 23px 8px"
  auth-field-dark:
    backgroundColor: "{colors.night-input}"
    textColor: "{colors.night-text}"
    rounded: "{rounded.field}"
    padding: "16px 15px"
  auth-field-light:
    backgroundColor: "{colors.light-input}"
    textColor: "{colors.light-text}"
    rounded: "{rounded.field}"
    padding: "16px 15px"
  button-primary:
    backgroundColor: "{colors.blue-cta-start}"
    textColor: "#FFFFFF"
    rounded: "{rounded.field}"
    height: "54px"
  provider-unavailable-dark:
    backgroundColor: "{colors.night-input}"
    textColor: "{colors.night-muted}"
    rounded: "{rounded.provider}"
    height: "54px"
  provider-unavailable-light:
    backgroundColor: "{colors.light-input}"
    textColor: "{colors.light-muted}"
    rounded: "{rounded.provider}"
    height: "54px"
  mode-tabs:
    backgroundColor: "{colors.night-panel}"
    textColor: "{colors.night-text}"
    height: "50px"
  mode-tabs-light:
    backgroundColor: "{colors.light-panel}"
    textColor: "{colors.light-text}"
    height: "50px"
  theme-toggle:
    backgroundColor: "{colors.night-toggle}"
    textColor: "{colors.white-text}"
    rounded: "{rounded.toggle}"
    size: "48px"
  rentflow-mark:
    textColor: "{colors.white-text}"
    size: "42px"
---

# Design System: RentFlow

## Overview

**Creative North Star: “The Night-Lit Welcome”**

The login screen pairs a quiet apartment-at-night photograph and warm window light with a restrained navy form surface. The screen starts in dark mode; a deliberate theme control exposes the supported light palette. The user-pinned direction is: “Dark Premium. Modern Real Estate SaaS. Giao diện Flutter Mobile. Bám sát bố cục hình tham chiếu thứ hai. Sang trọng, tối giản, hiện đại.”

The photo and compact custom-painted RF roofline mark establish RentFlow; the form stays the clearest, most legible part of the screen. The RF roofline mark is RentFlow's first-party brand mark, drawn in Flutter code rather than borrowed from an icon package. The supplied Vietnamese supporting line remains “Quản lý nhà trọ của bạn dễ dàng hơn.”

**Key Characteristics:**
- Night facade, warm residential light, and a deep navy overlapping panel.
- One precise blue family for selection, focus, links, and the primary action.
- Platform-native controls and honest service feedback.

## Colors

The blue family carries action and focus; the night palette is the default, with a complete light palette available through the in-app theme toggle. Exact values are normative in the frontmatter.

### Primary
- **RentFlow Blue:** `blue-accent` marks focus and selection; `blue-accent-bright` supports dark-mode links and the roofline mark. The primary action uses the `blue-cta-start` to `blue-cta-end` gradient.

### Neutral
- **Night surfaces and type:** `night-ground`, `night-panel`, and `night-input` separate the page, form, and fields; `night-border` stays restrained. `night-text` and `night-muted` carry primary and supporting text.
- **Light surfaces and type:** `light-ground`, `light-panel`, and `light-input` retain the same hierarchy in light mode, with `light-border`, `light-text`, and `light-muted` for boundaries and copy.
- **Legibility and validation:** `night-scrim` darkens the photograph; `night-error` and `light-error` identify invalid fields.

**The Single Blue Rule.** Keep blue tied to interactive meaning; do not add a second decorative accent.

## Typography

**Display Font:** `RentFlowDisplay`, the Flutter family mapped to Montserrat assets.
**Body Font:** Platform text roles: Cupertino system text on iOS and Material 3 roles on Android.

**Character:** The bundled geometric face gives the wordmark and welcome headline a confident display voice. Form content follows system roles so platform text scaling remains available.

### Hierarchy
- **Display** (requested weight 800, 31 logical px, 1.15 line height): the welcome headline. The bundled family includes Montserrat SemiBold (600) and Bold (700).
- **Wordmark** (700, 17 logical px): RentFlow beside the 42 px RF mark; this wordmark opts out of text scaling to preserve the lockup.
- **Body, title, supporting, and control:** use the current platform's body, title, supporting, and action/label roles rather than fixed per-screen sizes.

**The System Role Rule.** Keep form labels and entered text in adaptive platform roles; reserve `RentFlowDisplay` for brand display moments.

## Layout

The login viewport places the hero artwork at 49% of available height and begins the overlapping panel between 36% and 44%, with the panel's top edge at a broad radius. The form is centered and capped at 470 logical px, with 23 px horizontal inset and a 16 px top inset. Fields use a 10 px rhythm.

The panel is safe-area aware and scrolls above the keyboard. When the keyboard opens, the hero reduces to 24% height, the panel begins at 15%, and the logo, theme control, and welcome headline collapse. Provider options sit side by side when content width is at least 320 px and text scale is at most 1.25; otherwise they stack. Text scaling also increases the panel's resting top offset, up to 44%.

## Elevation & Depth

Depth comes from the real night-facade photograph, a dark gradient scrim, and the panel overlap. Surfaces have restrained borders and no decorative drop shadows. The welcome headline alone uses a soft text shadow for contrast over the photograph.

## Shapes

The panel has a 32 px top radius. Inputs and the primary action use 15 px corners; provider controls use 14 px corners; the theme control is circular. Borders stay thin and low contrast at rest, then the field border shifts to the blue accent on focus. The RF roofline geometry is a crisp, code-drawn mark.

## Components

### Auth panel and mode tabs
- The panel uses the active theme surface, a subtle top border, and a 16/23/8 px top/horizontal/bottom inset.
- Sign-in and registration share a two-tab row with a thin divider and a 2.5 px blue indicator. The indicator moves over 220 ms.
- Switching modes fades and rises the fields while the form resizes; the “Remember me” checkbox and its label both toggle the same state.

### Inputs and primary action
- Fields are filled, outlined, and at least 55 px tall on iOS. Focus and validation replace the resting border color; password visibility is an adjacent native control.
- The 54 px primary action uses a left-to-right blue gradient, white platform-role text, and a forward arrow.

### Provider options and service state
- Google and phone options remain visible with the exact status “Chưa cấu hình” and are disabled. No Google, phone, email/password, or recovery provider is connected: the repository has no auth repository, Firebase package, or configured provider. Validated sign-in and registration submissions show that authentication is unavailable; recovery also reports the missing service.

### Platform behavior
- Android uses Material controls; iOS uses Cupertino controls for the theme switch, tabs, fields, and actions. `Checkbox.adaptive` follows the platform. The screen honors safe areas, keyboard insets, and user text scaling.

## Do's and Don'ts

### Do:
- **Do** preserve the supplied Vietnamese supporting line and the pinned Dark Premium direction.
- **Do** keep all touch targets at least 48 logical px and preserve the scrollable form above the keyboard.
- **Do** keep provider status and unavailable-auth feedback truthful until a provider is configured.

### Don't:
- **Don't** add decorative shadows, extra accent colors, or a replacement logo asset.
- **Don't** style provider options as active or imply that sign-in, registration, phone, Google, or recovery is connected.
