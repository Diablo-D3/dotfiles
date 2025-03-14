# On font sizes...

## Historical size

Kids these days use font sizes that are too small, historically.

The DEC VT100 (from 1978) is what most people consider the grandfather of all modern terminals because it was the first terminal to have a 80x24 layout with ANSI control codes (wasn't the first that did either feature by itself). It also supported a 132 wide mode, but with far less rows; most people didn't use 132 because the font was rendered condensed and was difficult to read.

[The specs](https://archive.org/details/bitsavers_decterminaT100TechnicalManualJul82_24218672/page/n19/mode/2up?view=theater) lists a 12" CRT, but an "active display size" of 8" x 5" (or 9.43" diagonally); photographs of the VT100 prove this to be correct. [According to this guy](https://www.pcjs.org/machines/dec/vt100/rom/) and [this guy](https://www.masswerk.at/nowgobang/2019/dec-crt-typography), it's a 7x9 font that is rendered with "dot stretching" to produce an 8x9 font that is rendered into 10x10 cells onto a 800x240 screen, then line doubled to 800x480, making the final character size 10x20.

Fast-forward to the modern day: the most common desktop monitor size is a 24" 1080p (or 20.9" wide and 11.8" tall); keeping approximate apparent size the same...

```math
80 / 8 * 20.9 = 209 cols
1920 / 209 = 9.19 pixels wide
24 / 5 * 11.8 = 56.64 lines
1080 / 56.64 = 19.06 pixels high
```

... rounding up the character size a little to get integers everywhere, gives us a 10x20 font and a 192x54 terminal. The DPI of the VT100 and my monitor are almost identical, thus leading to the same font size.

MDA/CGA/EGA/VGA monitors that were 12-14" would be slightly lower resolution (ex: 9x14 character size at 720x350, producing a 80x25 terminal), and using the same approximate math, it would have an apparent size of closer to 12x30 on 160x36 terminal.

[int10h.org](https://int10h.org/oldschool-pc-fonts/fontlist/) maintains a library of old bitmap fonts from old machines.

## Sizes tested in Alacritty and WezTerm

**Note**: Alacritty and Wezterm do not agree on cell size (I don't think any terminal ever will). During my testing, Alacritty needs `font.offset.x = 1` and/or `font.offset.y = 1` to match Wez's spacing.

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

- **Anonymous Pro**: Has bitmaps for 7-10 points, requires grayscale AA if you use them
- **Bitstream Vera Mono**: Exceptionally well hinted, all descendants removed hinting, replaced with ttfautohint.
- **Input**: Highly customizable, and is hand hinted for light, regular, medium, and bold.
- **Iosevka**: One of the best fonts ever produced, and highly customizable, with a huge array of glyphs. One of my favorites, easily in my top 3.
- **Monoid**: Unparalleled sharpness at exactly one size: 12px/9pt.

### Apparent width/height, sorted from widest to tallest

| Name                | Points | Layout | Points | Layout |
| ------------------- | -----: | ------ | -----: | ------ |
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

I looked for size(s) that glyphs are easily discernable and have no excessive fringing or misshapen glyph stems. Tested using both DirectWrite (via Alacritty) and Freetype (using Wezterm, using default "Normal hinting /w gresycale AA"; "Light" hinting makes Freetype much more sloppier and blurrier, much like OSX).

_Note:_ Higher _or_ lower than optimal become increasingly fuzzier. Some fonts are just ugly and hard to read at some sizes. Some are ugly at _any_ size.

Sorted by smallest legible size, and if multiple styles, by best scoring width/weight (in italic).

| Name                | Variant/Width   | Weight         | Pixels |   Layout |
| ------------------- | --------------- | -------------- | -----: | -------: |
| Anonymous Pro       |                 | Regular        |     12 |   320x98 |
| Terminus TTF        |                 | Regular        |      9 |   320x83 |
| Cascadia Code       |                 | ExtraLight     |     25 |   128x36 |
|                     |                 | Light          |     17 |   192x54 |
|                     |                 | _Regular_      |   _11_ | _320x83_ |
| Input Mono          | Normal          | Thin/250       |     16 |   192x54 |
|                     | Normal          | ExtraLight/275 |     16 |   192x54 |
|                     | Normal          | Light          |     15 |   192x60 |
|                     | Normal          | Regular        |     11 |   274x77 |
|                     | Normal          | Medium         |     13 |   240x67 |
|                     | Narrow          | Thin/250       |     16 |   192x54 |
|                     | Narrow          | ExtraLight/275 |     16 |   192x54 |
|                     | Narrow          | Regular        |     11 |   274x77 |
|                     | Narrow          | Medium         |     13 |   240x67 |
|                     | Condensed       | Thin/250       |     16 |   213x54 |
|                     | Condensed       | ExtraLight/275 |     16 |   213x54 |
|                     | Condensed       | Regular        |     11 |   320x77 |
|                     | Condensed       | Medium         |     13 |   274x67 |
|                     | Compressed      | Thin/250       |     16 |   213x54 |
|                     | Compressed      | ExtraLight/275 |     16 |   213x54 |
|                     | _Compressed_    | _Regular_      |   _11_ | _320x77_ |
|                     | Compressed      | Medium         |     13 |   274x67 |
| Iosevka             | Normal          | Thin           |     29 |   128x29 |
|                     | Normal          | ExtraLight     |     26 |   147x32 |
|                     | Normal          | Light          |     17 |   213x49 |
|                     | Normal          | Regular        |     13 |   274x63 |
|                     | _Normal_        | _Medium_       |   _11_ | _320x77_ |
|                     | Extended        | Thin           |     29 |   112x29 |
|                     | Extended        | ExtraLight     |     26 |   120x32 |
|                     | Extended        | Light          |     17 |   192x49 |
|                     | Extended        | Regular        |     13 |   240x63 |
|                     | Extended        | Medium         |     11 |   274x77 |
| Mplus               | Code 50         | Thin           |     26 |   147x28 |
|                     | Code 50         | ExtraLight     |     30 |   128x24 |
|                     | Code 50         | Light          |     22 |   174x33 |
|                     | Code 50         | Regular        |     14 |   274x51 |
|                     | Code 50         | Medium         |     11 |   320x67 |
|                     | Code Latin 50   | Thin           |     26 |   147x32 |
|                     | Code Latin 50   | ExtraLight     |     30 |   128x28 |
|                     | Code Latin 50   | Light          |     22 |   174x38 |
|                     | Code Latin 50   | Regular        |     14 |   274x60 |
|                     | _Code Latin 50_ | _Medium_       |   _11_ | _320x77_ |
|                     | Code 60         | Thin           |     26 |   120x28 |
|                     | Code 60         | ExtraLight     |     30 |   106x24 |
|                     | Code 60         | Light          |     22 |   147x33 |
|                     | Code 60         | Regular        |     14 |   240x51 |
|                     | Code 60         | Medium         |     11 |   274x67 |
|                     | Code Latin 60   | Thin           |     26 |   120x32 |
|                     | Code Latin 60   | ExtraLight     |     30 |   106x28 |
|                     | Code Latin 60   | Light          |     22 |   147x38 |
|                     | Code Latin 60   | Regular        |     14 |   240x60 |
|                     | Code Latin 60   | Medium         |     11 |   274x77 |
| JetBrains Mono      |                 | Thin           |     22 |   147x36 |
|                     |                 | ExtraLight     |     16 |   192x49 |
|                     |                 | Light          |     13 |   240x60 |
|                     |                 | Regular        |     12 |   274x67 |
|                     |                 | _Medium_       |   _11_ | _320x72_ |
| Hack                |                 | Regular        |     12 |   274x83 |
| Fira Code           |                 | Regular        |     13 |   240x67 |
|                     |                 | Retina         |     12 |   274x72 |
|                     |                 | _Medium_       |   _11_ | _274x77_ |
| Fira Mono           |                 | Regular        |     14 |   240x63 |
|                     |                 | _Medium_       |   _11_ | _274x77_ |
| Sudo                |                 | Light          |     20 |   213x54 |
|                     |                 | Regular        |     17 |   274x63 |
|                     |                 | _Medium_       |   _15_ | _274x72_ |
| IBM Plex Mono       |                 | Thin           |     32 |   101x25 |
|                     |                 | ExtraLight     |     22 |   147x37 |
|                     |                 | Light          |     21 |   147x38 |
|                     |                 | Regular        |     14 |   240x56 |
|                     |                 | _Medium_       |   _11_ | _274x72_ |
| Consolas            |                 | Regular        |     13 |   274x67 |
| Lucida Console      |                 | Regular        |     13 |   240x83 |
| Berkeley Mono       |                 | Regular        |     13 |   240x67 |
| Monoid              |                 | Regular        |     12 |   240x67 |
| Source Code Pro     |                 | ExtraLight     |     36 |    87x23 |
|                     |                 | Light          |     27 |   120x31 |
|                     |                 | Regular        |     16 |   192x51 |
|                     |                 | _Medium_       |   _14_ | _240x60_ |
| Hasklig             |                 | ExtraLight     |     36 |    87x23 |
|                     |                 | Light          |     27 |   120x31 |
|                     |                 | Regular        |     16 |   192x51 |
|                     |                 | _Medium_       |   _14_ | _240x60_ |
| Victor Mono         |                 | Regular        |     17 |   213x45 |
|                     |                 | _Medium_       |   _14_ | _240x54_ |
| Monaspace           | Normal          | Regular        |     23 |   137x38 |
|                     | _Normal_        | _Medium_       |   _15_ | _213x60_ |
|                     | Semi-Wide       | Regular        |     14 |   192x63 |
|                     | Semi-Wide       | Medium         |     14 |   192x63 |
|                     | Wide            | Regular        |     16 |   160x56 |
|                     | Wide            | Medium         |     14 |   174x63 |
| Bitstream Vera Mono |                 | Regular/Roman  |     15 |   213x56 |
| Courier New         |                 | Regular        |     18 |   174x51 |
| Luculent            |                 | Regular        |     20 |   174x41 |
| JuliaMono           |                 | Regular        |     23 |   137x40 |
|                     |                 | _Medium_       |   _20_ | _160x45_ |
| Inconsolata         | Normal          | Regular        |     27 |   137x38 |
|                     | _Normal_        | _Medium_       |     24 | _160x41_ |
|                     | Ultra Expanded  | Regular        |     22 |    87x47 |
|                     | Ultra Expanded  | Medium         |     22 |    87x47 |
|                     | Extra Expanded  | Regular        |     24 |   106x41 |
|                     | Extra Expanded  | Medium         |     24 |   106x41 |
|                     | Expanded        | Regular        |     27 |   120x38 |
|                     | Expanded        | Medium         |     24 |   137x41 |
|                     | Semi Expanded   | Regular        |     24 |   147x41 |
|                     | Semi Expanded   | Medium         |     24 |   147x41 |
|                     | Semi Condensed  | Regular        |     32 |   137x32 |
|                     | Semi Condensed  | Medium         |     29 |   147x34 |
|                     | Condensed       | Regular        |     31 |   160x32 |
|                     | Condensed       | Medium         |     30 |   160x33 |
|                     | Extra Condensed | Regular        |     32 |   174x32 |
|                     | Extra Condensed | Medium         |     30 |   174x33 |
|                     | Ultra Condensed | Regular        |     38 |   192x27 |
|                     | Ultra Condensed | Medium         |     37 |   213x27 |
| Cousine             |                 | Normal         |     22 |   147x43 |
| MonoLisa            |                 | Regular        |     20 |   147x38 |
