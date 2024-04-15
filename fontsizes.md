# On font sizes...
## Historical size
Kids these days use font sizes that are too small, historically.

The DEC VT100 (from 1978) is what most people consider the grandfather of all modern terminals because it was the first terminal to have a 80x24 layout with ANSI control codes (wasn't the first that did either feature by itself). It also supported a 132 wide mode, but with far less rows; most people didn't use 132 because the font was rendered condensed and was difficult to read.

[The specs](https://archive.org/details/bitsavers_decterminaT100TechnicalManualJul82_24218672/page/n19/mode/2up?view=theater) lists a 12" CRT, but an "active display size" of 8" x 5" (or 9.43" diagonally); photographs of the VT100 prove this to be correct. [According to this guy](https://www.pcjs.org/machines/dec/vt100/rom/) and [this guy](https://www.masswerk.at/nowgobang/2019/dec-crt-typography), it's a 7x9 font that is rendered with "dot stretching" to produce an 8x9 font that is rendered into 10x10 cells onto a 800x240 screen, then line doubled to 800x480, making the final character size 10x20.

Fast-forward to the modern day: the most common desktop monitor size is a 24" 1080p (or 20.9" wide and 11.8" tall); keeping approximate apparent size the same...

```
80 / 8 * 20.9 = 209 cols
1920 / 209 = 9.19 pixels wide
24 / 5 * 11.8 = 56.64 lines
1080 / 56.64 = 19.06 pixels high
```

... rounding up the character size a little to get integers everywhere, gives us a 10x20 font and a 192x54 terminal. The DPI of the VT100 and my monitor are almost identical, thus leading to the same font size.

MDA/CGA/EGA/VGA monitors that were 12-14" would be slightly lower resolution (ex: 9x14 character size at 720x350, producing a 80x25 terminal), and using the same approximate math, it would have an apparent size of closer to 12x30 on 160x36 terminal.

[int10h.org](https://int10h.org/oldschool-pc-fonts/fontlist/) maintains a library of old bitmap fonts from old machines.

## Sizes tested in Windows Terminal and Alacritty
**Note**: Microsoft Terminal and Alacritty do not agree on cell size (I don't think any terminal ever will). During my testing, Alacritty needs `font.offset.x = 1` and/or `font.offset.y = 1` to match Terminal's spacing. Terminal now has cell height adjustment, but not width adjustment.

### Fonts tested
| Name                                                                                    | Version Tested | License                            |
| --------------------------------------------------------------------------------------- | -------------- | ---------------------------------- |
| [Anonymous Pro](https://www.marksimonson.com/fonts/view/anonymous-pro)                  | 1.002          | OFL                                |
| [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/)                  | 1.008          | Commercial ($75+)                  |
| [Bitstream Vera Mono](https://en.wikipedia.org/wiki/Bitstream_Vera)                     | 1.10           | Proto-OFL                          |
| [Cascadia](https://github.com/microsoft/cascadia-code)                                  | 2111.01        | OFL                                |
| [Consolas](https://learn.microsoft.com/en-us/typography/font-list/consolas)             | 7.00           | Commercial (Included since Vista)  |
| [Courier New](https://learn.microsoft.com/en-us/typography/font-list/courier-new)       | 6.91           | Commercial (Included since Win3.1) |
| [Fira Mono](http://mozilla.github.io/Fira/)                                             | 3.206          | OFL                                |
| [Fira Code](https://github.com/tonsky/FiraCode)                                         | 6.2            | OFL                                |
| [Hack](https://sourcefoundry.org/hack/)                                                 | 3.003          | MIT                                |
| [Hasklig](https://github.com/i-tu/Hasklig)                                              | 1.2            | OFL                                |
| [IBM Plex Mono](https://github.com/IBM/plex)                                            | 6.2            | OFL                                |
| [Inconsolata](https://levien.com/type/myfonts/inconsolata.html)                         | 2.001          | OFL                                |
| [Input](https://input.djr.com)                                                          | 1.2            | Commercial (Free)                  |
| [Iosevka](https://typeof.net/Iosevka/)                                                  | 27.25          | OFL                                |
| [JetBrains Mono](https://www.jetbrains.com/lp/mono/)                                    | 2.304          | OFL                                |
| [JuliaMono](https://juliamono.netlify.app/)                                             | 0.051          | OFL                                |
| [Lucida Console](https://learn.microsoft.com/en-us/typography/font-list/lucida-console) | 5.01           | Commercial (Included since Win98)  |
| [Luculent](http://eastfarthing.com/luculent/)                                           | 2.0.0          | OFL                                |
| [Monoid](https://larsenwork.com/monoid/)                                                | 0.61           | Dual OFL/MIT                       |
| [MonaLisa](https://www.monolisa.dev/)                                                   | 2.008          | Commercial ($49+)                  |
| [Monaspace](https://monaspace.githubnext.com/)                                          | 1.00           | OFL                                |
| [MPlus](https://mplusfonts.github.io/)                                                  | 2/7/2023       | OFL                                |
| [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/)                       | 2.038          | OFL                                |
| [Sudo](https://www.kutilek.de/sudo-font/)                                               | 0.78           | OFL                                |
| [Terminus TTF](https://files.ax86.net/terminus-ttf/)                                    | 4.49.3         | OFL                                |
| [Victor Mono](https://rubjo.github.io/victor-mono/)                                     | 1.540          | OFL                                |

#### Notes
* **Anonymous Pro**: Has bitmaps for 7-10 points.
* **Bitstream Vera Mono**: Exceptionally well hinted, all descendants removed hinting.
* **Courier New**: Strongly hinted for 27pt(!) and under, becomes very thin.
* **Hack**: Bitstream Vera/Deja Vu family.
* **Input**: Highly customizable, and is hand hinted for light, regular, medium, and bold.
* **Iosevka**: One of the best fonts ever produced, and highly customizable, with a huge array of glyphs. One of my favorites, easily in my top 3.
* **Lucida Console**: Strongly hinted for 12pt and under, becomes very thin.

### Apparent width/height, sorted from widest to tallest
| Name                | Points | Layout | Points | Layout |
| ------------------- | ------:| ------ | ------:| ------ |
| Lucida Console      |     12 | 192x67 |     15 | 160x54 |
| Anonymous Pro       |     14 | 192x56 |     16 | 160x51 |
| Input               |     12 | 192x56 |     14 | 160x49 |
| Monaspace           |     12 | 192x56 |     14 | 160x49 |
| Bitstream Vera Mono |     12 | 192x56 |     15 | 160x47 |
| Hack                |     12 | 192x56 |     15 | 160x47 |
| Berkeley Mono       |     12 | 192x56 |     15 | 160x45 |
| Fira Mono           |     12 | 192x56 |     15 | 160x45 |
| JuliaMono           |     12 | 192x56 |     15 | 160x45 |
| Monoid              |     11 | 192x54 |     13 | 160x47 |
| Cascadia            |     13 | 192x54 |     15 | 160x47 |
| Courier New         |     13 | 192x54 |     15 | 160x45 |
| Iosevka Extended    |     13 | 192x54 |     15 | 160x45 |
| _24" Faux VT100_    |  10x20 | 192x54 |        |        |
| Fira Code           |     12 | 192x54 |     15 | 160x43 |
| Consolas            |     13 | 192x54 |     16 | 160x43 |
| Hasklig             |     12 | 192x54 |     15 | 160x43 |
| Mplus Code Latin 60 |     12 | 192x54 |     15 | 160x43 |
| Inconsolata         |     15 | 192x51 |     18 | 160x43 |
| Source Code Pro     |     12 | 192x54 |     15 | 160x43 |
| IBM Plex Mono       |     12 | 192x51 |     15 | 160x41 |
| JetBrains Mono      |     12 | 192x51 |     15 | 160x41 |
| MonoLisa            |     11 | 192x49 |     14 | 160x41 |
| Sudo                |     17 | 192x47 |     20 | 160x40 |
| Luculent            |     14 | 192x47 |     16 | 160x40 |
| Terminus TTF        |     15 | 192x47 |     18 | 160x39 |
| _24" Faux CGA_      |        |        |  12x30 | 160x36 |
| Mplus Code 60       |     13 | 192x43 |     15 | 160x37 |
| Mplus Code Latin 50 |     15 | 192x43 |     18 | 160x36 |
| Iosevka             |     15 | 192x43 |     18 | 160x36 |
| Victor Mono         |     14 | 192x41 |     16 | 160x36 |
| Mplus Code 50       |     15 | 192x37 |     18 | 160x30 |

### Optimal rendering of common fonts
I looked for the minimum size that glyphs are easily discernable and have no excessive fringing or misshapen glyph stems. Tested using both DirectWrite (via Windows Terminal) and Freetype (using Alacritty); also tested across aliased, greyscale, and subpixel in WT.

Sorted by smallest legible size, and if multiple styles, by best scoring width/weight (in italic).

| Name                | Width/Variant   |   Weight | Pixels |   Layout |
| ------------------- | --------------- | --------:| ------:| --------:|
| Terminus TTF        |                 |  Regular |      9 |   320x83 |
| Mplus               | Code 50         |   Normal |     20 |   192x37 |
|                     | Code 50         |   Medium |     14 |   274x54 |
|                     | Code Latin 50   |   Normal |     20 |   192x43 |
|                     | _Code Latin 50_ | _Medium_ |   _14_ | _274x63_ |
|                     | Code 60         |   Normal |     20 |   160x37 |
|                     | Code 60         |   Medium |     14 |   240x54 |
|                     | Code Latin 60   |   Normal |     20 |   160x43 |
|                     | Code Latin 60   |   Medium |     14 |   240x63 |
| Fira Mono           |                 |   Normal |     18 |   174x49 |
|                     |                 | _Medium_ |   _14_ | _240x63_ |
| Sudo                |                 |   Normal |     23 |   192x47 |
|                     |                 | _Medium_ |   _18_ | _240x60_ |
| IBM Plex            |                 |   Normal |     19 |   174x43 |
|                     |                 | _Medium_ |   _14_ | _240x60_ |
| Input               | Normal          |  Regular |     22 |   137x41 |
|                     | Normal          |   Medium |     15 |   192x60 |
|                     | Narrow          |  Regular |     23 |   137x40 |
|                     | Narrow          |   Medium |     18 |   192x56 |
|                     | Condensed       |  Regular |     24 |   137x37 |
|                     | Condensed       | _Medium_ |   _15_ | _213x60_ |
|                     | Compressed      |  Regular |     26 |   137x34 |
|                     | Compressed      |   Medium |     17 |   213x51 |
| Monaspace           | Normal          |  Regular |     23 |   137x38 |
|                     | Normal          | _Medium_ |   _15_ | _213x60_ |
|                     | Semi-Wide       |  Regular |     14 |   192x63 |
|                     | Semi-Wide       |   Medium |     14 |   192x63 |
|                     | Wide            |  Regular |     16 |   160x56 |
|                     | Wide            |   Medium |     14 |   174x63 |
| Cascadia            |                 |  Regular |     20 |   160x47 |
|                     |                 | _Medium_ |   _16_ | _213x56_ |
| Hasklig             |                 |  Regular |     18 |   174x47 |
|                     |                 | _Medium_ |   _15_ | _213x56_ |
| Source Code Pro     |                 |  Regular |     18 |   174x47 |
|                     |                 | _Medium_ |   _15_ | _213x56_ |
| Bitstream Vera Mono |                 |  Regular |     17 |   192x54 |
| Consolas            |                 |  Regular |     18 |   192x51 |
| Fira Code           |                 |  Regular |     21 |   147x41 |
|                     |                 |   Retina |     19 |   160x47 |
|                     |                 | _Medium_ |   _17_ | _192x51_ |
| Lucida Console      |                 |  Regular |     18 |   174x60 |
| Iosevka             |                 |  Regular |     24 |   160x36 |
|                     |                 | _Medium_ |   _20_ | _192x43_ |
| Luculent            |                 |  Regular |     15 |   174x43 |
| Victor Mono         |                 |  Regular |     24 |   147x31 |
|                     |                 | _Medium_ |   _20_ | _174x38_ |
| Monoid              |                 |  Regular |     18 |   160x45 |
| JuliaMono           |                 |  Regular |     23 |   137x40 |
|                     |                 | _Medium_ |   _20_ | _160x45_ |
| JetBrains Mono      |                 |  Regular |     22 |   147x37 |
|                     |                 | _Medium_ |   _20_ | _160x41_ |
| Inconsolata         | Normal          |  Regular |     27 |   137x38 |
|                     | _Normal_        | _Medium_ |     24 | _160x41_ |
|                     | Ultra Expanded  |  Regular |     22 |    87x47 |
|                     | Ultra Expanded  |   Medium |     22 |    87x47 |
|                     | Extra Expanded  |  Regular |     24 |   106x41 |
|                     | Extra Expanded  |   Medium |     24 |   106x41 |
|                     | Expanded        |  Regular |     27 |   120x38 |
|                     | Expanded        |   Medium |     24 |   137x41 |
|                     | Semi Expanded   |  Regular |     24 |   147x41 |
|                     | Semi Expanded   |   Medium |     24 |   147x41 |
|                     | Semi Condensed  |  Regular |     32 |   137x32 |
|                     | Semi Condensed  |   Medium |     29 |   147x34 |
|                     | Condensed       |  Regular |     31 |   160x32 |
|                     | Condensed       |   Medium |     30 |   160x33 |
|                     | Extra Condensed |  Regular |     32 |   174x32 |
|                     | Extra Condensed |   Medium |     30 |   174x33 |
|                     | Ultra Condensed |  Regular |     38 |   192x27 |
|                     | Ultra Condensed |   Medium |     37 |   213x27 |
| Hack                |                 |  Regular |     21 |   147x45 |
| Cousine             |                 |   Normal |     22 |   147x43 |
| MonoLisa            |                 |  Regular |     20 |   147x38 |
| Berkeley Mono       |                 |  Regular |     18 |   137x37 |
| Anonymous Pro       |                 |  Regular |     27 |   128x40 |
| Courier New         |                 |  Regular |     37 |    87x25 |
