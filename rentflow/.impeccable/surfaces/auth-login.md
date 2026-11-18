# RentFlow login

Mode: Operate. Scope: the Flutter sign-in and registration screen on Android and iOS. Primary users are owners and property managers. The task is to authenticate with an email address or phone number; Google, phone, password recovery, and registration are alternate entry points. The reference is a real-estate night facade with a rounded auth panel. Current repository evidence includes a Flutter scaffold and theme Cubit, but no auth repository, Firebase package, or configured provider.

## Direction contract

THESIS: A quiet apartment photograph frames the task: night in dark mode and clear daylight in light mode. The form remains the clearest, most legible part of the screen.

OWN-WORLD: Dark Premium, modern real-estate SaaS. Midnight navy surfaces, warm residential window light in dark mode, clear blue daylight in light mode, crisp theme-appropriate type, and one precise blue accent. Use a custom geometric RF roofline mark, restrained borders, and no decorative drop shadows.

STORY: The owner or manager recognizes RentFlow, selects sign-in or registration, enters account details, and receives truthful validation and service feedback. Provider buttons must not imply a connection that is absent.

FIRST VIEWPORT: A night apartment photograph in dark mode or its clear daylight counterpart in light mode fills roughly 39% of the phone height behind the RentFlow RF wordmark, welcome heading, and theme control. The theme switch also changes heading and logo contrast. A full-width panel overlaps the image with a large top radius. Tabs, short supporting copy, email/phone and password fields, remember and recovery controls, the blue primary action, provider options, and the registration link stack inside a scrollable safe area.

FORM: Code-led, pinned whole. `seed: none (pinned)` — “Dark Premium. Modern Real Estate SaaS. Giao diện Flutter Mobile. Bám sát bố cục hình tham chiếu thứ hai. Sang trọng, tối giản, hiện đại.” The signature interaction is a compact fade-and-rise transition between sign-in and registration fields; keyboard appearance collapses the hero and leaves the form scrollable above the IME.

## QUALITY BAR (task-pinned, not a catalog world card)

- **Frame:** Dark mode uses the photorealistic night facade and light mode uses its matching clear daylight version. Keep the daytime image crisp with only a minimal fade into the panel; theme-appropriate brand text stays readable. The photo occupies 35–45% of the first phone viewport and the form panel overlaps it with a broad top radius.
- **Material:** Layer with the photograph and restrained borders; avoid heavy shadows and decorative effects.
- **Lettering:** Use a bundled geometric display face for the RentFlow wordmark and welcome headline. Keep form copy in adaptive platform text roles and allow system text scaling without clipping.
- **Controls:** Keep Material controls on Android and Cupertino controls on iOS. Social options remain visible, but clearly read “Chưa cấu hình” and are disabled until a provider exists.
- **Touch:** Checkbox and its label both toggle remember-login; every target affords at least a 48 dp hit area.
- **Truth:** The requested description “Quản lý nhà trọ của bạn dễ dàng hơn.” is user-supplied copy and remains as requested. Never imply that authentication or a provider is connected when it is not.

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
