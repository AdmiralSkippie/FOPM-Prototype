
# First Officer & Pilot Monitoring Plugin

////////// CURRENT VERSION //////////

Version 1.1 Procedures online (Check "Version History" for more details)
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

That's it for the installation, but if you want to enhance your experience there is four more things:

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

New in V1.1: the whole set of procedures and checklists can now be changed, so you can fly the same aircraft with a different operator's SOP.
The plugin comes with 3 packs:

    Airbus       - Manufacturer standard procedures and checklists
    Avianca 2022 - Airline procedures and checklists
    Legacy       - The procedures used in V1.0

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

///// CREATE A NEW VOICE PACK /////

Yes you can create your own voice pack, it's totally possible and easy.
You only need to read the instructions, you can find it into the "Create Voice Pack" folder (FO PM/Voices/Create Voice Pack) there are the resources to create a new pack.
Store the new pack into the "Voice Pack" folder to have it available whenever you want to use it.

That's it, enjoy and have good flights.
Best Regards: Admiral Skippie
