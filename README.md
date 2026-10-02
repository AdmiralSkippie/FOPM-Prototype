
# First Officer & Pilot Monitoring Plugin

////////// CURRENT VERSION //////////

Version 1.2 On Hand Checklist (Check "Version History" for more details)
____________________________________________________________________________________________________

Hello there pilots and curious people welcome.
Here you will find a short instruction how to install the plugin and one more thing to enhance your experience.
Please read the "Documentation" file to know how to operate with the FO.
 
///// HOW TO INSTALL /////

¡IMPORTANT DISCLAIMER! - To run the plugin you need to have the FlyWithLua installed in your sim.

Compatible with:

Toliss A321/A21N V1.9.1

Toliss A320/A20N V1.3.2

Toliss A319 V1.12.1

If you have previous versions installed the plugin might crash

1. In the downloaded folder you will find 1 file "FO-PM.lua" and 1 folder "FO PM", put them both into the scripts folder of FlyWithLua
2. Enjoy :)

///// UPDATING FROM A PREVIOUS VERSION /////

1. Replace both "FO-PM.lua" and the "FO PM" folder with the new ones, overwrite all.
2. Your settings go back to their default values, so check them again in the Settings page.
3. The "Legacy" pack no longer exists. If you were flying with Avianca 2022, select it again in the Settings page and reload the script.
4. If you use a voice pack made for V1.1, it still works, but it is missing the five new callouts of V1.2, see "CREATE A NEW VOICE PACK" below.

DISCLAIMER: Do not update in the middle of a flight, a session saved with an older version can not be recovered with the new one.

That's it for the installation, but if you want to enhance your experience there are five more things:

///// CHANGE VOICE PACK /////

By default the plugin comes with 2 different voice packs, 1 male voice and 1 female voice, the loaded pack will be the female pack by default
But if you want to change it, or load a new one different, see below :), just follow this:

1. In the "FO PM" folder will be a folder named "Voices", in there will be another 2, named "Active" and "Voice Packs"
   In the second one will be the packs available, the 2 default packs and probably more.
2. Open the folder that you want to use.
3. Copy ALL the content and paste it into the "Active" folder we see before, overwrite all and reload the script.

DISCLAIMER: Due to script and lua limitations there can be only 1 pack active and loaded, if you want to change be sure that you are not in flight, i recommend to do that when you are in preflight phase
            because you need to reload the script and if you do that, all your progress will be lost, the reset or turnaround point is the preflight phase.
You will see the active voice pack name in the Settings page.

///// CHANGE PROCEDURES & CHECKLIST PACK /////

The whole set of procedures and checklists can be changed, so you can fly the same aircraft with a different operator's SOP.
The plugin comes with 2 packs:

    Airbus       - Manufacturer standard procedures and checklists
    Avianca 2022 - Airline procedures and checklists

The "Legacy" pack, with the procedures used in V1.0, was retired in V1.2.

To change it you don't need to move any file:

1. Open the Settings page in the FO interface.
2. Press the "Change PROC/CKLT Pack" button.
3. Select the pack you want and press "SAVE".
4. Reload the script.

The packs live in "FO PM/Procedures-Checklists", each one in its own folder.
You will see the loaded Procedures and Checklists pack names in the Settings page.

///// WEATHER AND BARO REFERENCE /////

The FO can set his own baro reference, and there are two ways to give him the QNH. You choose which one in the Settings page, with the "FO Request Weather" switch.

    ON  - A WX REQUEST button appears in the briefings and the FO requests the METAR
          himself through the aircraft's datalink. This needs a Hoppie logon code
          configured in your ToLiss aircraft.
    OFF - A "Set Baro Ref" field appears instead. You type the QNH and press SET.
          No Hoppie needed.

The switch is off by default, so if you don't use Hoppie you don't have to change anything.

///// CHECKLISTS ON SCREEN /////

New in V1.2: if you want to follow the checklists with your eyes and not only by ear, tick "Interface Checklist" in the Settings page.
While the FO reads a checklist, the Main page will show the current item and its answer, for example "SEAT BELTS... ON".
The setting is off by default.

///// CREATE A NEW VOICE PACK /////

Yes you can create your own voice pack, it's totally possible and easy.
You only need to read the instructions, you can find it into the "Create Voice Pack" folder (FO PM/Voices/Create Voice Pack) there are the resources to create a new pack.
Store the new pack into the "Voice Pack" folder to have it available whenever you want to use it.
Since V1.2 you don't need to measure the duration of the files anymore, the plugin reads it from each .wav on its own.

If you made a pack for V1.1, record the five new callouts of V1.2 (QNH, ALTIMETER, LEFT, RIGHT and CENTER, all of them in the "Voices list.txt") and add them to your pack.
Without them the pack still works, the FO just skips those words, and the Settings page will tell you how many files are missing.

That's it, enjoy and have good flights.
Best Regards: Admiral Skippie
