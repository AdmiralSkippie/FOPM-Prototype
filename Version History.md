
# VERSION HISTORY

# Version V1.2 On Hand Checklist

---

## Visual changes

**Checklists on screen (Interface Checklist)**
A new "Interface Checklist" setting lets you follow every checklist on the FO window while he reads it. Instead of the "Executing Checklist" message, the Main page now shows the current item together with its answer, for example "SEAT BELTS... ON" or "GEAR PINS & COVERS... REMOVED", and it moves on at the same pace as the FO's voice until CHECKLIST COMPLETED. Items whose answer depends on your flight, such as BARO REF, FLAPS SETTING, PITCH TRIM or T.O RWY, show "____" in place of the value.

It is switched off by default, tick it in the Settings page to use it.

**Logbook**
The Settings page now shows your **Total Flt Hours** and **Total Flights** flown with the FO. The time starts counting when the aircraft starts moving at pushback and stops when the Parking procedure is completed, which is when the flight is added to the logbook. It is kept in "FO PM/Logbooks/A32S Logbook.lua", so it carries over from one session to the next, and a flight picked back up with RECOVERY keeps counting.

**Window size and position**
The window no longer grows or shrinks by itself when you move between Main, Briefing and Settings, it keeps the size you gave it and only adjusts by the difference between the pages. The page you are leaving no longer flashes under the new one for a frame when you switch.

The position is now saved no matter how you close the window, with the command, the macro or the window's own X button. If the saved position is no longer valid, for example because it was on a monitor that is not connected anymore, the window opens in its default position instead of somewhere you cannot reach.

---

## Functional changes

**Speak Only Essentials now applies to checklist answers**
With "Speak Only Essentials" on, the FO only speaks the answer of the essential items (BARO REF, T.O SPEEDS & THRUST, WINDOWS & DOORS, FLIGHT CONTROLS, FLAPS SETTING and T.O RWY), the rest of the items move on silently when you confirm them. With the setting off he answers every item, as before.

**Takeoff runway confirmation at Line Up**
In the T.O RWY item of the Line Up checklist the FO now reads out the runway loaded in the PERF TAKE OFF page before confirming it, including its side: "two seven left", "one three right", "one eight center", or just "two seven" for a runway without a side. If there is no runway loaded he simply confirms the item as before.

**"QNH" or "ALTIMETER"**
When the FO sets his baro reference, and when he answers the BARO REF item of the checklists, he now says "QNH" when the pressure is in hPa and "ALTIMETER" when it is in inHg, followed by the digits, instead of the generic "BARO REFERENCE".

**New voices**
Five new callouts have been added to both default voice packs, Owen and Adriana: QNH, ALTIMETER, LEFT, RIGHT and CENTER. The "Voices list.txt" used to create a voice pack now includes them. A custom pack made for V1.1 still works without them: the plugin reports the missing files in Settings and in the log, the FO skips those words, and the checklist or procedure carries on.

**Session recovery for One Engine Taxi**
RECOVERY now also resumes a One Engine Taxi Departure exactly at the step where it was, without repeating any decision already taken, like starting engine 2 or switching the APU BLEED. If the After Start checklist launched by the FO was halfway, it is launched again from its first item.

The flight state is now checked every 10 seconds and written only when something actually changed, which makes the saving lighter during the flight.

**Entry RWY and Exit RWY wait for the Taxi and Before Takeoff procedures**
The Entry RWY and Exit RWY buttons are hidden while the Taxi or Before Takeoff procedure is running, and they come back as soon as the FO says READY, so the two flows no longer mix with each other.

**Legacy pack retired**
The "Legacy" procedures and checklists pack has been removed, Airbus and Avianca 2022 remain. If your configuration points to a pack that does not exist anymore, the plugin now loads the Airbus pack instead of failing to start. If you flew with Avianca 2022 in V1.1, select it again in Settings after updating.

**More variety in the FO's phrases**
The random choice of the FO's variable phrases, such as the READY or the briefing callouts, is now better seeded, so they change more from one session to the next.

**Callout durations are now measured automatically**
The plugin no longer depends on a table of hand written durations to space out the First Officer's callouts. When a voice pack is loaded it now reads the exact length of every .wav straight from the file itself, and uses that to time the speech.

As a pilot you will not notice any difference, the FO speaks exactly as he did before. The change is for anyone building a voice pack, because it removes the longest and most error prone part of the job: you record the file, name it correctly, and that is all. There is no duration to measure, no number to type in, and nothing to keep in sync when you re-record a callout later. A pack can no longer fall out of step with its own audio, and the few durations in the default packs that had drifted slightly from their files are now exact.

The "FO Voicepack conf.lua" file of every pack now carries only the pack name. If you ever want one callout to be spaced out by something other than its real length you can still declare it there, and it will override the measurement.

**Missing or unreadable voice files no longer run the callouts together**
If a file is missing, or is not a readable PCM .wav, the plugin now reports it in the X-Plane log naming the file, and falls back to a one second spacing for that callout instead of leaving it with no spacing at all and letting the FO talk over himself.

---

## Bug fixes

**Back to back flights without reloading**
When the Parking checklist takes you back to Preflight, every checklist and procedure of the previous flight is now reset, so the next leg starts clean without reloading the script.

**Takeoff callouts could be skipped**
The FO only called "100 KNOTS" and "V1" if he caught the exact knot at the moment he checked the speed, so with a fast acceleration or a low frame rate he could miss them. The takeoff callouts are now said in order as soon as each speed is reached, and none of them is skipped.

**The go-around procedure could stop halfway**
On an ILS or MLS approach the FO skipped the step that opens the PERF page of his MCDU, so he tried to read the flaps, slats and green dot speeds from the wrong page, and if one of those lines had no number the go-around procedure stopped. He now always opens the PERF page, and an empty line no longer stops the procedure.

# Version V1.1 Procedures online

---

## Visual changes

**Loaded pack information in Settings**
The Settings window now shows which Procedures pack and which Checklists pack you currently have loaded, alongside the plugin version and the Voice Pack.

**New data in the Departure Briefing**
The takeoff briefing now displays more information, and it fills itself in automatically by reading directly from the MCDU:

- **FLIGHT** — your departure, destination and alternate airports
- **TO RWY** — the selected departure runway
- **Trim** — the calculated takeoff pitch trim
- **Thrust** — shows whether the takeoff is TOGA or Flex, and at what temperature
- **Baro Ref** — the current altimeter setting with its unit

**Time since engine shutdown**
On IAE-powered aircraft, the Departure Briefing now shows **Time Since ENG SD**, with the minutes elapsed since you shut the engines down on the previous flight. Useful for cooling times during turnaround operations.

**A319 variant identification**
The plugin now correctly identifies all three A319 variants (A319-112, A319-115 and A319-132) with their corresponding engine.

**Reload notice**
When you switch procedure packs, a notice appears letting you know the script must be reloaded for the changes to take effect.

---

## Functional changes

**Automatic weather request and altimeter setting (WX REQUEST)**
With the new "FO Request Weather" setting enabled, a **WX REQUEST** button appears in both the Departure and Arrival Briefings. The First Officer then handles the whole weather request on his own:

- Navigates the MCDU to the ATSU datalink page
- Reads your departure, destination and alternate airports straight from the flight plan
- Sends the METAR request and waits for the reports to arrive
- Opens the correct report for your current phase of flight — departure airport while on the ground, destination once airborne
- Reads the QNH out of the METAR, calls it out digit by digit, and sets his altimeter for you
- Returns the MCDU to the flight plan page when finished

The FO also switches the baro unit automatically between hPa and inHg depending on what the report uses, and pulls to STD if you are already above the transition altitude. If the request fails or the reports do not arrive, the FO backs out cleanly instead of leaving the MCDU stuck on the wrong page.

This feature uses the aircraft's ACARS datalink, so it requires a Hoppie logon code configured in your ToLiss aircraft. It is switched off by default.

**Manual baro reference entry**
If you do not have a Hoppie logon code, leave the "FO Request Weather" setting off and the briefings will show a **Set Baro Ref** field instead of the WX REQUEST button. Type the QNH you got from anywhere else and press **SET**, which appears once the value is a pressure the aircraft can accept. From there the FO does exactly the same as with the automatic request: he calls the value out digit by digit, switches between hPa and inHg on his own, and sets his altimeter. Both departure and arrival briefings have their own field, so you can enter a new value for the destination in flight.

**Baro Reference is now verified against the real QNH**
The Baro Reference item in the Cockpit Preparation and Approach checklists no longer just checks that both altimeters agree with each other. It now compares them against the actual QNH, whether it came from the weather report or from the manual entry, so the item only passes when the altimeters are genuinely set to the correct pressure. If no QNH is available yet, the item falls back to the previous behaviour.

**Arrival and approach change after briefing (ARR/APP CHANGE)**
The arrival briefing now works the same way as the departure one. After confirming, the CONFIRM button turns into **ARR/APP CHANGE**, so you can go back and change the approach type, minimums or autobrakes if the arrival changes.

**Session recovery (RECOVERY)**
The FO now automatically saves the state of your flight as it progresses. If the simulator closes, the script is reloaded, or the session is otherwise lost, a **RECOVERY** button appears next to the flight phase, letting you pick the flight back up exactly where you left off — without losing completed checklists or procedures already performed.

**New setting: FO Request Weather**
A new switch in Settings, off by default, that decides how the FO gets the QNH. Turned on, he requests the METAR himself over the datalink; turned off, you type the QNH into the briefing and he sets it from there.

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

**Rebuilt audio engine**
The FO's voice system now runs through X-Plane's own audio engine and plays through the cockpit interior bus, so the callouts sit naturally in the cockpit soundscape alongside the rest of the aircraft. Callouts made up of several clips — such as spelling out a QNH — are now queued and spoken in order instead of overlapping.

---

## Bug fixes

**Voices could overlap and talk over each other**
Callouts from different procedures could be triggered at the same moment and play on top of one another. Voice playback is now queued so each callout finishes before the next one starts.

**Missing or broken voice packs failed silently**
If a voice file was missing or misnamed, the FO simply went quiet with no indication of why. Missing files are now detected and reported at load, and a procedure pack referring to a callout that does not exist in the voice pack no longer stops the plugin.

**The FO commanded the landing gear during a go-around**
During a go-around, the FO could command the gear at an inappropriate moment. It now correctly respects the go-around phase and stays out of the way.

**Flap commands left active in flight**
The flap extension command was not being cleared properly after execution, which could leave the FO in an inconsistent state. It now resets as it should.

**Takeoff procedure after a rejected takeoff**
Under certain conditions following a rejected takeoff, the FO could start the takeoff procedure without the corresponding checklist having been completed. Fixed.

**Flaps configuration callout was missing during After Start**
The FO did not announce the flaps configuration at the flaps step of the After Start procedure. The callout is now spoken as intended.

**A319 showed A320 data**
In V1.0, flying any A319 variant would display "A320-232" or "A320-214" with their engines in the panel. It now shows the correct variant and engine.

**Interface typos**
Corrected "FO Auto Perfomr" to "FO Auto Perform" and "Speak Only Essencials" to "Speak Only Essentials".

**QNH selectors locking at 1013**
The barometric selectors could glitch and lock at 1013 hPa. This is resolved with the new baro setting logic and the manual alignment of all three selectors is no longer required.


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