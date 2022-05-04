###########################
##### Example figures #####
###########################

# Last edited: 04/05/22
# Description: Figures used at the beginning of the tutorial.

#----- Packages
require("tidyverse")
require("MetBrewer")
require("cowplot")
require("ggrepel")

#----- Code
source("scripts/00-plot-setup.R")

#----- Data
data(iris)

#----- Plot
iris_cols <- met.brewer("Java", 3)
names(iris_cols) <- unique(iris$Species)
iris_labs <- paste("I. ", unique(iris$Species))
names(iris_labs) <- unique(iris$Species)

p <- ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  theme_lvb +
  ggtitle("Iris petal length differs by species") +
  geom_histogram(position = "identity", alpha = 0.7, binwidth = .25) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Count") +
  scale_fill_manual("Species", values = iris_cols, labels = iris_labs)
p

q <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  theme_lvb +
  ggtitle("Iris petal length and width are correlated") +
  geom_smooth(method = "lm", colour = "grey70") +
  geom_point(aes(colour = Species)) +
  scale_x_continuous("Petal length (cm)", breaks = 0:7) +
  scale_y_continuous("Petal width (cm)", breaks = 0:3) +
  scale_colour_manual("Species", values = iris_cols, labels = iris_labs)
q

p1 <- ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  geom_histogram()
plot_grid(p, p1)

plot_save(p, "figures/ex_iris_1.jpg", size = .5)
plot_save(q, "figures/ex_iris_2.jpg", size = .5)
plot_save(plot_grid(p, p1), "figures/ex_iris_compare.jpg", size = 1, ar = 2)

