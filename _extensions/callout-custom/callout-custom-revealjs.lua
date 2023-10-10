-- this script is for html - revealjs
-- html-custom-callout.lua is for html different from revealjs.

local h2 = pandoc.Header(2, "Additional Resources")
-- local div_callout = pandoc.RawBlock ( 'html', 
local revealjs_header_begin = '<div class="callout-title">'
local revealjs_icon = '<div class="callout-icon-container"><i class="callout-icon"></i></div>'
local revealjs_title_begin = '<p><strong>'
local revealjs_title_end = '</strong></p>'
local revealjs_header_end = '</div>'



function Div(el)
  -- isFormat("html") true when format: html or revealjs
  if quarto.doc.isFormat("html") then
    if el.classes:includes('callout-custom') then
	  quarto.log.output ( 'callout-custom.lua - revealjs' )
	  
	  -- retrieve the title from header ####
	  -- ABANDONNED: title in header make latex crash !
	  -- walk through the sub-elements inside the element div with class callout-case
	  -- local walk = pandoc.walk_block(el, {
	    -- Header = function(subel)
		  -- str_header = pandoc.utils.stringify(subel.content)
		  -- quarto.log.output ( 'callout-custom.lua - revealjs: ' .. str_header )
		  -- -- quarto.log.output ( subel.content )
		  -- -- local walk = pandoc.walk_block(subel, {
		  -- -- Str = function(strel)
		  -- --  quarto.log.output ( 'callout-custom.lua - revealjs - strel : ' )
		  -- --  quarto.log.output ( strel.text )
		  -- -- end
		  -- -- })
  	    -- end
	  -- })
	  
	  -- retrieve the title from data-latex
	  local str_title = ''
	  local div_attr = el.attributes['data-latex']
	  if ( div_attr ) then
	    str_title = pandoc.utils.stringify(div_attr)
		-- remove the { and } compulsory because of latex treatement of args
		len_title = #str_title
		first_char = string.sub ( str_title, 1, 1)
		last_char = string.sub ( str_title, len_title, len_title)
		refactored_str_title = string.sub ( str_title, 2, len_title - 1)
		
		if ( first_char == '{' ) and ( last_char == '}' ) then
			quarto.log.output ( 'callout-custom.lua - revealjs' .. refactored_str_title )		
		else
			refactored_str_title = "ADD '{' " .. str_title .. " and '}' for compatibility with beamer"
			-- Example of error raised by Latex if missing { or }
			-- ERROR:
			-- compilation failed- missing packages (automatic installed disabled)
			-- Argument of \frame has an extra }.
			-- <inserted text>
                -- \par
			-- l.191 ...in{callout-case}Titre dans data-latex 12}
		end
	  else
	    quarto.log.output ( 'callout-custom.lua - revealjs - div_attr is nil' )
	  end
	  
	  
	  local div_header = pandoc.RawBlock ( 'html', revealjs_header_begin .. revealjs_icon .. revealjs_title_begin .. refactored_str_title .. revealjs_title_end .. revealjs_header_end )
	  
	  
      local content = el.content
	  -- quarto.log.output ( content )
	  table.insert(content, 1, div_header)
      return pandoc.Div(
        content,
        -- {class="callout callout-style-default callout-tip callout-titled", collapse='true'}
		{class="callout callout-style-default callout-tip callout-titled"}
      )
    end
  end
end 