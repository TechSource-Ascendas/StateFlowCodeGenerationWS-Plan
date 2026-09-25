<div align="center">
<img src="workshop instruction/images/techsource_logo.png" alt="TechSource Systems" width="400">
</div>

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/)

# Hands-On Workshop — Stateflow, Code Generation & Deployment to Arduino Uno

## Battery State Controller Model (EN)

This repository contains the complete participant + instructor material for a **2-hour hands-on workshop** where participants build a finite-state machine (Stateflow), simulate it, generate embedded C code, and deploy it to an **Arduino Uno**.

| | |
|---|---|
| **Duration** | 120 minutes (40 min instruction + 50 min hands-on + 30 min deploy & challenge) |
| **Products** | MATLAB, Simulink, Stateflow, Embedded Coder, Simulink Support Package for Arduino Hardware |
| **Hardware** | Arduino Uno (ATmega328P) — 1 board per group of 3 |

---

## Folder Structure

```
StateFlowCodeGenerationWS-Plan/
├─ StateflowCodeGenerationWorkshop.prj     # MATLAB project (sets path + config)
├─ ComponentList_V1.0.xlsx                 # Part/component list
├─ models/
│  ├─ starter_model.slx                    # ⭐ START HERE (empty Stateflow chart)
│  └─ completed_model.slx                  # Reference completed model
├─ requirements/
│  └─ battery_mode_requirements.csv        # REQ-01..08 (drives the logic)
├─ tests/
│  └─ battery_mode_test_cases.csv          # 7 validation cases
├─ data/
│  └─ battery_parameters.m                 # Battery parameters
├─ resources/                              # MATLAB project metadata (keep for openProject)
├─ work/                                   # Build output, git-ignored (<model>_ert_rtw/, *.hex/.elf/.eep, slprj/)
└─ workshop instruction/
   ├─ WS1 - Battery State Controller … _en.md      # Step-by-step guide (EN)
   ├─ WS1 - Battery State Controller … _id.md      # Step-by-step guide (ID)
   ├─ WS1 - Battery State Controller … _en.docx    # Styled DOCX (EN)
   ├─ WS1 - Battery State Controller … _id.docx    # Styled DOCX (ID)
   ├─ WS1 - Battery State Controller … _en.mlx     # Live Script (EN)
   ├─ WS1 - Battery State Controller … _id.mlx     # Live Script (ID)
   └─ images/  (screenshot_starter_model.png, screenshot_completed_chart.png, screenshot_completed_model.png, fully_assembled_circuit.jpg, techsource_logo.png)
```

---

## Quick Start

1. Open MATLAB and the project:
   ```matlab
   >> openProject('StateflowCodeGenerationWorkshop.prj')
   ```
2. Verify toolboxes (Step 0 in the guide):
   ```matlab
   >> ver('stateflow'), ver('simulink'), ver('ecoder')
   >> supportPackageInstaller   % confirm "Simulink Support Package for Arduino Hardware"
   ```
3. Open the starter model and follow the guide:
   ```matlab
   >> open_system('models/starter_model.slx')
   ```

---

## Install Required Products (Toolbox Setup)

This workshop was validated with the **Dependency Analyzer** on the completed model. Beyond the Arduino support package, running the model requires the products below — install any that are missing **before** the session.

**How to install:** open MATLAB → **Home → Add-Ons → Get Add-Ons** (Add-On Explorer), search each product by name, and click **Install** (an internet + MathWorks account is required). For the Arduino package use the on-screen wizard.

| Product | Role in this workshop | Install / `ver` check |
|---------|-----------------------|----------------------|
| MATLAB | Core runtime | (always present) |
| Simulink | Model host | `ver('simulink')` |
| Stateflow | State-machine design | `ver('stateflow')` |
| Embedded Coder | Hardware-ready C code generation | `ver('ecoder')` |
| Simulink Support Package for Arduino Hardware | Deploys to the Arduino Uno | `supportPackageInstaller` (Support Package — not listed by `ver`) |

```matlab
% One-shot verification that every required product is installed:
>> ver('simulink'), ver('stateflow'), ver('ecoder')
>> supportPackageInstaller   % confirm "Simulink Support Package for Arduino Hardware" = Installed
```

---

## The Model

A **Battery State Controller** decides one of four states from voltage, current, and temperature:

| State | Condition | LED (state_id) |
|-------|-----------|----------------|
| IDLE | Safe V, |I| ≤ 1 A | D8 ON (0) |
| CHARGING | Safe V, I > 1 A | D9 ON (1) |
| DISCHARGING | Safe V, I < −1 A | D10 ON (2) |
| FAULT | V < 9 V or V > 12.6 V or T > 50 °C | D8, D9, D10 all ON (3) |

Build the 4-state chart yourself, or open `models/completed_model.slx` as the answer key.

---

## Prerequisites

- MATLAB + the products listed above, with the Arduino support package installed.
- (Optional) `serialport` in MATLAB to read the status packet instead of the Arduino Serial Monitor.

### Hardware per group

| No | Component | Qty | Unit | Notes |
| --- | --- | --- | --- | --- |
| 1 | Arduino Uno (ATmega328P) | 1 | Unit | One board per group of three |
| 2 | Breadboard, full-size | 1 | Unit | Per group |
| 3 | Potentiometer, 3-pin, 1 kΩ–20 kΩ (breadboard) | 3 | Unit | A0 = `Vpack`, A1 = `Ipack`, A2 = temperature |
| 4 | LED 5 mm — red | 2 | Unit | Status LED — 1 used + 1 spare |
| 5 | LED 5 mm — yellow | 2 | Unit | Status LED — 1 used + 1 spare |
| 6 | LED 5 mm — green | 2 | Unit | Status LED — 1 used + 1 spare |
| 7 | Resistor 330 Ω, 1/4 W through-hole | 6 | Unit | One per LED (D8–D10) — 3 used + 3 spares |
| 8 | Dupont jumper wires, M–M 40 pcs, 30 cm | 1 | Set | Per group |

The three status LEDs are wired to D8/D9/D10 and the three potentiometers to A0/A1/A2 — see **Step 9a** of the guide. The same list is available as a spreadsheet: [`ComponentList_V1.0.xlsx`](ComponentList_V1.0.xlsx).

---

*Hands-On Workshop material · TechSource Systems*
