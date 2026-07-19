---
document: REQUIREMENTS
project: Tesla Rear-Cabin Speaker
status: Draft
version: 0.1
last_updated: 2026-07-18
---

# Tesla Rear-Cabin Speaker — Requirements

## 1. Purpose

This document defines the current requirements for the Tesla rear-cabin speaker project.

It is the detailed source of truth for the constraints the design must satisfy. It should be read together with:

- `PROJECT.md` for the high-level project vision and architecture
- `WORK_HISTORY.md` for completed work, test results, decisions, and the immediate next task

This file should describe **what the system must do or satisfy**, not provide a chronological record of work.

Requirements are expected to evolve as vehicle measurements, driver data, enclosure simulations, acoustic measurements, and prototype results become available. Changes should be made deliberately and recorded in Git.

---

## 2. Requirement Conventions

### 2.1 Priority

- **MUST** — Required for the relevant prototype or release to be accepted
- **SHOULD** — Strongly preferred unless there is a documented reason not to comply
- **MAY** — Optional or desirable
- **DEFERRED** — Intentionally excluded from the current prototype

### 2.2 Status

- **Accepted** — The requirement is currently approved
- **Provisional** — The requirement is being used, but its value or wording may change
- **TBD** — A requirement exists, but a value or decision is not yet established
- **Deferred** — Not required for the first complete prototype
- **Superseded** — Replaced by a later requirement or decision

### 2.3 Verification Methods

- **Inspection** — Visual or physical inspection
- **Measurement** — Direct dimensional, electrical, thermal, or acoustic measurement
- **Test** — Functional operation under defined conditions
- **Analysis** — CAD, simulation, calculation, or data review
- **Demonstration** — Successful use in the intended environment
- **Document review** — Confirmation against project documentation or manufacturer data

### 2.4 Requirement Management Rules

1. Each requirement should have a stable identifier.
2. Existing identifiers should not be reused for unrelated requirements.
3. Changed values should be committed to Git with a brief reason.
4. A requirement should not be marked verified without evidence.
5. Unknown values should remain `TBD`; AI tools should not invent values to make the document appear complete.
6. Measured data should override assumptions and generic calculator outputs.
7. When requirements conflict, safety and driver protection take priority, followed by vehicle fit, acoustic performance, serviceability, cost, and appearance.

---

## 3. Scope and System Boundary

### SYS-001 — Intended installation

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first complete prototype shall operate as a single mono loudspeaker located on the rear floor behind the center console of a Tesla Model 3.
- **Verification:** Demonstration and inspection

### SYS-002 — Driver complement

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The system shall use one woofer, one dedicated midrange, and one tweeter.
- **Verification:** Inspection

### SYS-003 — Selected woofer

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first prototype shall use the Scan-Speak Revelator 22W/4851T00 4-ohm woofer unless a documented compatibility or packaging problem requires replacement.
- **Verification:** Inspection and document review

### SYS-004 — Selected midrange

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first prototype shall use the Scan-Speak Illuminator 12MU/4731T00 4-ohm midrange unless a documented compatibility or packaging problem requires replacement.
- **Verification:** Inspection and document review

### SYS-005 — Tweeter selection

- **Priority:** MUST
- **Status:** Provisional (current working selection)
- **Current selection:** Scan-Speak Illuminator D3004/662000, 4 ohm
- **Provisional data:**
  - Rated impedance: 4 ohm nominal
  - Manufacturer sensitivity: ~85 dB @ 1 m, 1 W (per Scan-Speak datasheet)
  - Manufacturer crossover recommendation: ~2.5 kHz with appropriate passive network
  - Baffle mount: 76.2 mm diameter frame hole, 50 mm sound aperture
  - Rear chamber requirement: Nominally sealed; manufacturer provides free-air specifications
- **Requirement:** The Scan-Speak D3004/662000 shall be used unless physical measurement, fit verification, or acoustic testing demonstrates an incompatibility or superior alternative.
- **Verification:** Physical measurement against CAD model, fit test before full enclosure print, acoustic measurement in final enclosure, crossover development
- **Note:** Physical tweeter unit verification is pending.

### SYS-006 — First-release architecture

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first complete prototype shall use two powered amplifier outputs with a hybrid active/passive architecture:
  - one channel dedicated to the woofer
  - one channel feeding a passive midrange/tweeter crossover
- **Verification:** Inspection and test

### SYS-007 — Mono source routing

- **Priority:** MUST
- **Status:** Provisional
- **Requirement:** Both amplifier outputs shall receive the same intended mono program mix unless measurements demonstrate that a different input mix produces a better result.
- **Verification:** DSP configuration review and test

### SYS-008 — No output-channel combining

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The two amplifier outputs shall remain electrically isolated and shall never be tied together at their positive or negative terminals.
- **Verification:** Inspection and continuity test

### SYS-009 — Prototype emphasis

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first enclosure is a proof-of-concept and shall prioritize fit, safe operation, measurement access, and design learning over final cosmetic quality.
- **Verification:** Document review

### SYS-010 — Non-goals for V1

- **Priority:** DEFERRED
- **Status:** Accepted
- **Requirement:** The following are not required for the first complete prototype:
  - stereo reproduction from the custom enclosure
  - an internal power amplifier
  - wireless streaming
  - battery operation
  - final furniture-grade appearance
  - final indoor-speaker conversion
- **Verification:** Document review

---

## 4. Vehicle Packaging and Installation

### VEH-001 — Installation location

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The enclosure shall fit on the rear center floor behind the center console.
- **Verification:** Demonstration and measurement

### VEH-002 — Available-space utilization

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** The enclosure should use as much acoustically useful volume as practical within the verified installation envelope.
- **Verification:** CAD analysis and vehicle fit test

### VEH-003 — Seat movement

- **Priority:** MUST
- **Status:** Provisional
- **Requirement:** The enclosure shall not prevent required front-seat movement or contact moving seat structures throughout the agreed operating range.
- **Verification:** Vehicle fit test
- **Open item:** Define the required seat-position range.

### VEH-004 — Rear passenger interference

- **Priority:** MUST
- **Status:** Provisional
- **Requirement:** The enclosure shall not create unacceptable interference with normal rear-passenger leg and foot placement.
- **Verification:** Demonstration
- **Open item:** Define whether the center rear seating position must remain usable.

### VEH-005 — HVAC clearance

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The enclosure shall not block rear HVAC outlets or prevent normal adjustment of the rear vent controls.
- **Verification:** Inspection and demonstration

### VEH-006 — Vehicle controls and service points

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The installation shall not obstruct required seat latches, trim removal points, service access, emergency equipment, or vehicle controls.
- **Verification:** Inspection

### VEH-007 — No permanent visible modification

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first prototype shall not require drilling, cutting, or permanently altering visible vehicle trim, carpet, seats, or the center console.
- **Verification:** Inspection

### VEH-008 — Reversible installation

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The enclosure and wiring shall be removable without irreversible modification to the vehicle.
- **Verification:** Demonstration

### VEH-009 — Primary restraint

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Before normal occupied-road use, the enclosure shall have a positive mechanical restraint that prevents it from becoming a projectile during emergency braking or a collision.
- **Verification:** Inspection, analysis, and physical load test
- **Constraint:** Sorbothane pads, friction, enclosure weight, hook-and-loop material, or Dual Lock alone shall not be considered the primary crash restraint.

### VEH-010 — Existing hard points

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** The preferred retention method should use existing vehicle structural or seat-mounting hard points without compromising their original function.
- **Verification:** Inspection and analysis

### VEH-011 — Restraint load case

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** A documented multidirectional retention load target shall be established before the restraint design is approved.
- **Verification:** Analysis and test

### VEH-012 — Rattle prevention

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Every enclosure-to-vehicle contact surface shall be designed to avoid audible buzzes, squeaks, and rattles during normal driving and speaker operation.
- **Verification:** Road test and acoustic test

### VEH-013 — Floor protection

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Contact surfaces shall not cut, permanently mark, or abrade the vehicle floor covering or all-weather mat during normal use.
- **Verification:** Inspection after use

### VEH-014 — Cable routing

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Speaker wiring shall be routed and retained so that it cannot be pinched by seats, abraded by trim or rails, pulled by passengers, or create a trip hazard.
- **Verification:** Inspection and seat-movement test

---

## 5. Packaging Baseline from Current CAD

The following values describe the current prototype body and are design baselines, not yet final vehicle-envelope requirements.

### MEC-BASE-001 — Current cabinet body

- **Status:** Provisional
- **Nominal body dimensions (CAD model interior reference):**
  - body width: 9.5 in / 241.3 mm
  - body length: 410 mm
  - body height: 220 mm
  - nominal wall thickness: 8 mm
- **Generated STL envelope (preliminary, from CodeCAD Lua output):**
  - bounding X: 246.3 mm (includes wall thickness and trim)
  - bounding Y: 415 mm (length)
  - bounding Z: 253.05 mm (height varies with baffle and foot height)
  - *Note: Calculated from STL export; requires slicer verification for actual print dimensions*
- **Note:** Raised baffles, trim rings, feet, driver protrusion, grilles, fasteners, and wiring may increase the total installed envelope beyond the nominal body dimensions.

### MEC-BASE-002 — Current printer envelope and fit

- **Status:** Under Review
- **Printer build volume:** 420 × 420 × 480 mm
- **Current generated length (Y-axis):** 415 mm
- **Margin analysis:** 5 mm remaining (415 mm model + slicer clearance margin must fit within 420 mm)
- **Requirement:** The enclosure shall fit within the printer build volume with adequate slicer clearance. Actual fit must be verified with the specific slicer profile before printing.
- **Flag:** The 5 mm margin between the current 415 mm generated length and the 420 mm printer dimension is marginal. Slicer settings, nozzle offset, and bed-level variation must be verified before committing to the full print.
- **Verification:** Slicer review with actual equipment, test print verification before full-enclosure commitment
- **Alternative approach:** Removable side-access panels (see MEC-V1-PANEL) provide design flexibility if full one-piece print proves infeasible or undesirable.

### MEC-BASE-003 — Current chamber division

- **Status:** Provisional
- **Current value:**
  - divider position: Y = 270 mm
  - divider thickness: 8 mm
- **Verification:** CAD review

### MEC-BASE-004 — Current baffle geometry

- **Status:** Provisional
- **Current value:**
  - raised baffle thickness: 12 mm
  - baffle margin outside driver frame: 6 mm
  - trim ring height: 2 mm
- **Verification:** CAD review

### MEC-BASE-005 — Current feet

- **Status:** Provisional
- **Current value:**
  - foot diameter: 1.5 in / 38.1 mm
  - foot height below body: 0.75 in / 19.05 mm
  - Sorbothane pad diameter: 1.0625 in / 26.99 mm
  - Sorbothane recess depth: 0.25 in / 6.35 mm
- **Verification:** CAD review and test fit

### MEC-BASE-006 — Current driver cutouts

- **Status:** Provisional
- **Current value:**
  - woofer cutout: 194.1 mm
  - woofer frame allowance: 222 mm
  - midrange cutout: 101 mm
  - midrange frame allowance: 120 mm
- **Requirement:** These values shall be independently verified against the physical drivers and manufacturer drawings before the full enclosure is printed.
- **Verification:** Physical measurement and document review

### MEC-V1-PANEL — Removable service access panel

- **Priority:** MUST (for V1 prototype)
- **Status:** In Design
- **Requirement:** The first complete prototype shall incorporate at least one removable, gasketed access panel to allow future internal modification, tweeter integration, crossover development, and internal inspection without requiring full enclosure re-printing.
- **Panel specifications:**
  - Location: Side-mounted access panel (currently favored approach)
  - Acoustic sealing: Continuous gasket groove (rabbet joint preferred) for consistent seal without over-tightening
  - Fastening: Reusable fasteners (screws with threaded inserts or captive nuts) for multiple open/close cycles
  - Locating features: Lip or rabbet joint to ensure repeatable alignment and seal compression
  - Minimum opening: Sufficient to access crossover components and provide acoustic measurement ports
  - Validation: Acoustic leak test after gasket installation and fastening
- **Verification:** CAD review, gasket material selection, insert/nut geometry validation, acoustic leak test

---

## 6. Mechanical Enclosure Requirements

### MEC-001 — Sealed enclosure

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The first prototype shall use sealed acoustic chambers rather than a ported or passive-radiator alignment.
- **Verification:** Inspection and leak test

### MEC-002 — Separate woofer and midrange chambers

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The woofer and midrange shall occupy separate sealed air volumes so woofer back pressure cannot directly modulate the midrange cone.
- **Verification:** CAD review and inspection

### MEC-BASE-007 — Preliminary gross chamber volumes (derived from current CAD)

- **Status:** Provisional Analysis
- **Preliminary gross values (from CodeCAD 2-driver baseline):**
  - Woofer chamber gross: ~12.04 liters
  - Midrange chamber gross: ~5.70 liters
  - *Note: These are derived STL volume calculations and do not yet subtract driver displacement, internal bracing, divider thickness, or crossover component volume.*
- **Analysis pending:**
  - Detailed subtraction of driver, brace, and crossover displacement
  - Midrange chamber sufficiency: The Scan-Speak 12MU/4731T00 manufacturer example sealed volume is ~0.9 L; the current ~5.70 L is substantially larger and requires acoustic analysis to confirm it does not introduce undesirable low-frequency resonance or impedance behavior
  - Woofer alignment: Preliminary modeling with Thiele-Small parameters from the 22W/4851T00 datasheet
- **Requirement:** Net chamber volumes shall be calculated and verified against driver requirements and acoustic targets before the divider position is frozen.
- **Verification:** CAD volume calculation, acoustic impedance modeling, measurement validation in final enclosure

### MEC-003 — Tweeter rear volume

- **Priority:** MUST
- **Status:** TBD (pending tweeter physical verification)
- **Requirement:** The tweeter installation shall comply with the selected tweeter's rear-chamber requirements. A self-contained tweeter shall not be exposed to cabinet pressure through an unintended leak.
- **Tweeter rear-chamber note:** The Scan-Speak D3004/662000 is typically specified for sealed (infinite baffle) or free-air operation; rear-chamber pressure effects shall be evaluated during crossover development and acoustic measurement.
- **Verification:** Manufacturer document review, physical measurement in actual baffle, acoustic testing

### MEC-004 — Net chamber volume calculation

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Net woofer and midrange chamber volumes shall be calculated from the final CAD model after subtracting driver, brace, divider, fastener, wiring, and crossover displacement.
- **Verification:** CAD analysis

### MEC-005 — Woofer alignment validation

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The woofer's sealed-box alignment shall be modeled using verified driver parameters and the calculated net volume before the design is frozen.
- **Verification:** Analysis

### MEC-006 — Midrange chamber suitability

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The midrange chamber volume and damping shall be selected to avoid an objectionable low-frequency impedance or acoustic resonance within the intended operating band.
- **Verification:** Analysis and measurement

### MEC-007 — Wall stiffness

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Walls and baffles shall be sufficiently stiff that panel vibration does not create clearly audible coloration, buzzing, or rattling at intended output.
- **Verification:** Inspection, vibration test, and acoustic measurement

### MEC-008 — Bracing

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Large opposing surfaces should be coupled with internal bracing that does not excessively obstruct airflow or consume unnecessary chamber volume.
- **Verification:** CAD review and inspection

### MEC-009 — Brace airflow

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Brace openings shall have smooth transitions and adequate area to avoid audible chuffing or creating an unintended divided acoustic volume.
- **Verification:** CAD review and test

### MEC-010 — Driver mounting rigidity

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Each driver mounting surface shall remain flat and rigid under fastener preload and driver reaction force.
- **Verification:** Inspection and test

### MEC-011 — Driver sealing

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Each driver frame shall seal to the baffle using a suitable compressible gasket.
- **Verification:** Inspection and leak test

### MEC-012 — Chamber penetrations

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Wire pass-throughs, terminals, fasteners, seams, and unused holes entering a sealed chamber shall be airtight after final assembly.
- **Verification:** Inspection and leak test

### MEC-013 — Rear cutout relief

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** The rear of each cone-driver cutout should be relieved where practical to avoid restricting rear cone airflow while preserving adequate mounting material.
- **Verification:** CAD review

### MEC-014 — Driver clearance

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The enclosure shall provide clearance for the complete driver basket, terminals, suspension motion, magnet, mounting hardware, and attached wiring.
- **Verification:** CAD interference analysis and physical fit test

### MEC-015 — Wire clearance

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Internal wiring shall not contact moving driver parts or rest loosely against surfaces where it can buzz.
- **Verification:** Inspection

### MEC-016 — Damping material retention

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Any internal damping material shall be mechanically retained so it cannot contact the rear of a moving cone, block ventilation, or shift during vehicle motion.
- **Verification:** Inspection and road test

### MEC-017 — Sharp edges

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Passenger-accessible edges and corners shall not present a cutting, snagging, or puncture hazard.
- **Verification:** Inspection

### MEC-018 — Grilles

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Drivers exposed to passenger feet or cargo shall be protected by acoustically suitable grilles capable of resisting expected incidental contact.
- **Verification:** Inspection and load test

### MEC-019 — Grille clearance

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Grilles shall maintain adequate clearance from the driver surround and cone at maximum intended excursion.
- **Verification:** CAD analysis and physical test

### MEC-020 — Mass

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The final assembled mass shall be measured and used in the restraint analysis.
- **Verification:** Measurement

---

## 7. Additive Manufacturing Requirements

### MFG-001 — Parametric source

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Major enclosure dimensions, driver locations, wall thicknesses, and mounting geometry shall remain parameterized wherever practical.
- **Verification:** Code and CAD review

### MFG-002 — Source-of-truth geometry

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The project shall identify which model is authoritative when CodeCAD and SolidWorks versions coexist.
- **Verification:** Document review

### MFG-002b — Printer commissioning record

- **Priority:** MUST
- **Status:** TBD (printer delivered; commissioning not yet recorded)
- **Requirement:** Before printing enclosure-scale geometry, the printer shall complete its manufacturer-recommended assembly and calibration process and produce a documented small calibration print.
- **Record:** Printer model, nozzle size, build surface, slicer and profile, filament identity, relevant calibration settings, observed defects, and measured X/Y/Z dimensions.
- **Verification:** Inspection, measurement, and document review

### MFG-002c — Delivered-material identification

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Filament shall be identified by polymer, manufacturer, nominal diameter, and intended role before use. Material of unknown composition shall not be used for the full enclosure or road-use structural parts.
- **Verification:** Label inspection and document review

### MFG-003 — One-piece preference

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** The enclosure should be printable as one structural shell when this improves sealing and rigidity and remains practical within the printer envelope.
- **Verification:** CAD and slicer review

### MFG-004 — Alternative segmentation

- **Priority:** MAY
- **Status:** Accepted
- **Requirement:** The enclosure may be split into multiple printed parts if required for print reliability, serviceability, material selection, or improved geometry, provided the joints can be made rigid and airtight.
- **Verification:** CAD review and leak test

### MFG-005 — Material temperature resistance

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The road-use enclosure material shall be validated against expected parked-vehicle interior temperatures without unacceptable creep, warping, loss of fastener preload, or seal failure.
- **Verification:** Material review and thermal test

### MFG-006 — PLA restriction

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Standard PLA shall not be used for the final road-use structural enclosure.
- **Verification:** Material inspection

### MFG-007 — Fit-prototype material

- **Priority:** MAY
- **Status:** Accepted
- **Requirement:** Lower-cost or lower-temperature material may be used for non-road fit checks, test coupons, templates, or short-duration bench prototypes when clearly labeled.
- **Verification:** Inspection

### MFG-008 — Print-process record

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** The final print settings shall be recorded, including material, nozzle, layer height, wall count, top/bottom layers, infill, orientation, supports, and annealing or post-processing.
- **Verification:** Document review

### MFG-009 — Shell integrity

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The print shall not contain through-gaps, delamination, cracks, or porous regions that compromise structural integrity or acoustic sealing.
- **Verification:** Inspection and leak test

### MFG-010 — Test coupons

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Critical features should be validated with small test prints before committing to the full enclosure, including driver holes, inserts, gaskets, terminal mounts, grille mounts, and Sorbothane recesses.
- **Verification:** Inspection

### MFG-011 — Fastener interfaces

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Frequently removed components should use threaded inserts, captive nuts, through-bolts, or another reusable interface rather than repeatedly cutting threads directly into printed plastic.
- **Verification:** Inspection

### MFG-012 — Insert installation validation

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Heat-set or press-fit insert geometry shall be validated in the selected material with test coupons before use in the full cabinet.
- **Verification:** Pull-out and torque test

### MFG-013 — Print failure containment

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** The model and slicer plan should minimize the probability that a late print failure destroys all major functional features.
- **Verification:** Slicer review

---

## 8. Electrical Interface Requirements

### ELEC-001 — Available outputs

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The system shall operate from two independent amplifier outputs, each nominally capable of 65 W into 4 ohms.
- **Verification:** Amplifier configuration and document review

### ELEC-002 — Woofer channel

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** One amplifier output shall connect only to the woofer path.
- **Verification:** Wiring inspection

### ELEC-003 — Mid/tweeter channel

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** One amplifier output shall feed the passive midrange/tweeter crossover input.
- **Verification:** Wiring inspection

### ELEC-004 — Nominal load compatibility

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Each amplifier output shall see an electrical load that remains within the amplifier's safe operating range over the full audio band.
- **Verification:** Impedance measurement and amplifier document review

### ELEC-005 — Minimum impedance

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The minimum permitted impedance magnitude and phase angle shall be established from amplifier documentation or validated testing before full-power operation.
- **Verification:** Document review and measurement

### ELEC-006 — Polarity labeling

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Every external and internal driver connection shall be clearly labeled for function and polarity.
- **Verification:** Inspection

### ELEC-007 — Serviceable external connection

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The enclosure shall provide a secure and serviceable external connection for each amplifier channel.
- **Verification:** Inspection and connection test

### ELEC-008 — Separate input pairs

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The woofer input and midrange/tweeter input shall use separate isolated positive/negative terminal pairs.
- **Verification:** Continuity test

### ELEC-009 — Terminal short prevention

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Exposed terminals and internal wiring shall be arranged so normal handling cannot short either amplifier output.
- **Verification:** Inspection

### ELEC-009b — External binding-post assembly (provisional)

- **Priority:** SHOULD
- **Status:** Provisional selection (reference component obtained)
- **Current selection:** Keystone Electronics 4109 dual binding-post assembly
- **Provisional data:**
  - Two isolated dual binding-post pairs (4 posts total)
  - Screw terminal type, suitable for 16 AWG or larger wire
  - Panel-mount M4 thread and standoff M3 anchor bolts
  - Rated for speaker-level amplifier output (typical 65 W / 4 ohm = ~5 A sustained)
- **Requirement:** An external amplifier interface shall use a dual binding-post assembly suitable for speaker-level connections. The Keystone 4109 is a provisional selection pending:
  - Final CAD panel location design
  - Verification that the current chassis can accommodate one or two dual assemblies as needed
  - Testing to confirm adequate current capacity and reliable connection under automotive vibration
- **Verification:** CAD fit review, connection reliability testing under vibration, thermal testing under expected current

### ELEC-010 — Wiring current capacity

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Wire gauge, connectors, terminals, crossover traces, and solder joints shall safely carry the expected current with negligible heating and acceptable voltage drop.
- **Verification:** Analysis and thermal test

### ELEC-011 — Strain relief

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** External and internal wires shall have strain relief so pulling on a cable does not load solder joints, driver tabs, or crossover components.
- **Verification:** Inspection and pull test

### ELEC-012 — Automotive vibration resistance

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Electrical connections and components shall remain secure under vehicle vibration and repeated thermal cycling.
- **Verification:** Road test and inspection

### ELEC-013 — Insulation and abrasion

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Conductors shall be insulated from sharp edges, metal vehicle structure, and moving components.
- **Verification:** Inspection

### ELEC-014 — DC resistance record

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** The DC resistance measured at each enclosure input shall be recorded before connection to the vehicle amplifier.
- **Verification:** Multimeter measurement

### ELEC-015 — Continuity preflight

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Before first power-up, continuity shall be verified from each input to its intended driver path, and isolation shall be verified between the two amplifier inputs.
- **Verification:** Multimeter test

---

## 9. DSP and Signal-Routing Requirements

### DSP-001 — Independent output configuration

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The amplifier shall allow independent source mixing, gain, crossover, EQ, delay, and dynamics settings for both outputs used by the enclosure.
- **Verification:** Configuration review and demonstration

### DSP-002 — Woofer low-pass

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The woofer channel shall use a DSP low-pass filter selected from measurement and integration testing.
- **Verification:** Configuration review and acoustic measurement

### DSP-003 — Upper-channel high-pass

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The midrange/tweeter channel shall use a DSP high-pass filter that protects the midrange from excessive low-frequency excursion.
- **Verification:** Configuration review and acoustic measurement

### DSP-004 — Initial woofer/mid transition range

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** Initial testing should evaluate the woofer-to-midrange transition within approximately 200–500 Hz.
- **Verification:** Acoustic measurement and listening test

### DSP-005 — Input normalization

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Mono input mixing shall be configured so summed source contributions do not cause unintended gain or clipping.
- **Verification:** Configuration review and signal-level test

### DSP-006 — Output gain staging

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Output gains shall be established conservatively before full-range or high-level testing.
- **Verification:** Configuration review and test

### DSP-007 — Limiting

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** Available limiter or dynamics functions should be used to protect drivers once safe thresholds are established.
- **Verification:** Configuration review and test

### DSP-008 — Saved configurations

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** DSP configurations used for measurement, development, and normal operation shall be saved with descriptive names and version identifiers.
- **Verification:** Document review

### DSP-009 — Measurement preset

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** A known measurement preset shall be created that disables undocumented EQ, enhancement, dynamics, or routing behavior that would invalidate measurements.
- **Verification:** Configuration review

### DSP-010 — Polarity and delay

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Driver polarity and channel delay shall be selected from measured acoustic summation rather than assumption alone.
- **Verification:** Acoustic measurement

### DSP-011 — Final EQ

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Final equalization shall be based on the assembled system in the installed vehicle position.
- **Verification:** Acoustic measurement and listening test

---

## 10. Passive Midrange/Tweeter Crossover Requirements

### XOV-001 — Passive split

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The second amplifier channel shall be divided passively between the midrange and tweeter.
- **Verification:** Inspection and test

### XOV-002 — Final design basis

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The final passive crossover shall be designed from measured driver frequency-response, phase, and impedance data in the actual enclosure.
- **Verification:** Design-file review and measurement

### XOV-003 — Textbook networks

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** A generic calculator network based only on nominal 4-ohm impedance shall not be treated as the final crossover without validation.
- **Verification:** Design review

### XOV-004 — Working crossover region

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** The initial design target for the midrange-to-tweeter acoustic crossover should be approximately 2.5 kHz, subject to the selected tweeter, baffle geometry, directivity, and measurements.
- **Verification:** Analysis and acoustic measurement

### XOV-005 — Acoustic target

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The final acoustic crossover topology and slope shall be selected after measurement. A fourth-order Linkwitz–Riley acoustic target may be evaluated but is not mandatory.
- **Verification:** Crossover simulation and acoustic measurement

### XOV-006 — Tweeter protection

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The tweeter path shall contain passive high-pass protection sufficient to prevent damaging low-frequency energy under normal operation and foreseeable DSP configuration errors.
- **Verification:** Circuit review, impedance analysis, and test

### XOV-007 — Development protection

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Initial tweeter testing shall use conservative level, a suitable series protection capacitor, and a known DSP high-pass before higher-power testing.
- **Verification:** Inspection and configuration review

### XOV-008 — Midrange upper-band control

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The passive network shall attenuate the midrange sufficiently above the crossover region to avoid unacceptable overlap, breakup contribution, or interference with the tweeter.
- **Verification:** Acoustic measurement

### XOV-009 — Sensitivity matching

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The passive network shall provide any attenuation required to match tweeter level to the midrange without exceeding component power ratings.
- **Verification:** Measurement and thermal analysis

### XOV-010 — System impedance

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The completed midrange/tweeter network shall not create an unsafe low-impedance or excessively reactive load for the amplifier.
- **Verification:** Impedance measurement

### XOV-011 — Component ratings

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Capacitors, inductors, resistors, PCB traces, terminals, and wiring shall be rated for the expected voltage, current, heat dissipation, and automotive temperature environment.
- **Verification:** Component review and thermal test

### XOV-012 — Capacitor type

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** Signal-path capacitors should be non-polar and appropriate for loudspeaker crossover service. Final type selection shall balance size, cost, tolerance, loss, and thermal stability.
- **Verification:** Component review

### XOV-013 — Inductor placement

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Multiple inductors shall be separated and oriented to minimize magnetic coupling.
- **Verification:** Inspection

### XOV-014 — Component retention

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Crossover components shall be mechanically secured against vibration; solder joints shall not serve as the sole structural support.
- **Verification:** Inspection and vibration test

### XOV-015 — Crossover serviceability

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** The crossover should be accessible or removable without destroying the enclosure or removing permanently bonded structural parts.
- **Verification:** Demonstration

### XOV-016 — Prototype configurability

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** During development, the crossover should allow practical substitution of capacitors, inductors, and resistors without repeated damage to the wiring or enclosure.
- **Verification:** Inspection and demonstration

### XOV-017 — Full-power authorization

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The midrange/tweeter channel shall not be operated near maximum amplifier output until continuity, polarity, impedance, low-level response, and tweeter protection have been verified.
- **Verification:** Test record review

---

## 11. Acoustic Performance Requirements

### ACO-001 — High-frequency coverage

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The selected tweeter and final system shall provide useful on-axis output through the upper audible range without an intentional high-frequency cutoff below 20 kHz.
- **Verification:** Manufacturer data and acoustic measurement

### ACO-002 — Low-frequency target

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The required low-frequency extension and maximum output shall be established after sealed-box modeling and in-car measurement.
- **Verification:** Analysis and acoustic measurement

### ACO-003 — Full-system response target

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** A numerical in-car frequency-response target and tolerance shall be defined after the first assembled measurements.
- **Verification:** Document review and measurement

### ACO-004 — Driver integration

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The integrated system shall not contain severe crossover-region peaks, nulls, or discontinuities at the primary listening positions.
- **Verification:** Acoustic measurement

### ACO-005 — Audible distortion

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The system shall operate at the intended listening level without clearly audible mechanical distress, rubbing, bottoming, buzzing, or excessive nonlinear distortion.
- **Verification:** Listening test and measurement

### ACO-006 — Cabinet noise

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The enclosure, grilles, terminals, crossover, wiring, and vehicle-contact points shall not produce audible rattles or buzzes at the intended operating level.
- **Verification:** Sweep test and road test

### ACO-007 — Air leaks

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Sealed-chamber leaks shall not produce audible hissing, chuffing, or response anomalies.
- **Verification:** Low-frequency test and leak inspection

### ACO-008 — Listening-position optimization

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Final DSP tuning shall prioritize the intended rear-cabin listening region rather than only a microphone position close to the enclosure.
- **Verification:** Multi-position measurement and listening test

### ACO-009 — Spatial consistency

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** The system should avoid extreme tonal changes across normal rear-seat head positions.
- **Verification:** Multi-position measurement

### ACO-010 — Directivity review

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** Midrange/tweeter spacing, orientation, and crossover selection should be evaluated for directivity and lobing in the actual installation geometry.
- **Verification:** Analysis and off-axis measurement

### ACO-011 — Reference level

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** A reference listening and measurement level shall be defined before final output, distortion, and protection requirements are evaluated.
- **Verification:** SPL measurement

### ACO-012 — Maximum safe level

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** A maximum normal-use DSP level or limiter threshold shall be established from driver excursion, thermal limits, amplifier capability, and measurement.
- **Verification:** Analysis and test

---

## 12. Measurement and Validation Requirements

### MEAS-001 — Individual-driver measurement

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The woofer, midrange, and tweeter shall each be measured independently in the intended enclosure before the final crossover and DSP tuning are frozen.
- **Verification:** Measurement-file review

### MEAS-002 — Mounted-state measurement

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Final design measurements shall be taken with the drivers mounted in the actual baffle and chambers, not only from manufacturer datasheets or free-air testing.
- **Verification:** Measurement-file review

### MEAS-003 — Known signal path

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Every measurement shall document the amplifier channel, DSP preset, filter state, gain, microphone location, signal type, and test level.
- **Verification:** Measurement notes

### MEAS-004 — Low-level first test

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Initial sweeps shall begin at low level and increase only after confirming correct wiring and expected response.
- **Verification:** Test procedure review

### MEAS-005 — Microphone calibration

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** The measurement microphone's calibration file and orientation shall be used when available and recorded with the measurement setup.
- **Verification:** Software configuration review

### MEAS-006 — Acoustic software

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** REW or equivalent software should be used for sweep generation, response capture, timing, and comparison.
- **Verification:** Measurement-file review

### MEAS-007 — Crossover simulation

- **Priority:** SHOULD
- **Status:** Provisional
- **Requirement:** VituixCAD or equivalent software should be used to simulate the passive crossover from measured response and impedance data.
- **Verification:** Design-file review

### MEAS-008 — Impedance measurement

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Driver and completed-network impedance shall be measured before final crossover approval and full-power use.
- **Verification:** Impedance data review

### MEAS-009 — Near-field woofer measurement

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** Near-field measurement should be used when evaluating low-frequency driver and enclosure behavior that cannot be isolated reliably with an in-car far-field measurement.
- **Verification:** Measurement-file review

### MEAS-010 — Crossover summation

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Midrange-only, tweeter-only, normal-polarity sum, and reverse-polarity sum shall be measured during crossover development.
- **Verification:** Measurement-file review

### MEAS-011 — Multi-position final measurement

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Final system evaluation shall include multiple microphone positions representative of rear passengers.
- **Verification:** Measurement-file review

### MEAS-012 — Repeatable fixtures

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** Microphone and enclosure positions should be repeatable enough to compare revisions meaningfully.
- **Verification:** Measurement setup review

### MEAS-013 — Raw data retention

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Raw measurement files shall be retained in the project repository or a documented linked storage location.
- **Verification:** File review

### MEAS-014 — Result interpretation

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Smoothed plots may be used for presentation, but design decisions shall not rely only on heavily smoothed data.
- **Verification:** Measurement-file review

---

## 13. Safety and Protection Requirements

### SAFE-001 — Driver protection during development

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Expensive drivers shall not be exposed to full amplifier power until their wiring, filtering, polarity, and load have been verified.
- **Verification:** Test procedure review

### SAFE-002 — Tweeter low-frequency protection

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The tweeter shall never be connected directly to an unfiltered full-range amplifier output.
- **Verification:** Inspection

### SAFE-003 — Amplifier protection

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** No development configuration shall short an amplifier output, connect one output to another, or knowingly present a load below the amplifier's safe range.
- **Verification:** Continuity and impedance test

### SAFE-004 — Power-off reconfiguration

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Wiring and passive crossover changes shall be performed with the amplifier disabled and the output de-energized.
- **Verification:** Procedure review

### SAFE-005 — Protected conductors

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** No uninsulated energized conductor shall be accessible during normal installed use.
- **Verification:** Inspection

### SAFE-006 — Flammability and heat

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Materials placed near crossover power resistors, inductors, connectors, or future electronics shall tolerate expected heat without softening, igniting, or releasing parts.
- **Verification:** Material review and thermal test

### SAFE-007 — Component spacing

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Heat-producing crossover components shall have adequate spacing from printed plastic, damping material, wire insulation, and adhesive.
- **Verification:** Inspection and thermal test

### SAFE-008 — Passenger contact

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Normal passenger contact shall not expose wiring, sharp hardware, hot components, or moving speaker cones.
- **Verification:** Inspection and demonstration

### SAFE-009 — Emergency removal

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** The enclosure should be removable with ordinary hand tools without disassembling major vehicle systems.
- **Verification:** Demonstration

---

## 14. Serviceability Requirements

### SERV-001 — Driver replacement

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Each driver shall be removable and replaceable without cutting the enclosure.
- **Verification:** Demonstration

### SERV-002 — Crossover access

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** The passive crossover should be accessible for inspection and component changes.
- **Verification:** Demonstration

### SERV-003 — Internal wiring access

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** A documented method shall exist to inspect or repair internal wiring and chamber seals.
- **Verification:** Demonstration

### SERV-004 — Standard tools

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Routine installation, removal, and service should use common hand tools.
- **Verification:** Demonstration

### SERV-005 — Replaceable isolation pads

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Sorbothane or other floor-contact pads should be replaceable without reprinting the enclosure.
- **Verification:** Demonstration

### SERV-006 — Terminal replacement

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** External terminals should be replaceable without destructive disassembly.
- **Verification:** Demonstration

### SERV-007 — Assembly documentation

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** The final prototype shall have an assembly and wiring record sufficient to reproduce its configuration.
- **Verification:** Document review

---

## 15. Documentation and AI Workflow Requirements

### DOC-001 — Core files

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** The repository shall contain, at minimum:
  - `PROJECT.md`
  - `REQUIREMENTS.md`
  - `WORK_HISTORY.md`
- **Verification:** File review

### DOC-002 — AI reading order

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Before proposing or implementing project changes, AI tools shall read:
  1. `PROJECT.md`
  2. `REQUIREMENTS.md`
  3. the latest relevant portion of `WORK_HISTORY.md`
- **Verification:** Workflow review

### DOC-003 — Decision traceability

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Material architecture or requirement changes shall include a brief rationale in the documentation or Git commit history.
- **Verification:** Document and Git review

### DOC-004 — No silent requirement changes

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** AI tools shall not silently modify accepted requirements to fit a proposed design.
- **Verification:** Review

### DOC-005 — Assumptions

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Unverified assumptions shall be labeled as assumptions, provisional values, or TBD items.
- **Verification:** Document review

### DOC-006 — Measurement references

- **Priority:** MUST
- **Status:** TBD
- **Requirement:** Decisions based on measurements shall reference the relevant raw data file, plot, or work-history entry.
- **Verification:** Document review

### DOC-007 — CAD revision linkage

- **Priority:** SHOULD
- **Status:** TBD
- **Requirement:** Major CAD revisions should be linked to a Git commit, tag, or documented model version.
- **Verification:** Git and document review

### DOC-008 — Superseded concepts

- **Priority:** SHOULD
- **Status:** Accepted
- **Requirement:** Rejected or superseded concepts should remain recoverable through Git or be briefly recorded with the reason they were abandoned.
- **Verification:** Git and document review

### DOC-009 — Units

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** Engineering values shall state units. CAD dimensions should use millimeters as the primary unit, with inches included when useful.
- **Verification:** Document review

### DOC-010 — Current next action

- **Priority:** MUST
- **Status:** Accepted
- **Requirement:** `WORK_HISTORY.md` shall identify one clear immediate next goal rather than an unprioritized collection of possible tasks.
- **Verification:** Document review

---

## 16. Future Indoor Active-Speaker Compatibility

These requirements are deferred for V1 and shall not override vehicle fit or first-prototype simplicity.

### FUT-001 — Indoor mono mode

- **Priority:** DEFERRED
- **Status:** Accepted
- **Requirement:** A future revision may operate as an indoor mono loudspeaker.

### FUT-002 — Internal amplification

- **Priority:** DEFERRED
- **Status:** Accepted
- **Requirement:** A future revision may contain an internal multi-channel amplifier and DSP.

### FUT-003 — Passive external-amplifier mode

- **Priority:** DEFERRED
- **Status:** Provisional
- **Requirement:** A future indoor revision should retain a practical way to operate from an external amplifier if this does not create unsafe switching or unnecessary complexity.

### FUT-004 — Safe mode selection

- **Priority:** DEFERRED
- **Status:** Accepted
- **Requirement:** Any future active/passive mode selection shall prevent an internal amplifier output from being electrically connected to an external amplifier output.

### FUT-005 — Future expansion space

- **Priority:** MAY
- **Status:** Provisional
- **Requirement:** V1 may preserve space or mounting provisions for future electronics only when doing so does not materially reduce required acoustic volume or delay the prototype.

---

## 17. Open Requirement Values

The following values or decisions must be resolved later:

1. Exact verified vehicle installation envelope
2. Required front-seat movement range
3. Required usability of the center rear seating position
4. Positive restraint method
5. Retention load target
6. Final assembled mass
7. Final print material
8. Material temperature-validation target
9. Net woofer chamber volume
10. Net midrange chamber volume
11. Woofer sealed-box alignment target
12. Midrange damping strategy
13. Tweeter model
14. Tweeter mounting position and orientation
15. Grille structure and required load resistance
16. Amplifier minimum safe impedance and reactive-load limits
17. Internal wire gauge and connector ratings
18. Woofer-to-midrange DSP crossover
19. Midrange/tweeter crossover topology and component values
20. Reference SPL
21. Maximum safe SPL or DSP limiter threshold
22. Numerical final frequency-response target
23. Required low-frequency extension
24. Measurement procedure and microphone positions
25. Impedance-measurement hardware and workflow
26. Authoritative CAD source when CodeCAD and SolidWorks coexist

---

## 18. V1 Acceptance Gate

The first complete vehicle prototype shall not be considered ready for normal use until all of the following are true:

- [ ] Physical driver dimensions have been verified.
- [ ] The enclosure fits the vehicle without unacceptable interference.
- [ ] A positive mechanical restraint is installed.
- [ ] The enclosure has no visible structural print failure.
- [ ] Driver frames and chamber penetrations are sealed.
- [ ] Drivers are protected from passenger contact.
- [ ] Both amplifier input pairs are electrically isolated.
- [ ] Continuity and polarity are verified.
- [ ] The woofer path has a known DSP low-pass.
- [ ] The midrange/tweeter path has a known DSP high-pass.
- [ ] The tweeter has passive low-frequency protection.
- [ ] Low-level individual-driver sweeps have been completed.
- [ ] The completed passive network impedance has been checked.
- [ ] The crossover has been validated at low and moderate output.
- [ ] No audible enclosure, grille, wiring, or vehicle-contact rattle is present.
- [ ] A conservative normal-use DSP preset has been saved.
- [ ] The installed configuration and wiring are recorded in `WORK_HISTORY.md`.

---

## 19. AI Maintenance Instructions

When maintaining this file:

1. Do not convert provisional values into accepted requirements without evidence or user approval.
2. Do not record completed work here unless it changes a requirement or verifies one.
3. Put chronological activity, results, failures, and next steps in `WORK_HISTORY.md`.
4. Keep requirement IDs stable.
5. Add new requirements in the most relevant section.
6. Mark replaced requirements as superseded rather than deleting their history without explanation.
7. Prefer measurable language such as “shall not contact,” “shall remain sealed,” or “shall be measured” over subjective language such as “should be good.”
8. When a subjective criterion is unavoidable, define how it will be evaluated.
9. Treat safety-related requirements as blocking items.
10. Treat the current CAD dimensions as a prototype baseline until vehicle fit and acoustic modeling validate them.
