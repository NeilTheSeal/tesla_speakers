---
document: WORK_HISTORY
project: Tesla Rear-Cabin Speaker
status: Active
version: 0.1
last_updated: 2026-07-18
current_phase: Fabrication readiness and physical verification
immediate_next_goal: Inventory the delivered equipment and commission the 3D printer with a documented calibration print
---

# Tesla Rear-Cabin Speaker — Work History

## 1. Purpose

This file is the chronological engineering record for the Tesla rear-cabin speaker project.

It documents:

- work completed
- decisions made
- artifacts created
- results observed
- assumptions used
- unresolved problems
- work that was considered but not implemented
- the current blocker or immediate next goal

This file is not a substitute for:

- `PROJECT.md`, which defines the high-level project purpose and architecture
- `REQUIREMENTS.md`, which defines the constraints the design must satisfy

The initial entries below reconstruct the project history from the current repository snapshot, supplied CAD and datasheet files, and the design discussion that preceded formal documentation. Exact dates are used only when they are known. Earlier work without a reliable date is grouped under a reconstructed baseline.

---

## 2. Maintenance Rules

When updating this file:

1. Add new work as a dated entry.
2. Record the result, not only the action.
3. Distinguish completed work from proposals and future ideas.
4. Include file paths, measurements, commits, or test data when available.
5. Record failures and rejected approaches; do not preserve only successful work.
6. State the next immediate goal as one small, actionable task.
7. Do not silently rewrite old results when later work changes the interpretation.
8. Add a correction or superseding entry instead.
9. Keep detailed requirements in `REQUIREMENTS.md`.
10. Keep broad project direction in `PROJECT.md`.

---

# 3. Current Snapshot

## Current phase

**Fabrication readiness and physical verification before the first full print**

The current repository contains a complete parametric two-driver enclosure model and generated STEP/STL exports. The mechanical model already includes two isolated sealed chambers, driver openings, internal bracing, isolation feet, cable-gland openings, and cosmetic exterior features.

The 3D printer, speakers, filament, tools, and additional project supplies have now been reported as delivered. Exact models, quantities, material types, and dimensions have not yet been inventoried or verified. The project can therefore move from planning-only work into physical validation, but it is not ready for a full enclosure print.

The project architecture has since expanded from a two-driver active prototype to a three-driver system using:

- one woofer channel
- one combined midrange/tweeter channel
- an active DSP crossover between the woofer and upper section
- a passive crossover between the midrange and tweeter

The current enclosure source has not yet been revised to include the tweeter, passive crossover access, binding posts, or removable service panels.

## Immediate next goal

**Inventory the delivered equipment and commission the 3D printer with a documented calibration print.**

The first work session should:

1. Record the printer model, nozzle size, build surface, and available slicer.
2. Record each filament type, diameter, and manufacturer; keep standard PLA limited to coupons and short-duration fit work.
3. Identify the physical woofer, midrange, and tweeter by exact model number and inspect for shipping damage.
4. Sort fasteners, inserts, gasket materials, terminals, wire, adhesives, and measurement tools by intended use.
5. Assemble and calibrate the printer according to its manufacturer procedure.
6. Print one small manufacturer-recommended calibration model and record material, profile, result, and any dimensional error.

This is the next task because every subsequent fit coupon and enclosure decision depends on knowing what hardware and material are actually available and whether the printer can produce dimensionally useful parts. After this gate passes, physically measure the drivers and vehicle envelope, then return to the removable-panel CAD revision and feature coupons.

## Current major blockers

- The physical woofer and midrange have not yet been used to verify all modeled mounting dimensions.
- The tweeter is not present in `parts/part.lua`.
- The exact tweeter position and orientation have not been selected.
- No removable service panel exists.
- Binding posts have not been integrated into the enclosure.
- Driver fasteners and insert geometry have not been finalized.
- Gasket grooves have not been added to removable joints.
- Chamber net volumes have not been formally calculated from the final design.
- No enclosure alignment simulation has been completed.
- No acoustic or impedance measurements have been recorded.
- No passive midrange/tweeter crossover has been designed from measurements.
- No positive vehicle crash restraint has been designed.
- The current generated enclosure has not yet been printed or test-fitted in the vehicle.

---

# 4. Current Design Baseline

## Source model

- **Primary parametric source:** `parts/part.lua`
- **CAD system:** CodeCAD
- **Language:** Lua
- **Project definition:** `project.json`
- **Units:** millimeters
- **Generated exports:** `generated/part.step` and `generated/part.stl`

The supplied `project.json` defines one visible part sourced from `parts/part.lua`, at unit scale with no transform.

## Nominal cabinet-body dimensions

The current source model defines:

| Parameter               |     Current value |
| ----------------------- | ----------------: |
| Outside width           | 241.3 mm / 9.5 in |
| Cabinet length          |            410 mm |
| Cabinet body height     |            220 mm |
| Wall thickness          |              8 mm |
| Divider start position  |        Y = 270 mm |
| Divider thickness       |              8 mm |
| Raised baffle thickness |             12 mm |
| Exterior edge chamfer   |              3 mm |

These are body and feature parameters, not the complete installed envelope.

## Generated STL envelope

A mesh inspection of the supplied `part.stl` on 2026-07-18 produced:

| Result                                         |     Value |
| ---------------------------------------------- | --------: |
| Overall X extent                               |  246.3 mm |
| Overall Y extent                               |  415.0 mm |
| Overall Z extent                               | 253.05 mm |
| Connected mesh components                      |         1 |
| Topologically watertight after mesh processing |       Yes |

The additional extent beyond the nominal cabinet body comes from features such as exterior ribs, corner bumpers, raised baffles, and feet.

This result confirms that the current generated mesh remains within the stated 420 × 420 × 480 mm printer build volume. Mesh watertightness does **not** prove that the physical print will be airtight.

## Preliminary gross chamber-volume calculation

A simple calculation from the current Lua parameters gives the following gross rectangular cavity volumes before subtracting braces, driver displacement, wire hardware, fillets, or other internal features:

| Chamber                             | Approximate gross volume |
| ----------------------------------- | -----------------------: |
| Woofer chamber                      |                  12.04 L |
| Midrange chamber                    |                   5.70 L |
| Combined gross volume after divider |                  17.74 L |

These are not final net acoustic volumes.

The manufacturer datasheets provide example sealed-box volumes of approximately:

- 16 L for the 22W/4851T00 woofer
- 0.9 L for the 12MU/4731T00 midrange

The current geometry therefore requires deliberate enclosure analysis rather than assuming that the modeled chamber division is acoustically final. The large midrange volume is especially likely to be revised or internally reduced.

---

# 5. Reconstructed Project History

## WH-001 — Initial goal established

- **Date:** Before formal documentation
- **Status:** Completed
- **Work:** Defined the general goal of improving the Tesla Model 3 rear-cabin sound with a custom high-quality speaker enclosure.
- **Result:** The project was framed as a custom, measurement-tuned loudspeaker rather than a simple off-the-shelf speaker installation.
- **Current relevance:** Still active.

## WH-002 — Rear-deck location investigated and rejected

- **Date:** Before formal documentation
- **Status:** Completed decision
- **Work:** Considered placing an approximately 8-inch speaker enclosure on the rear parcel shelf.
- **Result:** The rear-deck concept was rejected because an enclosure large enough to be useful would substantially obstruct rear-window visibility.
- **Decision:** Move the enclosure to the rear floor behind the center console.
- **Current relevance:** Superseded location concept; retained as design history.

## WH-003 — Rear-center floor location selected

- **Date:** Before formal documentation
- **Status:** Completed decision
- **Work:** Evaluated the rear floor behind the center console as the installation location.
- **Result:** The location was selected because it:
  - avoids blocking the rear window
  - provides more usable enclosure volume
  - supports the enclosure from the floor
  - permits reversible installation
  - can use a centered mono speaker architecture
- **Open issue:** Exact vehicle contour and positive restraint remain unresolved.

## WH-004 — Amplifier capabilities established

- **Date:** Before formal documentation
- **Status:** Completed
- **Work:** Confirmed that the vehicle amplifier provides two independent outputs, each nominally rated at 65 W into 4 ohms.
- **Result:** Each output can independently use:
  - arbitrary input routing and input mixing
  - left/right contribution control
  - crossover filters
  - EQ
  - delay and time alignment
  - gain and panning
  - dynamics processing
- **Design effect:** The two outputs do not need to represent fixed left and right channels.

## WH-005 — Two-channel system architecture selected

- **Date:** Before formal documentation
- **Status:** Completed decision
- **Work:** Compared multiple ways to power three drivers from two amplifier outputs.
- **Result:** Selected the following hybrid architecture:

```text
Amplifier output 1
    -> DSP low-pass
    -> woofer

Amplifier output 2
    -> DSP high-pass
    -> passive crossover
        -> midrange
        -> tweeter
```

- **Reason:** This keeps the low-frequency woofer/midrange transition in DSP and avoids large passive low-frequency crossover components.
- **Open issue:** Exact crossover frequencies and slopes remain measurement-dependent.

---

# 6. Driver Selection and Reference Data

## WH-006 — Woofer selected

- **Date:** Before formal documentation
- **Status:** Completed
- **Component:** Scan-Speak Revelator 22W/4851T00
- **Nominal impedance:** 4 ohms
- **Repository references:**
  - `22w-4851t00.pdf`
  - `22W-4851T00.STEP`
- **Important manufacturer data recorded:**
  - resonance frequency: 21 Hz
  - sensitivity: 89 dB at 2.83 V / 1 m
  - operating range: Fs–3000 Hz
  - linear excursion: ±9 mm
  - cabinet displacement: 1.04 L
  - example sealed volume: 16 L
  - example vented volume: 22 L
  - mounting cutout shown near 194 mm
  - seven-hole mounting pattern on a 210 mm pitch diameter
- **Result:** Woofer dimensions and bolt geometry were incorporated into the parametric enclosure.
- **Open issue:** Verify the physical driver before the full print.

## WH-007 — Midrange selected

- **Date:** Before formal documentation
- **Status:** Completed
- **Component:** Scan-Speak Illuminator 12MU/4731T00
- **Nominal impedance:** 4 ohms
- **Repository references:**
  - `12mu-4731t00.pdf`
  - `12MU-4731T00.STEP`
- **Important manufacturer data recorded:**
  - resonance frequency: 64 Hz
  - sensitivity: 90 dB at 2.83 V / 1 m
  - operating range: 100–10000 Hz
  - linear excursion: ±3.5 mm
  - cabinet displacement: 0.14 L
  - example sealed volume: 0.9 L
  - example vented volume: 1.5 L
  - frame diameter shown near 120 mm
  - mounting cutout shown near 101 mm
- **Result:** Midrange dimensions and bolt geometry were incorporated into the parametric enclosure.
- **Open issue:** Verify the physical driver before the full print.

## WH-008 — Tweeter candidate selected and reference assets added

- **Date:** Before 2026-07-18
- **Status:** Selected for current design development; purchase status not recorded
- **Component:** Scan-Speak Illuminator D3004/662000
- **Nominal impedance:** 4 ohms
- **Repository references:**
  - `d3004-662000.pdf`
  - `D3004_662000.STEP`
- **Important manufacturer data recorded:**
  - resonance frequency: 500 Hz
  - sensitivity: 91.5 dB at 2.83 V / 1 m
  - operating range: 2500–30000 Hz
  - faceplate diameter: approximately 104 mm
  - mounting pitch diameter: approximately 92 mm
  - six 4.2 mm mounting holes
  - manufacturer example crossover guidance: second-order high-pass Butterworth at 2.5 kHz
- **Result:** A matching-quality tweeter with supplied CAD geometry is available for packaging and crossover work.
- **Open issue:** The tweeter has not yet been added to the enclosure model, and its final location has not been selected.

## WH-009 — Driver CAD models collected

- **Date:** Before 2026-07-18
- **Status:** Completed
- **Work:** Added manufacturer STEP models for all three intended drivers.
- **Artifacts:**
  - `12MU-4731T00.STEP`
  - `22W-4851T00.STEP`
  - `D3004_662000.STEP`
- **Result:** Accurate reference solids are available for interference checks, baffle design, driver depth checks, and assembly renders.
- **Caution:** The Lua model currently uses manually encoded dimensions and does not directly consume the STEP solids.

---

# 7. CodeCAD Project and Parametric Modeling

## WH-010 — CodeCAD project initialized

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Created a CodeCAD project using millimeters and a single Lua part source.
- **Artifacts:**
  - `project.json`
  - `parts/part.lua`
- **Result:** The enclosure can be regenerated and exported through the CodeCAD command-line workflow.
- **Current commands documented:**
  - `ccad live`
  - `ccad build`
  - `ccad doctor`
- **Housekeeping issue:** `project.json` still uses the generic project name `My CodeCAD Project`.

## WH-011 — Main cabinet envelope parameterized

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Created parameters for:
  - width
  - length
  - wall thickness
  - height
  - divider position and thickness
- **Result:** The cabinet envelope can be adjusted without rewriting the construction logic.
- **Design constraint:** The 410 mm length was selected to keep the one-piece model within the stated printer build volume.

## WH-012 — Hollow sealed cabinet shell created

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Constructed a chamfered outer body and subtracted an internal cavity.
- **Result:** The current model is a one-piece hollow enclosure with nominal 8 mm walls and a 3 mm exterior chamfer.
- **Limitation:** There is no removable access panel.

## WH-013 — Two sealed chambers created

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added a full-depth divider to isolate the woofer and midrange.
- **Result:** Woofer back pressure is prevented from directly modulating the midrange cone.
- **Current divider:** Starts at Y = 270 mm with 8 mm thickness.
- **Open issue:** The resulting chamber volumes have not been acoustically validated.

## WH-014 — Woofer mounting geometry added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added:
  - 194.1 mm cutout
  - 222 mm frame allowance
  - seven-hole pattern
  - 105 mm bolt radius
  - 5.2 mm mounting holes
  - raised baffle
  - rear cutout flare
  - position parameters
- **Result:** The woofer opening and mounting pattern move together when the driver position changes.
- **Open issue:** Bolt type and threaded interface are undecided.

## WH-015 — Midrange mounting geometry added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added:
  - 101 mm cutout
  - 120 mm frame allowance
  - six-hole pattern
  - approximately 55.8 mm bolt radius
  - 4.5 mm mounting holes
  - raised baffle
  - rear cutout flare
  - position parameters
- **Result:** The midrange opening and mounting pattern move together when the driver position changes.
- **Open issue:** Bolt type and threaded interface are undecided.

## WH-016 — Raised baffles and trim rings added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added 12 mm raised circular baffles and shallow cosmetic trim rings around both driver positions.
- **Result:** Driver mounting surfaces are locally thickened, and the enclosure has a more finished appearance.
- **Open issue:** The acoustic effect of the raised baffles and nearby geometry has not been measured.

## WH-017 — Rear cutout flares added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added conservative rear-side cutout relief behind both cone drivers.
- **Result:** Rear cone airflow is less restricted while mounting-hole material is preserved.
- **Open issue:** Verify clearance with physical driver baskets and terminals.

## WH-018 — Woofer window brace added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added a full-height internal brace near Y = 245 mm with a rounded pill-shaped opening.
- **Result:** The brace couples the long cabinet panels while preserving an acoustically continuous woofer chamber.
- **Open issue:** The brace displacement has not yet been subtracted from the woofer net volume.

## WH-019 — Wire pass-throughs added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added one 12.5 mm side-wall pass-through for each sealed chamber.
- **Result:** Each chamber has a planned cable entry sized for a PG7 cable gland.
- **Open issue:** The final external wiring and terminal arrangement may change now that binding posts and a passive crossover are planned.

## WH-020 — PG7 cable-gland reference model added

- **Date:** Before 2026-07-18
- **Status:** Completed
- **Artifact:** `PG7_CABLE_GLAND.STEP`
- **Result:** Cable-gland packaging can be checked in assembly CAD.
- **Repository result:** The README records an assembly render with both drivers and PG7 cable glands installed.
- **Open issue:** The cable gland has not been integrated as a parametric solid in `parts/part.lua`.

---

# 8. Structural, Isolation, and Cosmetic Development

## WH-021 — Isolation feet modeled

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added four cylindrical feet with:
  - 38.1 mm diameter
  - 19.05 mm projection below the cabinet body
  - flared collars
  - Sorbothane recesses
- **Result:** The enclosure has a defined interface for vibration-isolation pads.

## WH-022 — Sorbothane pad pockets modeled

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added recesses for 1.0625 inch diameter × 0.25 inch thick Sorbothane discs.
- **Result:** Pads can sit flush with the foot contact surfaces.
- **Open issue:** Final enclosure mass and pad compression must be known before confirming durometer and load suitability.

## WH-023 — Bottom X bracing added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added two low-profile diagonal beams connecting the foot regions under the broad bottom panel.
- **Result:** The design intends to stiffen the bottom without extending below the isolation contact plane.
- **Open issue:** Confirm the braces do not create fit or printing problems.

## WH-024 — Exterior side and end ribs added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added low-relief ribs to the long side walls and both end panels.
- **Result:** The enclosure gains visual structure and some additional panel stiffness.
- **Open issue:** Side ribs will need redesign if side walls become removable panels.

## WH-025 — Corner bumpers added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added rounded vertical rails at the four enclosure corners.
- **Result:** Corners are visually tied to the exterior ribs and receive limited impact protection.

## WH-026 — Recessed badge and monogram added

- **Date:** Before 2026-07-15
- **Status:** Completed
- **Work:** Added a shallow rounded badge panel and engraved `NH` monogram.
- **Result:** The prototype has a custom visual identity.
- **Priority note:** Cosmetic features may be simplified if they interfere with service access, print reliability, fit, or acoustic requirements.

---

# 9. Generated Artifacts and Repository Documentation

## WH-027 — STEP and STL exports generated

- **Date:** 2026-07-15, based on the generated STEP metadata
- **Status:** Completed
- **Artifacts in repository:**
  - `generated/part.step` (solid exchange model)
  - `generated/part.stl` (printable mesh)
- **Result:** The CodeCAD model successfully generated both a solid exchange model and a printable mesh.
- **Note:** Dimensions are derived from the CodeCAD parametric output and require verification in the slicer and on the physical printer before committing to the full enclosure print.

## WH-028 — Assembly and cabinet renders created

- **Date:** Before 2026-07-18
- **Status:** Completed
- **Artifacts in repository:**
  - `assets/images/cabinet_render.png` (single cabinet view)
  - `assets/images/perspective_render_with_speakers.png` (two-driver assembly)
  - `assets/images/perspective_render_with_speakers_2.png` (alternative perspective)
- **Result:** The repository contains visual references for the cabinet and a two-driver assembly with cable glands.
- **Note:** The renders show the two-driver mechanical baseline; they do not yet include the tweeter or passive midrange/tweeter crossover configuration. README.md description remains as originally written and should be updated to reflect the final V1 system architecture.

## WH-029 — Repository README written

- **Date:** Before 2026-07-18
- **Status:** Completed
- **Artifact:** `README.md`
- **Result:** The repository now documents:
  - the enclosure purpose
  - selected woofer and midrange
  - current dimensions
  - current structural features
  - repository layout
  - CodeCAD build commands
  - parameter groups
  - initial printing and assembly guidance
- **Limitation:** The README still describes the enclosure as a two-driver prototype and does not reflect the selected tweeter or hybrid passive midrange/tweeter architecture.

## WH-030 — Initial design plan written

- **Date:** Before 2026-07-18
- **Status:** Completed
- **Artifact:** `PLAN.md`
- **Current near-term items recorded:**
  - make the side panels removable and screw-mounted
  - add Keystone binding posts
  - choose driver fasteners
  - choose side-panel fasteners and possible threaded inserts
  - add gasket grooves at joined faces
- **Future ideas recorded:**
  - add a tweeter and indoor adaptability
  - conform the enclosure more closely to the car interior
  - investigate a vented alignment
  - add physical remote controls for amplifier functions
- **Result:** The repository contains a concise pre-documentation task list.
- **Note:** Some “future” ideas, especially the tweeter, have since moved into the current system architecture.

## WH-031 — Formal project documentation started

- **Date:** 2026-07-18
- **Status:** Completed
- **Artifacts:**
  - `PROJECT.md`
  - `REQUIREMENTS.md`
  - `WORK_HISTORY.md`
- **Result:** The project now has separate documents for:
  - broad direction
  - detailed constraints
  - chronological engineering history
- **Next documentation task:** Audit `PROJECT.md` and `REQUIREMENTS.md` against the full repository context and correct any inconsistencies.

---

# 10. Hardware and Mechanical Integration Planning

## WH-032 — Keystone binding-post assembly selected as a reference

- **Date:** Before 2026-07-18
- **Status:** Reference component obtained; not integrated
- **Component:** Keystone Electronics 4109 dual binding-post assembly
- **Artifact:** `BINDING_POST_4109.STEP`
- **Result:** Accurate CAD geometry is available for an external speaker-level terminal interface.
- **Open issues:**
  - choose panel location
  - determine whether one or two dual assemblies are needed
  - add mounting geometry
  - provide internal wire clearance
  - seal the panel penetration
  - protect the posts from passenger contact

## WH-033 — Driver fastener decision identified

- **Date:** Before 2026-07-18
- **Status:** Open
- **Work:** Recognized that the driver mounting screws and printed-plastic interface must be selected before finalizing the baffles.
- **Candidate methods:**
  - heat-set threaded inserts
  - captive nuts
  - through-bolts where accessible
- **Result:** No fastener has been selected or tested.
- **Required next evidence:** Test-coupon pull-out and torque testing in the selected print material.

## WH-034 — Removable side-panel concept identified

- **Date:** Before 2026-07-18
- **Status:** Planned, not implemented
- **Work:** Proposed converting side walls into screw-mounted service panels.
- **Reason:**
  - access drivers and wiring
  - install and revise crossover components
  - install binding posts
  - inspect seals
  - support future electronics
- **Open issues:**
  - which side or sides should open
  - panel thickness
  - screw count and spacing
  - insert type
  - alignment lip
  - gasket geometry
  - effect on existing ribs and corner bumpers

## WH-035 — Gasketed joints identified as necessary

- **Date:** Before 2026-07-18
- **Status:** Planned, not implemented
- **Work:** Recognized that removable faces require gasket grooves or sealing lands.
- **Result:** No gasket profile or material has been selected.
- **Design requirement:** Removable panels must maintain chamber isolation and avoid buzzes under pressure and vehicle vibration.

---

# 11. Acoustic Architecture Development

## WH-036 — Sealed alignment selected for the first prototype

- **Date:** Before 2026-07-18
- **Status:** Completed decision
- **Work:** Chose a sealed two-chamber enclosure for the first prototype.
- **Result:** The current CAD has no port or passive radiator.
- **Reason:** Sealed construction is simpler to package, less sensitive to port geometry, and appropriate for a first measurement-driven prototype.
- **Future note:** A ported alignment was recorded as an idea but has not been analyzed or approved.

## WH-037 — Passive crossover theory investigated

- **Date:** Before 2026-07-18
- **Status:** Completed preliminary study
- **Work:** Investigated:
  - first-order filters
  - Butterworth filters
  - Linkwitz–Riley filters
  - capacitor and inductor behavior
  - nominal-impedance crossover calculators
- **Result:** Established that:
  - the tweeter requires passive low-frequency protection
  - the midrange requires upper-band attenuation
  - textbook networks based only on 4-ohm labels do not guarantee the intended acoustic response
  - final crossover values should come from measurements in the actual enclosure
- **No hardware result:** No crossover has been built.

## WH-038 — 2.5 kHz midrange/tweeter region selected as a starting point

- **Date:** Before 2026-07-18
- **Status:** Provisional
- **Work:** Evaluated 2.5 kHz as the initial midrange/tweeter crossover region.
- **Result:** The value is consistent with the D3004/662000 manufacturer's example guidance and the usable operating ranges of the selected drivers.
- **Caution:** This is not a final component calculation or guaranteed acoustic target.

## WH-039 — Measurement-first crossover workflow selected

- **Date:** Before 2026-07-18
- **Status:** Completed decision
- **Work:** Clarified that drivers can be measured one at a time and that a finished passive crossover is not required before individual driver measurements.
- **Result:** The intended workflow is:
  1. finish and assemble the enclosure
  2. connect and measure one driver at a time using safe filtering
  3. measure impedance
  4. design the passive network from measured data
  5. build and revise the network
  6. complete in-car DSP tuning
- **Tools already available:** A suitable acoustic measurement microphone is owned.
- **Tools/workflow still unresolved:** Impedance measurement hardware and exact measurement procedure.

---

# 12. Current Repository Asset Inventory

## Documentation and project configuration

- `README.md` — current two-driver repository overview
- `PLAN.md` — short next-step and future-idea list
- `project.json` — CodeCAD project definition
- `PROJECT.md` — high-level project document
- `REQUIREMENTS.md` — detailed project requirements
- `WORK_HISTORY.md` — this file

## Parametric and generated enclosure files

- `parts/part.lua` — current authoritative CodeCAD source
- `generated/part.step` — generated solid
- `generated/part.stl` — generated print mesh

## Driver datasheets

- `12mu-4731t00.pdf`
- `22w-4851t00.pdf`
- `d3004-662000.pdf`

## Driver and hardware CAD references

- `12MU-4731T00.STEP`
- `22W-4851T00.STEP`
- `D3004_662000.STEP`
- `BINDING_POST_4109.STEP`
- `PG7_CABLE_GLAND.STEP`

## Complete Repository Inventory

**CAD and manufacturing:**

- `parts/part.lua` — CodeCAD parametric enclosure generator (Lua)
- `generated/part.step` — Current solid exchange model (2026-07-15)
- `generated/part.stl` — Current printable mesh (2026-07-15)
- `generated/part.step` and `part.stl` are derived artifacts; regenerated by `parts/part.lua`

**Component reference models (in components/ or referenced by CAD):**

- `22W-4851T00.STEP` — Scan-Speak woofer (Revelator 8")
- `12MU-4731T00.STEP` — Scan-Speak midrange (Illuminator 4.5")
- `D3004_662000.STEP` — Scan-Speak tweeter (Illuminator dome, provisional)
- `BINDING_POST_4109.STEP` — Keystone binding-post assembly (provisional)
- `PG7_CABLE_GLAND.STEP` — Cable gland reference

**Renders and documentation:**

- `assets/images/cabinet_render.png` — Static cabinet visualization
- `assets/images/perspective_render_with_speakers.png` — Two-driver assembly render
- `assets/images/perspective_render_with_speakers_2.png` — Alternative perspective
- `README.md` — Repository overview (describes two-driver baseline; should be updated)
- `PLAN.md` — Early design planning notes

**Scripts:**

- `scripts/angle_calculator.js` — Utility for driver angle calculations (currently unused)

**Project documentation (also an Obsidian vault):**

- `docs/PROJECT.md` — High-level project vision and architecture
- `docs/REQUIREMENTS.md` — Detailed constraints and specifications
- `docs/WORK_HISTORY.md` — This file

**Git history:**

- Full commit history available via `git log`; recent commits documented in the entries above

---

# 13. Decisions Currently in Force

The following decisions should be treated as current unless explicitly superseded:

1. The enclosure is located behind the center console on the rear floor.
2. The enclosure is a centered mono loudspeaker.
3. The system uses one woofer, one midrange, and one tweeter.
4. The selected woofer is the Scan-Speak 22W/4851T00.
5. The selected midrange is the Scan-Speak 12MU/4731T00.
6. The working tweeter selection is the Scan-Speak D3004/662000.
7. The first system uses two independent 65 W / 4-ohm amplifier outputs.
8. The woofer uses one dedicated amplifier channel.
9. The midrange and tweeter share the second channel through a passive crossover.
10. The woofer/midrange transition is handled in DSP.
11. The first enclosure uses sealed chambers.
12. The first full print is a functional proof-of-concept rather than a permanent vehicle installation.
13. The enclosure remains parameterized and version-controlled.
14. Final crossover and DSP choices will be based on measurements.

---

# 14. Ideas Considered but Not Yet Approved

These concepts remain exploratory and shall not be treated as current requirements:

- ported or bass-reflex enclosure
- passive radiator
- exact OEM-shaped floor contour
- internal amplifier
- active/passive mode switch
- indoor self-powered mode
- remote physical DSP controls
- bass-boost button
- Bluetooth or network audio
- permanent vehicle mounting modification
- final cosmetic surface finish
- fully printed grille design
- stereo pair or dual-enclosure architecture

---

# 15. Near-Term Work Queue

Only the first item is the immediate goal. Later items may be reordered after each result.

## 1. Immediate — Removable side-access panel

- Select one side for the first access-panel implementation.
- Define the panel perimeter.
- Add a locating lip.
- Add gasket geometry.
- Add provisional insert bosses and screw holes.
- Remove or modify conflicting exterior ribs.
- Verify chamber separation.
- Create an insert/gasket test coupon.

## 2. Verify physical driver geometry

When the drivers arrive:

- measure frame diameter
- measure cutout requirement
- measure mounting-hole diameter
- verify bolt-circle locations
- measure rear depth
- inspect terminals and wire clearance
- compare all results against Lua parameters and STEP models

Do not commit to the full print until these checks are complete.

## 3. Add tweeter to the enclosure

- Import or reference the D3004 STEP model.
- evaluate available baffle positions
- minimize midrange/tweeter center spacing
- check passenger exposure
- check grille clearance
- verify internal chamber and fastener clearance
- add mounting and cutout geometry

## 4. Add binding-post interface

- Decide whether to use separate LF and MF/HF terminal pairs.
- place the Keystone 4109 reference model
- add mounting cutouts and fastener features
- preserve sealing
- protect rear wiring
- verify passenger clearance

## 5. Finalize driver and panel fasteners

- choose insert and screw sizes
- print test coupons
- test installation method
- test pull-out and strip torque
- record required pilot geometry

## 6. Calculate net chamber volumes

- calculate from final CAD
- subtract driver displacement
- subtract brace and hardware displacement
- compare with manufacturer guidance
- determine whether the midrange needs a much smaller internal sub-enclosure

## 7. Model the woofer sealed alignment

- use verified driver parameters
- simulate the actual net volume
- evaluate expected resonance, Q, excursion, and low-frequency response
- decide whether the current volume is acceptable for V1

## 8. Prepare print strategy

- select prototype material
- define nozzle and layer height
- define perimeter count
- define infill approach
- determine orientation and supports
- estimate material and print time
- decide whether a one-piece print remains practical

## 9. Print fit and hardware coupons

Before the complete cabinet:

- driver-hole coupon
- insert coupon
- access-panel gasket coupon
- binding-post panel coupon
- PG7 gland coupon
- Sorbothane foot pocket coupon

## 10. Print and mechanically assemble prototype

- inspect print
- install inserts
- install panels and gaskets
- install drivers
- install cable hardware
- verify seals
- weigh completed enclosure
- test fit in vehicle
- do not begin road use without a positive restraint

## 11. Begin individual-driver measurements

- create conservative DSP measurement presets
- connect one driver at a time
- protect the tweeter with a suitable series capacitor and DSP high-pass
- perform low-level sweeps
- save raw files and setup notes

## 12. Design the passive midrange/tweeter crossover

- measure driver impedance
- import response and impedance into crossover software
- simulate candidate networks
- build a serviceable prototype network
- measure normal and reversed polarity
- revise component values

## 13. Complete full-system DSP tuning

- integrate woofer and upper section
- tune crossover
- adjust delay
- level-match
- equalize
- configure limiting
- evaluate multiple rear-seat positions

---

# 16. Next-Entry Template

Copy this template for future work:

```markdown
## WH-### — Short action title

- **Date:** YYYY-MM-DD
- **Status:** Completed | Partial | Failed | Blocked | Decision
- **Goal:** What this work was intended to accomplish.
- **Work performed:**
  - ...
- **Artifacts changed or created:**
  - `path/to/file`
- **Configuration or materials:**
  - ...
- **Result:**
  - ...
- **Measurements:**
  - ...
- **Problems found:**
  - ...
- **Decision:**
  - ...
- **Next action:**
  - ...
```

## WH-033 — Documentation audit and grounding

- **Date:** 2026-07-18
- **Status:** Completed
- **Task:** Audit PROJECT.md, REQUIREMENTS.md, and WORK_HISTORY.md against the actual repository state and ChatGPT session notes. Update documentation to reflect:
  - Current tweeter selection (D3004/662000, physical verification pending)
  - Distinction between CodeCAD 2-driver baseline and V1 intended 3-driver system
  - Nominal enclosure dimensions vs. STL-derived envelope dimensions
  - Printer build-volume margin warning (415 mm vs. 420 mm Y-axis)
  - Shift from "entirely one-piece" to "primarily one-piece with removable gasketed side-access panel"
  - Preliminary chamber volume analysis (woofer ~12.04 L, midrange ~5.70 L) with notes on pending analysis
  - Keystone 4109 binding-post assembly as provisional selection
  - Removal of "uploaded context" language; grounding in actual repository artifacts
  - Use of Git history for commit dates
- **Changes made:**
  - Updated PROJECT.md: tweeter line, enclosure concept section, current project state, immediate milestone
  - Updated REQUIREMENTS.md: SYS-005 (tweeter), MEC-BASE-001 and -002 (dimensions and printer margin), added MEC-V1-PANEL (removable panel), added MEC-BASE-007 (preliminary chamber volumes), added ELEC-009b (Keystone 4109)
  - Updated WORK_HISTORY.md: removed "uploaded context" language from WH-027 and WH-028, replaced section 12 with complete repository inventory, updated next action language
- **Result:** Documentation is now grounded in repository reality and reflects the current system architecture (3-driver with removable panel path)
- **Next:**
  - Design and implement removable, gasketed side-access panel in CAD
  - Perform detailed chamber volume analysis (especially midrange)

## WH-034 — Define Codex and Claude Code responsibilities

- **Date:** 2026-07-18
- **Status:** Completed
- **Goal:** Document the user's preferred division of labor between ChatGPT Codex and Claude Code.
- **Work performed:**
  - Updated `AGENTS.md` to make Codex the default design and engineering advisor.
  - Updated `.Claude/CLAUDE.md` to make Claude Code the default implementation and operations tool.
  - Defined an explicit handoff pattern: Codex supplies goals, constraints, sequence, and acceptance checks; Claude Code implements and reports artifacts, commands, tests, and unresolved issues.
- **Decision:**
  - Codex should normally provide design guidance, best practices, review, and next-step advice.
  - Claude Code should normally write code, run shell commands and tests, modify implementation files, and interface with SolidWorks or Fusion 360.
  - Either tool may work outside its default role when the user explicitly requests it.
- **Tests and measurements:** Documentation-only change; no engineering tests or measurements were required.
- **Current state:** The tool responsibilities are now explicit in both project instruction files. No enclosure design, requirements, or immediate engineering milestone changed.
- **Next action:** Continue with the existing immediate goal: design and validate one removable, gasketed side-access panel.

---

## WH-040 — Fabrication hardware arrived and execution sequence reset

- **Date:** 2026-07-18
- **Status:** Reported; physical inventory pending
- **Goal:** Convert the arrival of fabrication equipment and components into a safe, low-waste execution plan.
- **Newly reported on hand:**
  - 3D printer
  - speakers
  - filament
  - tools
  - additional project-related supplies
- **Confirmed facts:** The user reports that these categories have arrived.
- **Not yet verified:** Exact printer model and configuration; individual driver model numbers and condition; filament polymers and quantities; fastener, insert, gasket, wiring, and measurement-tool inventory.
- **Decision:** Printer commissioning, inventory, and physical dimensional verification now precede additional CAD commitment. The removable side-access panel remains the next CAD feature, but it is no longer the immediate physical task.
- **Plan of attack:**
  1. Inventory and inspect all delivered items; photograph labels or record exact part numbers where useful.
  2. Assemble, update only if required by the manufacturer, calibrate, and safely test the printer.
  3. Print a small calibration object; record filament, nozzle, slicer profile, dimensional result, adhesion, and visible defects.
  4. Measure the physical woofer, midrange, and tweeter mounting geometry and compare it with CAD and datasheets.
  5. Reconfirm the vehicle installation envelope, seat travel, HVAC clearance, cable route, and candidate restraint hard points using simple templates before a large print.
  6. Resolve the provisional material choice and verify the 415 mm model fits the actual usable slicer/bed envelope.
  7. Implement the single removable, gasketed side panel in CAD.
  8. Print focused coupons for driver cutouts, inserts/fasteners, gasket compression, binding posts, PG7 glands, and the Sorbothane pocket.
  9. Revise CAD from coupon results, calculate net chamber volumes, model the woofer alignment, and freeze a V1 print candidate.
  10. Slice and review the full enclosure for orientation, supports, time, material use, collision/clearance, and failure risk before starting it.
- **Safety gates:**
  - Do not power loose drivers at meaningful level without suitable filtering and secure support.
  - Do not use standard PLA as the final road-use structural enclosure.
  - Do not begin occupied-road use until a positive mechanical restraint is designed and validated.
- **Current state:** The project has entered fabrication readiness; no physical inspection, printer calibration, dimensional verification, or test print has yet been recorded.
- **Immediate next action:** Complete the equipment inventory and one documented printer calibration print. Stop before printing enclosure-scale geometry.
- **Open questions:** Exact delivered models/materials, whether the tweeter is physically present, which measurement and impedance tools are available, and which filament is intended for the road-use enclosure.

---

# 17. Immediate Next Action

Inventory the delivered equipment and complete **one documented printer calibration print** using a low-cost filament appropriate for commissioning.

Record the printer model, nozzle, build surface, slicer/profile, filament type, calibration result, and measured X/Y/Z dimensions. Stop before printing enclosure-scale geometry. The next gate is physical driver and vehicle-envelope verification; the removable service panel remains the next focused CAD revision after those checks.
