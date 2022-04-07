
#----- Packages
require("tidyverse")
require("lubridate")
require("MetBrewer")

#----- Code
# TODO: move theme
source("~/Code/aux/plot-setup.R")

#----- Data
df <- read_csv("runs.csv")[1:33, ]
df$Date <- parse_date_time(df$Date, orders = "dmy")
df$Weekend <- weekdays(df$Date) %in% c("Saturday", "Sunday")

#----- Plot
wnd_cols <- met.brewer("Java", 2)
wnd_labs <- c("TRUE" = "Weekend", "FALSE" = "Weekday")

p <- ggplot(df, aes(x = Date, y = Length, colour = Weekend)) +
  theme_lvb +
  ggtitle("Lyuba's runs in 2022") +
  geom_point(size = 2) +
  scale_x_datetime("Date", date_breaks = "months" , date_labels = "%b-%y", limits = c(as.POSIXct("2022-01-01"), NA)) +
  scale_y_continuous("Distance (km)", limits = c(0, 22), breaks = seq(0, 20, 5)) +
  scale_colour_manual("", values = wnd_cols, labels = wnd_labs)
plot_save(p, "runs_example.jpg", size = 0.5)

q <- ggplot(df, aes(x = Weekend, y = Length, fill = Weekend)) +
  theme_lvb + theme(legend.position = "none") +
  ggtitle("Lyuba's runs in 2022 (2)") +
  geom_boxplot() +
  scale_x_discrete("", labels = wnd_labs) +
  scale_y_continuous("Distance (km)", limits = c(0, 22), breaks = seq(0, 20, 5)) +
  scale_fill_manual("", values = wnd_cols, labels = wnd_labs)
q
plot_save(q, "runs_exercise.jpg", size = 0.5)
