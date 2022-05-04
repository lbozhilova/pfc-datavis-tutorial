###########################
##### My ggplot theme #####
###########################

# Last edited: 04/05/22
# Description: A custom ggplot theme I frequently use.

#----- Packages
require("tidyverse")

#----- Theme
theme_lvb <- theme_minimal(base_size = 10) +
  theme(
    text = element_text(color = "gray20"),
    # Legend
    legend.position = "top",
    legend.direction = "horizontal",
    legend.justification = 0.1,
    legend.title = element_blank(),
    # Axes
    axis.text = element_text(face = "italic"),
    axis.title.x = element_text(vjust = -1),        
    axis.title.y = element_text(vjust = 2),
    axis.ticks.x = element_line(color = "gray70", size = 0.2),
    axis.ticks.y = element_line(color = "gray70", size = 0.2),
    axis.line = element_line(color = "gray40", size = 0.3),
    axis.line.y = element_line(color = "gray40", size = 0.3),
    # Panel
    panel.grid.major = element_line(color = "gray70", size = 0.2),
    panel.grid.major.x = element_line(color = "gray70", size = 0.2))

#----- Save figure
plot_save <- function(p, filename, size = 1, ar = 1, dev = "jpeg"){
  allowed_devs <- c("eps", "ps", "tex", "pdf", "jpeg", 
                    "tiff", "png", "bmp", "svg")
  if (!(dev %in% allowed_devs))
    stop("Invalid device.")
  if (dev != "jpeg" & !str_detect(filename, paste0("\\.", dev)))
    filename <- paste0(filename, ".", dev)
  if (dev == "jpeg" & !str_detect(filename, "\\.jpg|\\.jpeg"))
    filename <- paste0(filename, ".jpg")
  w <- round(180 * size)
  h <- w/ar
  ggsave(filename = filename,
         plot = p,
         width = w,
         height = h,
         units = "mm",
         device = dev)
}
