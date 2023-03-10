# QR code shortcode for Quarto 

This Quarto shortcode extension uses pure Lua to generate QR codes for all formats (`html`, `revealjs`, `pdf`, `docx`, `pptx`, `beamer`, etc.). There are no external dependencies or online requirements.

## Installing

```bash
quarto add ryanraaum/quarto-rrqrcode
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

```
{{< rrqr https://quarto.org >}}
```

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="quarto-org-qrcode-light.png">
  <source media="(prefers-color-scheme: light)" srcset="quarto-org-qrcode.png">
  <img alt="Shows a QR code linking to quarto.org" src="quarto-org-qrcode.png">
</picture>

## Example

An example is included in the repository: [example.qmd](example.qmd). View this [example rendered into HTML](https://htmlpreview.github.io/?https://github.com/ryanraaum/quarto-rrqrcode/blob/main/example.html).

## Acknowledgements and Licenses

All new code in this repository is made available under an MIT 
license. 
The core functionality in this shortcode extension is enabled by 
libraries and utilities created by others that are available for 
reuse under the following licenses.

- `bitops.lua` is from [AlberTajuelo/bitop-lua](https://github.com/AlberTajuelo/bitop-lua), made available under the MIT License (`LICENSE-bitop`). No modifications were made to the originally distributed code.
- `pngencoder.lua` is from [wyozi/lua-pngencoder](https://github.com/wyozi/lua-pngencoder), made available under the LGPL-3.0 License (`LICENSE-pngencoder`). The only modification made to the originally distributed code was to import the `bitops.lua` module (above) for bit operations.
- `qrencode.lua` is from [speedata/luaqrcode](https://github.com/speedata/luaqrcode), made available under the MIT License (`LICENSE-qrencode`). The pixel values for the positioning patterns and alignment pattern were modified to enable differential coloring of those elements; some other minor modifications were made to meet `luacheck` standards.

Many thanks to these authors and organizations!
