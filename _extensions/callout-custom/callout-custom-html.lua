local h2 = pandoc.Header(2, "Additional Resources")
-- local div_callout = pandoc.RawBlock ( 'html', 
local html_header_begin = "<div class='callout-header d-flex align-content-center'>"
local html_title = '<div class="callout-title-container flex-fill">Callout title - tip</div>'
local html_icon = '<div class="callout-icon-container"><i class="callout-icon"></i></div>'
local html_header_end = '</div>'

local div_header = pandoc.RawBlock ( 'html', html_header_begin .. html_icon .. html_title .. html_header_end )

function Div(el)
  if quarto.doc.isFormat("html") then
    if el.classes:includes('callout-custom') then
	  quarto.log.output ( 'html-callout-custom.lua - html' )
	  -- retrieve the title
	  
	  
      local content = el.content
	  quarto.log.output ( content )
      -- table.insert(content, 1, h2)
	  table.insert(content, 1, div_header)
      return pandoc.Div(
        content,
        {class="callout callout-style-default callout-tip callout-titled", collapse='true'}
      )
    end
  end
  
  -- if quarto.doc.isFormat("revealjs") : cf revealjs-callout-custom.lua

end 