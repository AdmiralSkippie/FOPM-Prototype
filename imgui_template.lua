--[[
IMGUI Blank Template
Author: Joe Kipfer 2019-06-06
Use in conjuction with Folko's IMGUI Demo script for some great examples and explaination.
When Using IMGUI Demo script mentioned above, don't forget to put the imgui demo.jpg in with it or
you'll get an error.
]]

if not SUPPORTS_FLOATING_WINDOWS then
    -- to make sure the script doesn't stop with old FlyWithLua versions
    logMsg("imgui not supported by your FlyWithLua version")
  return
end
-----------------------------------Variables go here--------------------------------------------
--Set you variables here, datarefs, etc...










-------------------------------------Build Your GUI Here----------------------------------------

function myProgram_on_build(myProgram_wnd, x, y)  --<-- your GUI code goes in this section.
  




  
end -- function myProgram_on_build

-------------------------------------------------------------------------------------------------







-------------------Show Hide Window Section with Toggle functionaility---------------------------

myProgram_wnd = nil  -- flag for the show_wnd set to nil so that creation below can happen - float_wnd_create

function myProgram_show_wnd() -- This is called when user toggles window on/off, if the next toggle is for ON
    myProgram_wnd = float_wnd_create(500, 500, 1, true)
    float_wnd_set_title(myProgram_wnd, "myProgram IMGUI Template v1.0")
    float_wnd_set_imgui_builder(myProgram_wnd, "myProgram_on_build")
end


function myProgram_hide_wnd()  -- This is called when user toggles window on/off, if the next toggle is for OFF
    if myProgram_wnd then
        float_wnd_destroy(myProgram_wnd)
    end
end

myProgram_show_only_once = 0
myProgram_hide_only_once = 0

function toggle_myProgram_window()  -- This is the toggle window on/off function
	myProgram_show_window = not myProgram_show_window
	if myProgram_show_window then
		if myProgram_show_only_once == 0 then
			myProgram_show_wnd()
			myProgram_show_only_once = 1
			myProgram_hide_only_once = 0
		end
	else
		if myProgram_hide_only_once == 0 then
			myProgram_hide_wnd()
			myProgram_hide_only_once = 1
			myProgram_show_only_once = 0
		end
	end
end
------------------------------------------------------------------------------------------------






----"add_macro" - adds the option to the FWL macro menu in X-Plane
----"create command" - creates a show/hide toggle command that calls the toggle_myProgram_window()

add_macro("myProgram Menus: open/close", "myProgram_show_wnd()", "myProgram_hide_wnd()", "deactivate")
create_command("myProgram_menus/show_toggle", "open/close myProgram Menu window", "toggle_myProgram_window()", "", "")

--[[
footnotes:  If changing color using PushStyleColor, here are common color codes:  
    BLACK       = 0xFF000000;
    DKGRAY      = 0xFF444444;
    GRAY        = 0xFF888888;
    LTGRAY      = 0xFFCCCCCC;
    WHITE       = 0xFFFFFFFF;
    RED         = 0xFFFF0000;
    GREEN       = 0xFF00FF00;
    BLUE        = 0xFF0000FF;
    YELLOW      = 0xFFFFFF00;
    CYAN        = 0xFF00FFFF;
    MAGENTA     = 0xFFFF00FF;
    ]]