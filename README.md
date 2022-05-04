# Figure prototyping with `ggplot2`

This `ggplot2` tutorial was originally written for the [MitoCAMB](https://www-neurosciences.medschl.cam.ac.uk/mitocamb/) 2022 Away Day. It was later adapted as a workshop for the [MRC MBU](https://www.mrc-mbu.cam.ac.uk/) Postdoctoral Society. You can view and HTML version of the tutorial [here](https://lbozhilova.github.io/pfc-datavis-tutorial/).

## Prerequisites and software requirements

The tutorial assumes some familiarity (but crucially not expertise) with base `R`. You should have `R` and `RStudio` installed and updated. The tutorial was written in `R 4.1.3`, and uses the `tidyverse` and `cowplot` packages.

## Installing and updating software

To install `R`, do the following, in order.
1. Head over to CRAN and download and install `R` if you haven’t.
2. Afterwards, go to the RStudio website to download and install RStudio. There are a few options, go for the free RStudio Desktop.
3. Finally, open RStudio and run these two lines of code in the console (bottom left corner if you haven’t used RStudio before):
```
	install.packages(“tidyverse”)
	install.packages(“cowplot”)
```

If you have `R` installed but your current version is `R 4.1.0` or older, you will need to update it. If you’re on a Mac or Linux, simply install the newest `R` version using the instructions above. If you’re on Windows, open RGui and run these three lines of code:
```
	install.packages(“installr”)
	require(“installr”)
	updateR()
```
Then click through pop-up boxes and things.

You can update RStudio through the menu: **Help > Check for Updates**. You can update packages by reinstalling them with the instructions above.
