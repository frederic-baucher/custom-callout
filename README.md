
# Need
Have the syntax in Markdown (compatible with revealjs, beamer and columns) to manage customized callout (nice box).

# Installation
- install the extension
> quarto add frederic-baucher/callout-custom

- add the following to _quarto.yml
```yaml
format:
  revealjs:
    filters: 
      - _extensions/frederic-baucher/callout-custom/revealjs-callout-custom.lua
  beamer:
    include-in-header:
      file: _extensions/frederic-baucher/callout-custom/callout-custom.tex
```

## Create a custom callout extension
First, create a fork of this repo.
Suppose we create the example callout. Then add 3 files to manage the callout in the 3 corresponding format
- callout-example-html.lua
- callout-example-revealjs.lua
- callout-example.tex

# ADR

## Alternatives selected
## Syntax A + lua + tex (revealjs:OK, beamer:OK)
```md
:::{.callout-example data-latex="{a nice title for callout}"}
* Know how to make your own callouts.
* Be able to mess with some SCSS/CSS styling.
:::
```


## Alternatives rejected
### Syntax A + tex (revealjs:KO, beamer:OK)
```md
:::{.callout-example data-latex="{a nice title for callout}"}
* Know how to make your own callouts.
* Be able to mess with some SCSS/CSS styling.
:::
```

### Syntax B (revealjs:OK, beamer:KO)
Syntax B : title given by first header after fenced div
```md
:::{.callout-example data-latex=""}
### a nice title for callout
* Know how to make your own callouts.
* Be able to mess with some SCSS/CSS styling.
:::
```

### Syntax C + scss + tex (revealjs:OK, beamer:BUG)
- Should be OK in beamer but the tags are mixed because a bug in latex ?

#### excerpt from example.yml
```md
:::{.callout-example data-latex=""}
::::{.callout-example-header data-latex=""}
a nice title for callout
::::
* Know how to make your own callouts.
* Be able to mess with some SCSS/CSS styling.
:::
```

#### _quarto.yml
```yaml
format:
  html:
    theme:
      - cosmo
	  - diy/callout-example.scss
```

# Tests
> quarto render example.qmd
> quarto preview example.qmd


# Resources
- https://stackoverflow.com/questions/73984001/change-default-behavior-of-callout-blocks-in-quarto: custom callout with lua
- https://tex.stackexchange.com/questions/525924/with-pandoc-how-to-apply-a-style-to-a-fenced-div-block
  **You need that data-latex="" in there too to get it to work.**
- https://github.com/quarto-dev/quarto-cli/discussions/4755
- https://groups.google.com/g/pandoc-discuss/c/PkF04EkUqzQ
```lua
function latex(s)
return pandoc.RawBlock('latex', s)
end

function Div(el)
if el.classes[1] == 'solution' then
return { latex('\begin{solution}'), el.content, latex('\end{solution}') }
end
end
```

- https://bookdown.org/yihui/rmarkdown-cookbook/custom-blocks.html
```yaml
---
output:
  html_document:
    css: style.css
  pdf_document:
    includes:
      in_header: preamble.tex
---
```
- https://github.com/cagix/pandoc-lecture
