
# VERSION HISTORY

# Version V1.1 Procedures online

---

## Visual changes

**Loaded pack information in Settings**
The Settings window now shows which Procedures pack and which Checklists pack you currently have loaded, alongside the plugin version and the Voice Pack.

**New data in the Departure Briefing**
The takeoff briefing now displays more information, and it fills itself in automatically by reading directly from the MCDU:

- **TO RWY** — the selected departure runway
- **Trim** — the calculated takeoff pitch trim
- **Thrust** — shows whether the takeoff is TOGA or Flex, and at what temperature

**Time since engine shutdown**
On IAE-powered aircraft, the Departure Briefing now shows **Time Since ENG SD**, with the minutes elapsed since you shut the engines down on the previous flight. Useful for cooling times during turnaround operations.

**A319 variant identification**
The plugin now correctly identifies all three A319 variants (A319-112, A319-115 and A319-132) with their corresponding engine.

**Reload notice**
When you switch procedure packs, a notice appears letting you know the script must be reloaded for the changes to take effect.

---

## Functional changes

**Session recovery (RECOVERY)**
The FO now automatically saves the state of your flight as it progresses. If the simulator closes, the script is reloaded, or the session is otherwise lost, a **RECOVERY** button appears next to the flight phase, letting you pick the flight back up exactly where you left off — without losing completed checklists or procedures already performed.

**Swappable procedure and checklist packs**
You can now change the entire set of procedures and checklists without touching anything in the plugin. In Settings, the **Change PROC/CKLT Pack** button opens a new screen where you choose from the available packs:

- **Airbus** — manufacturer standard procedures and checklists
- **Avianca 2022** — airline procedures and checklists
- **Legacy** — the plugin's previous procedures

Select the one you want, press **SAVE**, and reload the script.

**New checklists**
Four checklists that did not exist before have been added:

- **Cockpit Preparation CKL** — available during preflight
- **Taxi CKL**
- **Departure Change CKL** — activated from the Departure Briefing
- **Line Up CKL**

**New Taxi procedure**
**Taxi Proc.** has been added as a standalone procedure, available during taxi out.

**Departure change after briefing (DEP CHANGE)**
Previously, once you confirmed the Departure Briefing there was no way to modify it. Now, after confirming, the CONFIRM button turns into **DEP CHANGE**: you can go back to the briefing and change runway, flaps, speeds or packs configuration, and the FO recognizes the change. Using it also activates the Departure Change Checklist, which does not appear under normal conditions.

**Autobrakes selection in the Arrival Briefing**
You can now select **LOW** or **MED** directly in the arrival briefing. The FO uses that selection to verify the autobrakes item during the Approach Checklist and to call out the correct setting.

---

## Bug fixes

**The FO commanded the landing gear during a go-around**
During a go-around, the FO could command the gear at an inappropriate moment. It now correctly respects the go-around phase and stays out of the way.

**Flap commands left active in flight**
The flap extension command was not being cleared properly after execution, which could leave the FO in an inconsistent state. It now resets as it should.

**Takeoff procedure after a rejected takeoff**
Under certain conditions following a rejected takeoff, the FO could start the takeoff procedure without the corresponding checklist having been completed. Fixed.

**A319 showed A320 data**
In V1.0, flying any A319 variant would display "A320-232" or "A320-214" with their engines in the panel. It now shows the correct variant and engine.


# Version 1.0 Main Release

**This is the first public release version of the plugin**

First Officer / Pilot Monitoring plugin for Toliss A319, A320, A20N, A321 and A21N
Perform procedures with and without commands
Read Checklist and checking that the items ware performed and set correctly
Check the flight parameters in takeoff, flight and landing, with their respective callouts, according to the SOP

**FO can now perform this normal procedures:**
-   PRELIMINARY COCKPIT PREPARATION
-   AFTER START PROCEDURE
-   FLIGHT CONTROLS CHECK
-   BEFORE TAKEOFF PROCEDURE
-   ENTRY & EXIT RWY PROCEDURE
-   AFTER TAKEOFF PROCEDURE
-   CLEAN UP PROCEDURE (ON COMMAND / AUTO PERFORM)
-   10000FT CLIMB PROCEDURE (ON COMMAND / AUTO PERFORM)
-   10000FT DESCEND PROCEDURE (ON COMMAND / AUTO PERFORM)
-   FLAPS OPERATION (ON COMMAND)
-   GEAR OPERATION (ON COMMAND)
-   AP DISENGAGE PROCEDURE (AS NEEDED DEPENDING ON THE APPROACH)
-   FLIGHT PARAMETER CHECK
-   GO-AROUND PROCEDURE
-   AFTER LANDING PROCEDURE

**And this supplementary procedures:**
-   ONE ENGINE TAXI DEPARTURE PROCEDURE
-   ONE ENGINE TAXI ARRIVAL PROCEDURE

**FO can check and read this checklist:**
-   BEFORE START CHECKLIST
-   BEFORE START CHECKLIST BELOW THE LINE
-   AFTER START CHECKLIST
-   BEFORE TAKEOFF CHECKLIST
-   BEFORE TAKEOFF CHECKLIST BELOW THE LINE
-   AFTER TAKEOFF CHECKLIST
-   CLIMB CHECKLIST
-   APPROACH CHECKLIST
-   LANDING CHECKLIST
-   AFTER LANDING CHECKLIST
-   PARKING CHECKLIST
-   SECURING CHECKLIST

**Additionally the FO can perform/say callouts in accordance with the situation/approach type at the moment:**
-   TAKEOFF MONITORING CALLOUTS
-   TRANSITION ALTITUDE CALLOUT
-   TRANSITION LEVEL CALLOUT
-   DECEL MONITORING CALLOUTS
-   RNP AR DEPARTURE AND APP with their respective checklist items and flight parameters monitoring
-   ILS CAT II/III APP CALLOUTS with their respective checklist items and flight parameters monitoring

**Added Settings**
-   FO autoperform: allow FO auto perform clean up procedure and gear retraction on takeoff and GA
-   Speak Only Essentials: Restrict FO callouts to only when needed instead of all movements and actions
-   FO speed: FO action perform speed
        Fast = 0.6s
        Normal = 0.85s
        Study = 1.1s
All managed in the Settings UI page

Added Briefing page to manage all parameters about Takeoff and Landing briefing.
Added Main page to manage ongoing phase, on command procedures and checklist.
Added 6 main commands to xplane's command list for a keyboard assign:
-   Flaps 1 UP
-   Flaps 1 DOWN
-   Gear UP
-   Gear DOWN
-   Response Check (for checklists)
-   FO show/hide interface
Added 2 voice packs "Owen" and "Adriana", "Adriana" is loaded by default.

If you encounter any issues or bugs please report it, it will be checked as soon as possible

Enjoy and happy flights :)
Best Regards: Admiral Skippie