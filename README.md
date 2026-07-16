# Tesla Speakers

Parametric, 3D-printable sealed speaker enclosure for a rear-cabin car-floor
prototype. The cabinet is modeled in [CodeCAD](https://codecad.xyz/) with Lua
and is designed for active DSP/crossover use.

![Cabinet render](assets/cabinet_render.png)

## Drivers

| Position         | Driver                              | Mounting cutout | Frame diameter |
| ---------------- | ----------------------------------- | --------------: | -------------: |
| Woofer chamber   | Scan-Speak Revelator 22W/4851T00    |        194.1 mm |         222 mm |
| Midrange chamber | Scan-Speak Illuminator 12MU/4731T00 |          101 mm |         120 mm |

The driver dimensions and bolt patterns are encoded in
[parts/part.lua](parts/part.lua). Confirm the physical drivers against the
values in the script before committing a full-size print.

## Current Design

- Sealed, two-chamber cabinet with a full-height divider that isolates the
  midrange from woofer back-wave pressure.
- External dimensions: 241.3 mm wide, 410 mm long, and 220 mm cabinet height.
- 8 mm enclosure walls with a 3 mm exterior edge chamfer.
- 12 mm raised top baffles with 2 mm cosmetic trim rings.
- Rear-side 45-degree driver-cutout flares, kept conservative to preserve the
  nearby mounting-hole material.
- Internal woofer window brace with a rounded pill opening to stiffen the long
  cabinet walls while maintaining air movement within the woofer chamber.
- Two 12.5 mm side-wall wire pass-throughs, one for each sealed chamber.
- Four Sorbothane-ready isolation feet: 38.1 mm diameter, 19.05 mm tall, with
  26.9875 mm diameter by 6.35 mm deep pad pockets.
- Flared foot collars and underside X cross-bracing for a stiffer bottom panel.
- Low-relief exterior rails, rounded corner bumpers, and a recessed `NH` badge
  panel for a more finished appearance.

## Files

```text
assets/cabinet_render.png     Cabinet preview used above
parts/part.lua               Parametric CodeCAD model
generated/part.stl           Generated print mesh after a build
generated/part.step          Generated solid model after a build
12mu-4731t00/                Supplied midrange CAD files
22w-4851t00/                 Supplied woofer CAD files
project.json                 CodeCAD project definition
```

## Build

This project uses millimeters. Install CodeCAD, then run these commands from
the repository root:

```bash
# Open CodeCAD's live viewer and reload the model on each save.
ccad live

# Export STL and STEP files to generated/.
ccad build

# Check the CodeCAD installation if needed.
ccad doctor
```

## Parameters

The editable values are grouped at the top of
[parts/part.lua](parts/part.lua). The most useful groups are:

- **Cabinet:** width, length, height, wall thickness, divider location, and
  window-brace dimensions.
- **Drivers:** cutout sizes, frame sizes, bolt geometry, and individual X/Y
  positions.
- **Isolation:** foot dimensions, collar flare, Sorbothane pocket, and bottom
  cross-brace dimensions.
- **Finish:** baffle trim rings, exterior rails, corner bumpers, and the
  recessed monogram badge.

All driver-related position changes move the baffle, main cutout, and its bolt
pattern together.

## Print And Assembly Notes

- Use this PLA+ design as a functional prototype. For sustained in-car use,
  prefer a higher-temperature material such as ASA, PETG, or another material
  appropriate to the vehicle's temperature range.
- Use closed-cell gasket tape under the driver frames and seal the wire exits
  with suitable grommets and flexible sealant. A sealed cabinet is sensitive to
  small air leaks.
- Fit 1.0625 in diameter by 0.25 in thick Sorbothane discs into the underside
  foot pockets. Select the Sorbothane durometer for the fully loaded cabinet
  weight and intended compression range.
- Line the woofer chamber walls with damping material. Add stuffing gradually
  after measurement; keep it clear of the woofer basket and vent.
- Line and moderately fill the isolated midrange chamber with suitable acoustic
  absorption to reduce internal reflections.
- The model includes structural braces, but print orientation, perimeter count,
  material choice, and infill should be chosen for a rigid, airtight enclosure.

## Status

This is a proof-of-concept enclosure intended for active tuning and in-car
measurement. Validate the final response, crossover settings, sealing, and
mechanical fit with the actual drivers before treating it as a permanent
installation.
