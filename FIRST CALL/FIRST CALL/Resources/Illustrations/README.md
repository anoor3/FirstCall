Illustrations folder

Add step illustration images here so they can be shown by `StepIllustrationView`.

How to wire this folder in Xcode
1) In Xcode, drag `Resources/Illustrations` into the Project Navigator.
2) In the dialog, check your app target under “Add to targets”.
3) Choose “Create folder references” (the blue folder) so any new files you add are bundled automatically.
4) Confirm the folder (or its images) appear under Build Phases → Copy Bundle Resources.

File naming
- Name each image exactly as the step’s `illustrationName` value (case‑sensitive), for example:
  - `choking_back_blows@2x.png`, `choking_back_blows@3x.png`
  - `choking_abdominal_thrusts@2x.png`, `choking_abdominal_thrusts@3x.png`
- Supported types: PNG/JPEG/PDF. For PDFs, a single vector PDF is fine.

Current keys used in data
- choking_back_blows
- choking_abdominal_thrusts
- cpr_hands_only
- recovery_position
- nosebleed_pinch
- bleeding_direct_pressure
- burns_cool_water
- (plus any new ones you add for new topics)

Notes
- `StepIllustrationView` already uses `Image(name)`, so anything in the bundle with that exact name will load (asset catalog or this folder reference).
- Set “Render As: Original Image” if you use the asset catalog instead.

