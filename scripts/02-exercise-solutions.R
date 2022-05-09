##############################
##### Exercise solutions #####
##############################

# Last edited: 09/05/22
# Description: Solutions to the tutorial exercises.

#----- Packages
require("tidyverse")
require("MetBrewer")
require("cowplot")

#----- Code
source("scripts/00-plot-setup.R")

#----- Data
data(iris)

#----- Exercise 1: The Grammar of Graphics
# Now that you have an idea of what data, aesthetic mappings, and geometric
# objects are in the context of the grammar of graphics, why don’t you give it a
# try? Can you identify the different features of the plot below? If you wish to
# spend longer on this exercise, try doing the same for the figures in the last
# research article you read. Alternatively, head over to your favourite news
# website and see if you can find some data visualisations there to practise on.
# Articles on the climate emergency, demographics, and elections are all good
# places to look.

# The data is iris.
# The aesthetic mappings are:
#   - petal length mapped onto the x-axis
#   - iris species mapped onto colour
# The geometric objects are:
#   - scatter plot
#   - regression line
# Note that species is *not* mapped to colour in the regression line.

#----- Exercise 2: Ignoring aesthetics
# In the code below, change `colour` to `fill`. What happens and why do you
# think it happens? Can you add, remove, or change some of the aesthetic
# mappings to produce an error message?
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) +
  geom_point()

# Changing colour to fill turns the points black. Fill is ignored as currently
# the geom doesn't have any area to fill.
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, fill = Species)) +
  geom_point()

# Some shapes do accept fill.
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, fill = Species)) +
  geom_point(shape = 21)

# To induce an error message, we must omit a required aesthetic, e.g. y.
ggplot(iris, aes(x = Petal.Length, colour = Species)) +
  geom_point()

#----- Exercise 3: Layering
# Another way to make sure background layers are visible is by making foreground
# layers transparent. Can you edit just the last line of the code above
# (reordering geoms or adding new ones is not allowed) to make this picture?
ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(width = .15) +
  geom_violin(alpha = .5)

#----- Exercise 4: Shared and private aesthetics
# I'm not claiming it's a good idea, but can you make the plot below?
ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_violin(aes(colour = Species)) +
  geom_boxplot(aes(fill = Species), width = .15)

#----- Exercise 5: Geoms and stats
# You might be forgiven if you assume that `geom_line()` by default fits a
# regression line to the data. However, it does something rather different. What
# is its default stat and how does it explain the figure you see? When might you
# want to use `geom_line()`?

# The default stat of `geom_line()` is `stat = "identity"`, so in the plot
# individual data points are connected through lines. This is useful when we
# plot trends, e.g. in a time series plot.
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_line()

#----- Exercise 6: Stat parameters
# We can also set stat parameters within alternative geoms. Can you make the
# figure below using `geom_line()`?
ggplot(iris, aes(x = Petal.Length)) +
  geom_line(stat = "bin", breaks = 0:8)

#----- Exercise 7: Regression lines
# We are slowly working towards making the figures from the start of this
# tutorial. Can you make the plot below? The shade of grey used instead of the
# default blue for the fitted line is `"grey70"`. 
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species))

# As an additional challenge, can you also change the colour of the confidence
# interval band?
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_smooth(method = "lm", colour = "grey70", fill = "gold1") +
  geom_point(aes(colour = Species))

#----- Exercise 8: Positions
# Going back to our iris dataset, can you make the figure below? How do the
# column heights differ from earlier histograms we’ve made? 

# The columns around Petal.Length = 5 are lower, as they are no longer stacked
# but instead overlap.
ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  geom_histogram(alpha = 0.5, position = "identity")

# As an additional exercise, can you see a difference between using
# `geom_line(stat = "bin")` and `geom_freqpoly()`? Hint: try adding colour to
# your plots.

# Unlike `geom_histogram()`, both `geom_line()` and `geom_freqpoly()` have `stat
# = "identity"`.
ggplot(iris, aes(x = Petal.Length, colour = Species)) +
  geom_line(stat = "bin")
ggplot(iris, aes(x = Petal.Length, colour = Species)) +
  geom_freqpoly()

#----- Exercise 9: Facets
# In the examples above scales are fixed, meaning facets share the same x- and
# y-axis ranges. However, you can change this by setting the `scales` parameter
# of the facet to `"free"`. Can you make the figure below? More importantly,
# _should_ you make figures like it? The confidence intervals for _I. setosa_
# and _I. virginica_ appear to be similar, and much wider than the confidence
# interval for _I. versicolor_. Is this true?

# Making the scales free might inadvertently confuse the reader that the Iris
# setosa and Iris virginica are equally spread out, while looking at the larger
# plot they clearly are not.
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  facet_wrap(~Species, scales = "free") +
  geom_point(aes(colour = Species)) +
  geom_smooth(method = "lm")

#----- Exercise 10: Scales
# Can you make the figure below? To get these exact colours, I used the Java
# palette from the [`MetBrewer`](https://github.com/BlakeRMills/MetBrewer)
# package. For now you can just copy them from here:
species_labs <- c("setosa" = "I. setosa", 
                  "versicolor" = "I. versicolor", 
                  "virginica" = "I. virginica")
species_cols <- c("setosa" = "#663171", 
                  "versicolor" = "#ea7428", 
                  "virginica" = "#0c7156")

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species)) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Petal width (cm)", breaks = 0:3) +
  scale_colour_manual("Species", values = species_cols, labels = species_labs)

#----- Exercise 11: Everything but the theme
# Can you make the two figures below?
ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  ggtitle("Iris petal length differs by species") +
  geom_histogram(position = "identity", alpha = 0.7, binwidth = .25) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Count") +
  scale_fill_manual("Species", values = species_cols, labels = species_labs)

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  ggtitle("Iris petal length and width are correlated") +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species)) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Petal width (cm)", breaks = 0:3) +
  scale_colour_manual("Species", values = species_cols, labels = species_labs)

#----- Exercise 12: Everything with the theme
# Just for completion’s sake, you should now be able to recreate the two plots
# from the start exactly. This should only take one extra line of code to each
# plot from **Exercise 11**. I always find this part so satisfying!
ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  ggtitle("Iris petal length differs by species") +
  theme_lvb +
  geom_histogram(position = "identity", alpha = 0.7, binwidth = .25) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Count") +
  scale_fill_manual("Species", values = species_cols, labels = species_labs)

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  ggtitle("Iris petal length and width are correlated") +
  theme_lvb +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species)) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Petal width (cm)", breaks = 0:3) +
  scale_colour_manual("Species", values = species_cols, labels = species_labs)

#----- Exercise 13: The final challenge
# This is it! Last one! Can you make the figure below?
p1 <- ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  theme_lvb + theme(legend.position = "none") +
  geom_histogram(position = "identity", alpha = 0.7, binwidth = .25) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Count") +
  scale_fill_manual("Species", values = species_cols, labels = species_labs)
p2 <- ggplot(iris, aes(x = Petal.Width, fill = Species)) +
  theme_lvb + theme(legend.position = "none") +
  geom_histogram(position = "identity", alpha = 0.7, binwidth = .25) +
  scale_x_continuous("Petal width (cm)", breaks = 0:3) +
  scale_y_continuous("Count") +
  scale_fill_manual("Species", values = species_cols, labels = species_labs)
q <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  theme_lvb +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species)) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Petal width (cm)", breaks = 0:3) +
  scale_colour_manual("Species", values = species_cols, labels = species_labs)

p <- plot_grid(p1, p2, ncol = 1, labels = c("B", "C"), label_size = 11)
plot_grid(q, p, nrow =1, labels = c("A", ""), label_size = 11)
