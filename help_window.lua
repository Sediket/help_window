require "serialize"  -- needed to serialize table to string
require "movewindow"
require "commas"

-- CONFIGURATION ---------------------------------------------------

local HEADING_INDENT = 20
local INDENT = 20
local GAP = 5
local TEXT_GAP = 5
local BACKGROUND_COLOUR = 0x000028
local WINDOW_HEADING = "Help"

local HEADING_COLOUR = ColourNameToRGB "yellow"
local TITLE_COLOUR = ColourNameToRGB "lime"
local DESCRIPTION_COLOUR = ColourNameToRGB "white"
local HELP_COLOUR = ColourNameToRGB "goldenrod"
local DOTS_COLOUR =  0x23325C

expanded = {}  -- which ones we expanded
active = true

-- ONE TABLE PER GROUP ITEM ---------------------------------------

links = {
  { name = "ZombieWiki",      desc = "The ZombieMud Wiki", url = "https://www.reddit.com/r/zombiemud/wiki/index/"},
  { name = "Quests",      desc = "The ZombieMud Wiki Quests", url = "https://www.reddit.com/r/zombiemud/wiki/quests"},
  { name = "Races",      desc = "The ZombieMud Wiki Races", url = "https://www.reddit.com/r/zombiemud/wiki/races"},
  { name = "Areas",      desc = "The ZombieMud Wiki Areas", url = "https://www.reddit.com/r/zombiemud/wiki/areas"},
  { name = "Guilds",      desc = "The ZombieMud Wiki Guilds", url = "https://www.reddit.com/r/zombiemud/wiki/classes"},
}


spells = {
  { name = "Skills",          desc = "List of skills." },
  { name = "Spells",          desc = "List of spells." },
  { name = "Spells spellup",  desc = "List of spellups (buffs)." },
  { name = "Spells combat",   desc = "List of combat abilities." },
  { name = "Affects",         desc = "Current affects (buffs) on you." },
  
} -- end spells

  
movement = {
  { name = "Areas",       desc= "Shows all areas in a level range." },
  { name = "Recall",      desc= "Returns you to Aylor Grand Temple." },
  { name = "Speedwalks",  desc= "Available speedwalks." },
  { name = "Mobdeaths",   desc= "Shows most frequently killed mobs (monsters) " },
  { name = "Mobkills",    desc= "Shows the mobs that most often kill players. " },
  { name = "Areadeaths",  desc= "Shows areas with at least one mob killed. " },
  { name = "Areakills",   desc= "Shows the mobs that most often kill players overall. " },
  { name = "Find all",    desc= "Shows nearby places of interest in the city. " },
  { name = "Bigmap",      desc= "Outdoors (not in an area), shows a large map." },
  { name = "Look",        desc= "Look around current room." },  
  { name = "Exits",       desc= "See room exits." },
  
  
    } -- end movement
  
todo = {

  { name = "Goals",       desc = "See a list of quests you have open." },
  { name = "Quest Info",  desc = "Show information about current quest" },
  { name = "Train",       desc = "Show training costs for each of your stats." },
  { name = "Raceinfo",    desc = "Show training costs modifiers for your race." },
  { name = "Exp",         desc = "Experience you have, and need to level up." },

} -- end todo


-- Information about you
mystuff = {
  { name = "Score",       desc = "Important information about your character." },
  { name = "Inventory",   desc = "What is in your bags." },
  { name = "Equip",       desc = "What you are wearing." },
  { name = "Hunger",      desc = "Hunger and thirst." },
  { name = "Config",      desc = "Your configuration options." },
  { name = "List",        desc = "List what is for sale, if at a shop." },
  { name = "Worth",       desc = "Shows your gold, bank balance, etc." },
  { name = "Myrank",      desc = "Things you have done." },
 
} -- end mystuff


combat = {

  { name = "Consider all",  desc = "Compare your own strength to others in the room." },
  { name = "Scan",          desc = "Show characters in the immediate area." },
  { name = "Study",         desc = "Show health of all characters in the room." },
  { name = "Where",         desc = "Shows players nearby (or 'WHERE <mob>' to find a mob)." },
  { name = "Flee",          desc = "Attempt to run away during combat. Costs experience." },
  { name = "Wimpy",         desc = "Set character to auto flee when low on hit points." },
  { name = "Ownedwhere",    desc = "Shows items you own, including your corpses." },
  { name = "Read page6",    desc = "Shows popular low-level areas." },
  

}   -- end combat

comms = {
  { name = "Channels",      desc = "See a list of all channels available." },
  { name = "Friend",        desc = "See your friends." },
  { name = "Info",          desc = "View/Toggle Game info channels." },
  { name = "Quiet",         desc = "Temporarily turn channels off/on (toggle)." },
  { name = "Socials",       desc = "List socials in game." },
  { name = "Random",        desc = "Use a random social." },
  { name = "Forums",        desc = "See available message forums." },
  { name = "Note",          desc = "Read next unread note." },
  { name = "Clist",         desc = "Show list of clans." },
  { name = "Who",           desc = "Show who is on Aardwolf." },
  { name = "Who helper",    desc = "Show players prepared to help you." },
  { name = "CatchTells",    desc = "Stores all tells sent to you (toggle)." },
  { name = "Replay",        desc = "Displays all saved/caught tells." },

}  -- end comms

help = {
  { name = "Contents",      desc = "Show help by category." },
  
} -- end help
  

-- GROUPS OF HELP --------------------------------------------------------

-- groups of related things - one item per help category

groups = {
  { name = "Links", list = links},




  { name = "Spells and skills", list = spells, 
            extrafunc = 
              function ()
                ShowText      ("To get spells and skills training, do ")
                ShowHyperlink ("recall")
                ShowText      (" and then ")
                ShowHyperlink ("run u6ne")
              end, 
            extrahelp = { "Train", "Practice", "Learned", "Showspell", "Allspells"},
                      },  -- end Spells and skills
  
  { name = "Movement", list = movement, 
              extrahelp = { "coordinates", "world", "shortmap", "maptags", "explored", "enter"  },
       
          },  -- end Movement

  { name = "To do / improvements", list = todo, 
            extrahelp = { "Eat", "Drink", "Gulp", "Run", "Find", "aq", "Listen", "www", "rules" },
            },  -- end To do 

  { name = "Information about you", list = mystuff, 
           extrahelp = { "Appraise", "Identify", "Value", "Buy", 
                         "Sell", "Bid", "Auction", "Deposit", "Withdraw", 
                         "Experience", "Alignment", "Get", "Drop",
                         "Wear", "Wield", "Hold", "Remove", "Object Flags",
                         "Qp", "Tp", "Newhelp", "Where" },
                          },  -- end Information
                          
  { name = "Combat", list = combat, 
            extrafunc = 
              function ()
                ShowText      ("To get healed, cured or restored, do ")
                ShowHyperlink ("recall")
                ShowText      (", ")
                ShowHyperlink ("run 3e")
                ShowText      (" and then ")
                ShowHyperlink ("heal")
              end,
            extrahelp = { "Healing", "Death", "Cr", "Cast", 
                         "Sleep", "Wake", "Group", "pk", "hunt"},
                      },  -- end Combat
                      
  { name = "Communications", list = comms, 
           extrahelp = { "Tell", "Reply", "Ignore", "Whois", "Warinfo", 
                         "Say", "Emote", "Note", "Subscribe", "Forum",
                         "afk", "deaf", "ignore", "rank" },
                      }, -- end Communications
  
  { name = "Help", list = help, 
           extrafunc = 
            function ()
              ShowText ("Type 'HELP <subject>' for help, 'HELP SEARCH <word>' to search for a word.")
              local line1_x = x
              
              -- start a new line
              x = INDENT
              y = y + font_height
              ShowText ("Type 'INDEX <x>' for help on words beginning with x.")
              
              x = math.max (x, line1_x) -- make sure we return the maximum width we took
              return 2  -- we showed 2 lines
            end,
  }, -- end Help                      
  
  } -- end groups
  

-- END CONFIGURABLE STUFF ---------------------------------------------------------

function click_hyperlink (flags, hotspotid)
  local item = tonumber (hotspotid)
  local text = hyperlinks [item]
  if not text then return end
  if IsConnected () then
    Send (text)
  else
    ColourNote ("yellow", "", "Cannot send '" .. text .. "' - not connected.")
  end -- if
end -- click_hyperlink

function click_web_hyperlink (flags, hotspotid)
  local item = tonumber (hotspotid)
  local text = hyperlinks [item]
  if not text then return end
  OpenBrowser (text)
end -- click_web_hyperlink


function click_group (flags, hotspotid)
  expanded [hotspotid] = not expanded [hotspotid]

  -- shift+click = expand or contract all of them  
  if bit.band (flags, 0x01) ~= 0 then
    for k, g in ipairs (groups) do
      expanded [g.name] = expanded [hotspotid]
    end -- for each group
  end -- if 
  make_helper_window ()
end -- click_hyperlink

function ShowText (text, colour)
  colour = colour or ColourNameToRGB "silver"
  WindowText (win, font_id, text, x, y, 0, 0, colour)
  x = x + WindowTextWidth (win, font_id, text)
end -- ShowText

function ShowWebHyperlink (text, colour, url)
  colour = colour or ColourNameToRGB "yellow"
  local hyperlink_text
  local lower_text = text:lower ()
  hyperlink_text = lower_text

  local width = WindowText (win, font_id_ul, text, x, y, 0, 0, colour)
  
  --table.insert (hyperlinks, hyperlink_text)
  table.insert (hyperlinks, url)
  local item = #hyperlinks
  local balloon
  
  balloon = "Click to send:\t" .. lower_text
    
  WindowAddHotspot (win, item, x, y, x + width, y + font_height, 
            "", -- MouseOver 
            "", -- CancelMouseOver 
            "", -- MouseDown 
            "", -- CancelMouseDown 
            "click_web_hyperlink", -- MouseUp 
            balloon, 
            1, -- Cursor
            0) --  Flag
  
  x = x + WindowTextWidth (win, font_id_ul, text)
            


end

function ShowHyperlink (text, colour, help_hyperlink)
  colour = colour or ColourNameToRGB "yellow"
  local hyperlink_text
  local lower_text = text:lower ()
  if help_hyperlink then
    hyperlink_text = "help " .. lower_text
    text = text:upper ()
  else
    hyperlink_text = lower_text
  end -- if

  local width = WindowText (win, font_id_ul, text, x, y, 0, 0, colour)
  
  table.insert (hyperlinks, hyperlink_text)
  local item = #hyperlinks
  local balloon
  
  if help_hyperlink then
    balloon = "Click to get help on:\t" .. lower_text
  else
    balloon = "Click to send:\t" .. lower_text
  end -- if 
    
  WindowAddHotspot (win, item, x, y, x + width, y + font_height, 
            "", -- MouseOver 
            "", -- CancelMouseOver 
            "", -- MouseDown 
            "", -- CancelMouseDown 
            "click_hyperlink", -- MouseUp 
            balloon, 
            1, -- Cursor
            0) --  Flag
  
  x = x + WindowTextWidth (win, font_id_ul, text)
            
end -- ShowHyperlink
  
function ShowExtraHelp (tbl)
  x = TEXT_GAP
  ShowText ("Also see ")
  local also_see_end = x
  
  table.sort (tbl, function (a, b) return a:upper () < b:upper () end )
  
  local total = #tbl
  
  for i, item in ipairs (tbl) do
    if i ~= 1 then
      if i == total then
        ShowText (" and ")
      else        
        ShowText (", ")
      end -- if
    end -- not first one
    
    local seperator
    local seperator_width = 0
    if i < total then
      if i == (total - 1) then
        seperator = " and "
      else        
        seperator = ", "
      end -- if
      seperator_width = WindowTextWidth (win, font_id, seperator)
    end -- not last one
    
    if (x + WindowTextWidth (win, font_id_ul, item)+ seperator_width) > (window_width - TEXT_GAP) then
      x = also_see_end     -- line up under "Also see"
      y = y + font_height  -- new line
    end -- if line too long
    
    ShowHyperlink (item, HELP_COLOUR, true)  -- is help item
  end -- for each item  
  
  y = y + font_height
  
end -- ShowExtraHelp

function GetExtraHelpLines (tbl)
  local lines = 1  -- at least one line
  
  local x = TEXT_GAP + WindowTextWidth (win, font_id, "Also see ")
  local also_see_end = x
  
  table.sort (tbl, function (a, b) return a:upper () < b:upper () end )
  
  local total = #tbl
  
  for i, item in ipairs (tbl) do
    local seperator
    if i < total then
      if i == (total - 1) then
        seperator = " and "
      else        
        seperator = ", "
      end -- if
      x = x + WindowTextWidth (win, font_id, seperator)
    end -- not last one
    
    if (x + WindowTextWidth (win, font_id_ul, item)) > (window_width - TEXT_GAP) then
      x = also_see_end     -- line up under "Also see"
      lines = lines + 1 -- new line
    end -- if line too long
    x = x + WindowTextWidth (win, font_id_ul, item)
    
  end -- for each item  
  
  return lines
  
end -- GetExtraHelpLines

function show_a_group (g)
 
 local triangle_size = 8
 
 local points 
 local balloon
 
 if expanded [g.name] then
  balloon = "Click to hide"
  points = string.format ("%i,%i,%i,%i,%i,%i", 
      TEXT_GAP, y + 2,   -- top left
      TEXT_GAP + triangle_size, y + 2,   -- top right
      TEXT_GAP + triangle_size / 2, y + triangle_size)  -- bottom (in middle)
 else
  balloon = "Click to expand"
  points = string.format ("%i,%i,%i,%i,%i,%i", 
      TEXT_GAP + 2, y + triangle_size + 2,  -- top left
      TEXT_GAP + 2, y + 2,     -- bottom left
      TEXT_GAP + 2 + triangle_size / 2, y + triangle_size / 2 + 2)  -- right (in middle)
 end -- if

 -- disclosure triangle
 WindowPolygon(win, points, HEADING_COLOUR, 0, 1, HEADING_COLOUR, 0, true, true)

 x = HEADING_INDENT
 x = x + WindowText (win, font_id, g.name, x, y, 0, 0, HEADING_COLOUR)
 
 WindowAddHotspot (win, g.name, TEXT_GAP, y, x, y + font_height, 
          "", -- MouseOver 
          "", -- CancelMouseOver 
          "", -- MouseDown 
          "", -- CancelMouseDown 
          "click_group", -- MouseUp 
          balloon, 
          1, -- Cursor
          0) --  Flag

 y = y + font_height
   
 if not expanded [g.name] then
   return
 end -- don't show anything else
 
  -- may as well put commands in alphabetic order
  table.sort (g.list, function (a, b) return a.name <  b.name; end)
  
  -- show each one
  for k, v in ipairs (g.list) do
    x = INDENT
    if (v.url) then
      ShowWebHyperlink(v.name, TITLE_COLOUR, v.url)
    else
      ShowHyperlink (v.name, TITLE_COLOUR)
    end
    WindowLine(win, x + 2, y + ascent, INDENT + max_title_width + GAP - 2, y + ascent, DOTS_COLOUR, 2, 1)
    x = INDENT + max_title_width + GAP
    ShowText (v.desc, DESCRIPTION_COLOUR)
    y = y + font_height
  end -- for loop     
        
  -- anything extra in this group?
  if g.extrafunc then
    x = INDENT
    g.extrafunc ()
    y = y + font_height
  end  -- call function to do special stuff
  
  -- additional table of things to put "help" in front of
  if g.extrahelp then
    ShowExtraHelp (g.extrahelp)
  end -- table of additional things
  
  -- show additional string
  if g.extrastr then
    x = INDENT
    ShowText(g.extrastr)
    y = y + font_height
  end -- extra string to show
   
  -- blank line between groups
  y = y + font_height
  
end -- show_a_group

function make_helper_window ()
   hyperlinks = {}

  local lines = 0
  max_title_width = 0
  max_description_width = 0
  window_width = 0
  y = TEXT_GAP
  
  local last_one_expanded = false
  
  for k, g in ipairs (groups) do
  
    if expanded [g.name] then
    
      lines = lines + #g.list + 2  -- one for heading, plus one line each, and one for blank line
      
      if g.extrafunc then
        x = INDENT
        lines = lines + (g.extrafunc () or 1)
        window_width = math.max (window_width, x + TEXT_GAP)
      end -- if
      
      if g.extrastr then
        lines = lines + 1
        window_width = math.max (window_width, WindowTextWidth (win, font_id, g.extrastr) + INDENT)
      end -- if
      
      -- measure each one
      for k, v in ipairs (g.list) do
        max_title_width = math.max (max_title_width, WindowTextWidth (win, font_id, v.name))
        max_description_width = math.max (max_description_width, WindowTextWidth (win, font_id, v.desc))
      end -- for loop    
      
      last_one_expanded = true
       
    else
      lines = lines + 1
      window_width = math.max (window_width, WindowTextWidth (win, font_id, g.name) + HEADING_INDENT + TEXT_GAP)
      last_one_expanded = false
      
    end -- if 
   
  end -- for each group

  window_width = math.max (window_width, INDENT + max_title_width + GAP + max_description_width + TEXT_GAP)

  -- now we know the width, see how many extra lines are needed  
  for k, g in ipairs (groups) do
    if g.extrahelp and expanded [g.name] then 
      lines = lines + GetExtraHelpLines (g.extrahelp)
    end -- if 
  end -- for each group
  
  -- don't need final blank line if that part was expanded
  if last_one_expanded then
    lines = lines - 1
  end -- if
  
  window_height =  (lines + 1) * font_height + TEXT_GAP * 2
        
   -- recreate the window the correct size
   WindowCreate (win, 
                 windowinfo.window_left, 
                 windowinfo.window_top, 
                 window_width,     -- width
                 window_height,  -- height
                 windowinfo.window_mode,   
                 windowinfo.window_flags,
                 BACKGROUND_COLOUR) 
  
   WindowDeleteAllHotspots (win)
   movewindow.add_drag_handler (win, 0, 0, 0, font_height, 1)
   
  -- draw drag bar rectangle
  WindowRectOp (win, 2, 0, 0, 0, font_height + TEXT_GAP, 0x8CE6F0)
  
  -- heading
  y =  WindowFontInfo (win, font_id, 4)
  x = (window_width - WindowTextWidth (win, font_id, WINDOW_HEADING)) / 2
  ShowText (WINDOW_HEADING, 0x000000)

  y = TEXT_GAP + font_height

  for k, g in ipairs (groups) do
    show_a_group (g)
  end -- for each group

  -- DrawEdge rectangle
  WindowRectOp (win, 5, 0, 0, 0, 0, 10, 15)

  WindowShow (win, true)
    
end -- make_helper_window

function IntroduceOurselves ()
  Tell ("Type ")
  Hyperlink  ("helplist", "", "", "yellow", "")
  Note (" for some helpful information about Aardwolf.")
end -- 

function OnPluginInstall ()

  win = GetPluginID ()

  local fonts = utils.getfontfamilies ()
  if fonts.Dina then
    font_size = 8
    font_name = "Dina"    -- the actual font
  else
    font_size = 10
    font_name = "Courier"
  end -- if
     
  font_id = "help_font"  -- our internal name
  font_id_ul = "help_font_ul"  -- our internal name

  windowinfo = movewindow.install (win, 6)
  
  -- make miniwindow so I can grab the font info
  check (WindowCreate (win, 
                 windowinfo.window_left, 
                 windowinfo.window_top, 
                 1, 1,  
                 windowinfo.window_mode,   
                 windowinfo.window_flags,
                 BACKGROUND_COLOUR) )
  
  WindowFont (win, font_id, font_name, font_size, false, false, false, false, 0, 49)  -- normal
  font_height = WindowFontInfo (win, font_id, 1)  -- height
  ascent = WindowFontInfo (win, font_id, 2)
  descent = WindowFontInfo (win, font_id, 3)
  font_width = WindowFontInfo (win, font_id, 6)  -- avg width
  WindowFont (win, font_id_ul, font_name, font_size, false, false, true, false, 0, 49)  -- normal

  if GetVariable ("enabled") == "false" then
    ColourNote ("yellow", "", "Warning: Plugin " .. GetPluginName ().. " is currently disabled.")
    check (EnablePlugin(GetPluginID (), false))
    return
  end -- they didn't enable us last time
  
  assert (loadstring (GetVariable ("expanded") or "")) ()
  
  OnPluginEnable ()  -- do initialization stuff
  
end -- OnPluginInstall

function OnPluginEnable ()
 
  make_helper_window ()
  
end -- OnPluginEnable

function OnPluginDisable ()

  WindowShow (win, false)
  
end -- OnPluginDisable
  
function OnPluginSaveState ()
  SetVariable ("enabled", tostring (GetPluginInfo (GetPluginID (), 17)))
  
  movewindow.save_state (win)

 SetVariable ("expanded", 
               "expanded = " .. serialize.save_simple (expanded))
                 
end -- OnPluginSaveState