# Tesla Rear-Cabin Speaker Project

## Project Summary

This project is the design, fabrication, installation, and tuning of a custom high-fidelity loudspeaker system for the rear cabin of a Tesla Model 3.

The initial speaker will be a single, compact enclosure positioned on the rear floor behind the center console. The enclosure must use the limited available space efficiently, remain stable in the vehicle, avoid permanent modification of the car, and integrate with the vehicle's existing programmable DSP amplifier.

The first major goal is a fully functional and acoustically tuned prototype powered by two independent 65 W / 4 ohm amplifier outputs. The longer-term goal is to develop the enclosure and electronics into a more polished system that can also be adapted for use as a self-contained indoor mono loudspeaker.

This document is the high-level source of truth for the project. It defines the project vision, overall architecture, design philosophy, methods, broad current state, and major phases of work. Detailed constraints will be maintained separately in `REQUIREMENTS.md`, while completed work, test results, and immediate next actions will be maintained in `WORK_HISTORY.md`.

---

## Primary Goals

1. Design and build a high-fidelity rear-cabin speaker that fits behind the center console of the Tesla Model 3.
2. Use the available vehicle space as efficiently as possible while preserving passenger comfort, seat movement, HVAC airflow, and serviceability.
3. Integrate the speaker with two independently configurable 65 W / 4 ohm amplifier outputs.
4. Use DSP for routing, input mixing, EQ, delay, dynamics, and the woofer-to-midrange crossover.
5. Use a passive crossover between the midrange and tweeter for the first complete prototype.
6. Build the enclosure primarily through parametric CAD and large-format 3D printing.
7. Measure and tune the final acoustic system in the actual enclosure and installation environment.
8. Maintain a durable project record that can be read and updated by both the user and AI tools.
9. Preserve a path toward a future active, self-powered indoor mono speaker version.

---

## Current System Concept

The current design is a three-driver mono loudspeaker:

- One 8-inch woofer
- One 4.5-inch dedicated midrange
- One tweeter

The currently selected main drivers are:

- **Woofer:** Scan-Speak Revelator 22W/4851T00, 4 ohm (purchased)
- **Midrange:** Scan-Speak Illuminator 12MU/4731T00, 4 ohm (purchased)
- **Tweeter:** Current working selection: Scan-Speak Illuminator D3004/662000, 4 ohm (physical verification pending)

The vehicle amplifier provides two independent powered outputs. Each output can be assigned an arbitrary input mix and can be independently configured with filters, EQ, time alignment, level, panning, and dynamics processing.

The intended first complete architecture is:

```text
DSP amplifier output 1
    -> active low-pass and tuning in amplifier software
    -> woofer

DSP amplifier output 2
    -> active high-pass and tuning in amplifier software
    -> passive midrange/tweeter crossover
        -> midrange
        -> tweeter
```

Both amplifier outputs will receive the same intended mono program mix unless testing indicates that a different routing strategy produces better results.

This hybrid architecture keeps the low-frequency crossover in DSP, where it is easy to tune and does not require large passive components, while allowing the midrange and tweeter to share the second amplifier output through a passive crossover.

---

## Enclosure Concept

The enclosure is designed to sit on the rear floor behind the center console.

**Important note on current baseline:** The CodeCAD model currently represents a two-driver mechanical baseline (woofer + midrange). The intended V1 system adds a third driver (tweeter) with a passive midrange/tweeter crossover. Documentation and CAD updates to fully integrate the tweeter are in progress.

The current prototype concept is:

- Primarily one-piece large-format 3D-printed structural shell
- Removable, gasketed side-access panels for service and future expansion
- **Nominal body dimensions:** 241.3 mm (width) × 410 mm (length) × 220 mm (height)
- **Generated STL envelope (preliminary):** 246.3 mm × 415 mm × 253.05 mm (height variation due to baffle and feet)
- Sealed woofer chamber
- Separate sealed midrange chamber
- Internal divider between woofer and midrange volumes
- Internal bracing to reduce panel vibration
- Raised driver baffles
- Isolation feet with Sorbothane contact pads
- Wire pass-throughs for each chamber
- Parametric geometry so dimensions can be adjusted without rebuilding the model from scratch

The enclosure is currently being generated primarily with CodeCAD in Lua. More detailed geometry, fit refinement, mounting features, and cosmetic work may be completed in SolidWorks.

The design should remain easy to revise. Prototype print time and material use are acceptable costs if a new enclosure revision materially improves fit, strength, serviceability, or acoustic performance.

**Current immediate milestone:** Establish fabrication readiness by inventorying the delivered hardware, commissioning the 3D printer, and completing one documented calibration print. Physical driver and vehicle-envelope verification follow before the removable-panel CAD revision and full-size printing.

---

## Design Philosophy

### Prototype First

The first version is intended to prove that the concept works mechanically, electrically, and acoustically. It does not need to be the final polished product.

The prototype should answer questions such as:

- Does the enclosure fit the vehicle correctly?
- Is the enclosure stable during normal driving?
- Are the chamber volumes usable for the selected drivers?
- Does the cabinet rattle, resonate, flex, or leak?
- Can the system achieve useful output from the available amplifier power?
- Can the woofer, midrange, and tweeter be integrated successfully?
- Is the rear-floor location acoustically effective?
- What enclosure or crossover changes are required for the next revision?

### Measure Before Finalizing

Datasheets, simulations, and textbook crossover calculations are useful starting points, but the final design must be based on measurements of the actual drivers in the actual enclosure.

The project will use acoustic measurements to guide:

- Crossover design
- Driver level matching
- Polarity
- Delay and time alignment
- Equalization
- Resonance control
- Enclosure revision
- Final system validation

Each driver should be measured independently before the final crossover is selected. The completed system should then be measured again after integration.

### Use DSP Where It Provides the Most Value

The Tesla amplifier already provides extensive signal-processing capability. DSP should be used for operations that are difficult, expensive, or inflexible to perform passively, including:

- Input mixing
- Mono summing
- Woofer-to-midrange crossover
- Equalization
- Delay and time alignment
- Level control
- Dynamics and limiting
- Installation-specific tuning

Passive components should be used only where they are necessary or where they simplify the system.

### Preserve Modularity

Where practical, the design should allow major subsystems to be revised independently:

- Enclosure
- Drivers
- Passive crossover
- Wiring
- Terminal panel
- DSP configuration
- Future internal amplification

The enclosure should not unnecessarily lock the project into a single crossover, amplifier, or final use case.

### Document Decisions

Important design decisions should be recorded with their reasoning. AI tools should not infer that an old idea is still current when a later decision supersedes it.

The documentation should distinguish among:

- Confirmed decisions
- Current working assumptions
- Open questions
- Experimental ideas
- Rejected approaches
- Measured results

---

## Engineering and Development Methods

The project will use an iterative engineering workflow:

```text
Define goal
    -> model
    -> fabricate
    -> assemble
    -> measure
    -> analyze
    -> revise
    -> validate
```

The main tools and methods include:

### CAD and Mechanical Design

- CodeCAD in Lua for parametric enclosure generation
- SolidWorks for detailed modeling and refinement
- Vehicle measurements and, if useful, local 3D scanning
- Test coupons and partial prints before full enclosure prints
- Parametric control of major dimensions and mounting geometry

### Fabrication

- Large-format FDM 3D printing
- Mechanically reinforced walls, ribs, and braces
- Threaded inserts or other serviceable fasteners where appropriate
- Gaskets and sealants for acoustic sealing
- Sorbothane or similar isolation material for floor contact

### Electrical Integration

- Two isolated amplifier output channels
- Direct powered connection to the woofer
- Passive crossover between the midrange and tweeter
- Binding posts or another serviceable enclosure interface
- Safe tweeter protection during early testing
- Reversible wiring wherever practical

### Acoustic Measurement

- Calibrated or otherwise suitable measurement microphone
- Pink noise, sweeps, and individual-driver measurements
- Near-field and listening-position measurements as appropriate
- Measurement software such as REW
- Crossover simulation software such as VituixCAD
- Low-volume validation before high-output testing

### Version Control and Documentation

- Git for source history and rollback
- Obsidian for human-readable project documentation
- Continue and other AI-enabled development tools for code, analysis, and documentation
- Markdown files as the primary durable knowledge format

---

## Documentation Structure

The initial documentation set will consist of three main files:

### `PROJECT.md`

This file. It contains the broad project overview, architecture, methods, goals, current state, and long-term direction.

### `REQUIREMENTS.md`

A detailed list of mechanical, electrical, acoustic, manufacturing, safety, installation, and usability constraints. Requirements should be testable wherever possible.

### `WORK_HISTORY.md`

A chronological engineering log containing:

- Work completed
- Changes made
- Tests performed
- Results
- Problems found
- Decisions made
- Current blockers
- Immediate next goal

Additional files may be added later for specific topics such as measurements, crossover design, bill of materials, DSP settings, assembly procedures, risks, and enclosure revisions.

---

## Current Project State

The project is currently in the fabrication-readiness and physical-verification stage. The printer, speakers, filament, tools, and related supplies have been reported as delivered, but exact inventory and physical verification are pending.

Completed or substantially developed work includes:

- Selection and purchase of the woofer and midrange
- Selection of the rear-floor location behind the center console
- Selection of the broad two-channel hybrid active/passive architecture
- Selection of a current working tweeter (D3004/662000, pending physical verification)
- Parametric CAD development of the first enclosure prototype (currently a two-driver mechanical baseline)
- Definition of separate sealed woofer and midrange chambers
- Addition of basic bracing, feet, isolation-pad recesses, driver openings, and wire pass-throughs
- Establishment of Git and AI-assisted development workflows
- Initial investigation of crossover strategies and measurement workflow
- Preliminary chamber volume calculations (woofer: ~12.04 L, midrange: ~5.70 L)

Items still in development include:

- Removable, gasketed side-access panel design and validation
- Final tweeter physical verification and baffle integration
- Verification of exact driver mounting dimensions
- Detailed chamber-volume analysis (midrange chamber in particular)
- Final enclosure fit verification in vehicle
- Electrical terminal and internal wiring design
- Prototype fabrication
- Driver-by-driver acoustic measurement
- Passive midrange/tweeter crossover design
- Final DSP tuning
- Installation and road testing

The current CAD model should be treated as a first prototype rather than a frozen design. Enclosure geometry remains parametric and revision-ready.

---

## Major Project Phases

### Phase 1: Project Definition

Establish the project documents, architecture, requirements, selected components, open questions, and near-term milestones.

### Phase 2: Prototype Enclosure Design

Complete the first printable enclosure, verify driver fit, confirm vehicle packaging, and prepare the model for fabrication.

### Phase 3: Mechanical Prototype

Print and assemble the enclosure, install the drivers and hardware, inspect sealing and rigidity, and verify fit in the vehicle.

### Phase 4: Basic Electrical Operation

Wire the woofer and midrange/tweeter paths safely, confirm that each driver produces sound, and establish conservative DSP settings for testing.

### Phase 5: Individual Driver Measurement

Measure the woofer, midrange, and tweeter independently in the completed enclosure. Record response, phase, level, and any obvious cabinet problems.

### Phase 6: Passive Crossover Development

Use measured data to design and build the midrange/tweeter passive crossover. Measure, revise, and validate the crossover in the actual enclosure.

### Phase 7: Full-System DSP Tuning

Tune the woofer-to-midrange transition, EQ, delay, level, and dynamics using the Tesla amplifier software.

### Phase 8: Vehicle Validation

Evaluate the installed speaker for sound quality, rattles, stability, thermal behavior, passenger interference, and performance under real driving conditions.

### Phase 9: Revision and Refinement

Use the first prototype's results to decide whether to modify the enclosure, crossover, driver placement, mounting, materials, or system architecture.

### Phase 10: Future Active/Home Version

Develop a later revision that can operate as an indoor mono speaker using an internal amplifier, DSP, power supply, and appropriate input interface.

---

## Definition of Success for the First Complete Prototype

The first complete prototype will be considered successful when:

- The enclosure fits behind the center console without unsafe or unacceptable interference.
- The enclosure remains stable and does not create significant rattles or vibration noise.
- All three drivers operate safely from the two amplifier channels.
- The woofer and midrange/tweeter paths can be tuned independently.
- The passive midrange/tweeter crossover provides safe and usable integration.
- The system produces a subjectively convincing improvement in rear-cabin sound.
- Measured response is sufficiently controlled to support further DSP tuning.
- The prototype produces clear lessons and measurable direction for the next revision.

The first prototype does not need to achieve final cosmetic quality, perfect frequency response, or a finished home-speaker conversion.

---

## Guidance for AI Assistants

When working on this project, AI tools should:

1. Read this file first.
2. Read `REQUIREMENTS.md` before recommending mechanical, electrical, or acoustic changes.
3. Read the most recent entries in `WORK_HISTORY.md` before proposing the next action.
4. Treat measured results as more authoritative than generic calculations or assumptions.
5. Clearly distinguish confirmed facts from estimates and hypotheses.
6. Avoid silently changing the established architecture.
7. Explain when a recommendation conflicts with an existing decision.
8. Prefer small, testable next steps over large speculative redesigns.
9. Update documentation when decisions, results, or project state materially change.
10. Preserve revision history rather than overwriting the reasoning behind prior decisions.

---

## Long-Term Vision

The long-term objective is not merely to place an additional speaker in the car. It is to create a carefully engineered, measurable, serviceable loudspeaker platform that uses the unusual flexibility of the Tesla DSP amplifier, makes effective use of a constrained installation space, and can evolve through documented prototype revisions.

A successful final system should combine:

- High-quality drivers
- A rigid custom enclosure
- Well-controlled passive and active filtering
- Measurement-based tuning
- Reversible vehicle installation
- Maintainable project documentation
- A practical path to future indoor active-speaker use
