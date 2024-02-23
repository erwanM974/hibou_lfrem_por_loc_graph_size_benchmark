#
# Copyright 2023 Erwan Mahe (github.com/erwanM974)
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#



rm(list=ls())
# ======================================================================
library(ggplot2)
# ======================================================================


# ======================================================================
read_exp_report <- function(file_path) {
  report <- read.table(file=file_path, 
                       header = FALSE, 
                       sep = ";",
                       blank.lines.skip = TRUE, 
                       fill = TRUE)
  
  names(report) <- as.matrix(report[1, ])
  report <- report[-1, ]
  report[] <- lapply(report, function(x) type.convert(as.character(x)))
  #report[] <- lapply(report, function(x) toString(x))
  report
}
# ======================================================================


my_dat <- read_exp_report("results_graph.csv")

print(max(my_dat$trace_length))



print("input data")
print(paste("TOTAL ",    nrow(my_dat)))
print(paste(" ACPT ",    nrow(my_dat[my_dat$trace_kind == "ACPT",])))
print(paste(" PREF ",    nrow(my_dat[my_dat$trace_kind == "PREF",])))
print(paste(" NOIS ",    nrow(my_dat[my_dat$trace_kind == "NOIS",])))
print(paste("  NOIS OK ",nrow(my_dat[my_dat$trace_kind == "NOIS" & my_dat$verdict == "Pass",])))
print(paste("  NOIS KO ",nrow(my_dat[my_dat$trace_kind == "NOIS" & my_dat$verdict == "Fail",])))
print(paste(" SACT ",    nrow(my_dat[my_dat$trace_kind == "SACT",])))
print(paste("  SACT OK ",nrow(my_dat[my_dat$trace_kind == "SACT" & my_dat$verdict == "Pass",])))
print(paste("  SACT KO ",nrow(my_dat[my_dat$trace_kind == "SACT" & my_dat$verdict == "Fail",])))
print(paste(" SCMP ",    nrow(my_dat[my_dat$trace_kind == "SCMP",])))
print(paste("  SCMP OK ",nrow(my_dat[my_dat$trace_kind == "SCMP" & my_dat$verdict == "Pass",])))
print(paste("  SCMP KO ",nrow(my_dat[my_dat$trace_kind == "SCMP" & my_dat$verdict == "Fail",])))




# count TIMEOUTS

print("NO POR NO LOC TIMEOUTS")
print(paste("TOTAL ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT",])))
print(paste(" ACPT ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "ACPT",])))
print(paste(" PREF ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "PREF",])))
print(paste(" NOIS ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS",])))
print(paste("  NOIS OK ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Pass",])))
print(paste("  NOIS KO ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Fail",])))
print(paste(" SACT ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT",])))
print(paste("  SACT OK ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Pass",])))
print(paste("  SACT KO ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Fail",])))
print(paste(" SCMP ",    nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP",])))
print(paste("  SCMP OK ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Pass",])))
print(paste("  SCMP KO ",nrow(my_dat[my_dat$conf_graph_nopor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Fail",])))


print("NO POR WT LOC TIMEOUTS")
print(paste("TOTAL ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT",])))
print(paste(" ACPT ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "ACPT",])))
print(paste(" PREF ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "PREF",])))
print(paste(" NOIS ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS",])))
print(paste("  NOIS OK ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Pass",])))
print(paste("  NOIS KO ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Fail",])))
print(paste(" SACT ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT",])))
print(paste("  SACT OK ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Pass",])))
print(paste("  SACT KO ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Fail",])))
print(paste(" SCMP ",    nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP",])))
print(paste("  SCMP OK ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Pass",])))
print(paste("  SCMP KO ",nrow(my_dat[my_dat$conf_graph_nopor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Fail",])))



print("WT POR NO LOC TIMEOUTS")
print(paste("TOTAL ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT",])))
print(paste(" ACPT ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "ACPT",])))
print(paste(" PREF ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "PREF",])))
print(paste(" NOIS ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS",])))
print(paste("  NOIS OK ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Pass",])))
print(paste("  NOIS KO ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Fail",])))
print(paste(" SACT ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT",])))
print(paste("  SACT OK ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Pass",])))
print(paste("  SACT KO ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Fail",])))
print(paste(" SCMP ",    nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP",])))
print(paste("  SCMP OK ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Pass",])))
print(paste("  SCMP KO ",nrow(my_dat[my_dat$conf_graph_wtpor_noloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Fail",])))



print("WT POR WT LOC TIMEOUTS")
print(paste("TOTAL ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT",])))
print(paste(" ACPT ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "ACPT",])))
print(paste(" PREF ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "PREF",])))
print(paste(" NOIS ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS",])))
print(paste("  NOIS OK ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Pass",])))
print(paste("  NOIS KO ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "NOIS" & my_dat$verdict == "Fail",])))
print(paste(" SACT ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT",])))
print(paste("  SACT OK ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Pass",])))
print(paste("  SACT KO ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SACT" & my_dat$verdict == "Fail",])))
print(paste(" SCMP ",    nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP",])))
print(paste("  SCMP OK ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Pass",])))
print(paste("  SCMP KO ",nrow(my_dat[my_dat$conf_graph_wtpor_wtloc_time == "TIMEOUT" & my_dat$trace_kind == "SCMP" & my_dat$verdict == "Fail",])))



# remove all TIMEOUTS

no_timeouts <- my_dat[my_dat$conf_graph_nopor_noloc_time != "TIMEOUT",]
no_timeouts <- no_timeouts[no_timeouts$conf_graph_nopor_wtloc_time != "TIMEOUT",]
no_timeouts <- no_timeouts[no_timeouts$conf_graph_wtpor_noloc_time != "TIMEOUT",]
no_timeouts <- no_timeouts[no_timeouts$conf_graph_wtpor_wtloc_time != "TIMEOUT",]

# use violin plots to plot per length category

no_timeouts$conf_graph_nopor_noloc_graph_size <- as.integer(no_timeouts$conf_graph_nopor_noloc_graph_size)
no_timeouts$conf_graph_nopor_wtloc_graph_size <- as.integer(no_timeouts$conf_graph_nopor_wtloc_graph_size)
no_timeouts$conf_graph_wtpor_noloc_graph_size <- as.integer(no_timeouts$conf_graph_wtpor_noloc_graph_size)
no_timeouts$conf_graph_wtpor_wtloc_graph_size <- as.integer(no_timeouts$conf_graph_wtpor_wtloc_graph_size)
no_timeouts$trace_length <- as.integer(no_timeouts$trace_length)

length_cats <- c(-1, 3, 8, 13, 20, Inf)
length_cats_labs <- c("0-3","4-8","9-13","14-20", "21+")

no_timeouts$lengthCat <- cut(no_timeouts$trace_length, 
                          breaks=length_cats, 
                          labels=length_cats_labs)

max_y <- max(no_timeouts$conf_graph_nopor_noloc_graph_size,na.rm = TRUE) + 10


vp_no_no <- ggplot(no_timeouts, 
                   aes(x=lengthCat, 
                       y=conf_graph_nopor_noloc_graph_size, 
                       color=verdict)
) +
  geom_violin(na.rm=TRUE,draw_quantiles = c(0.25, 0.5, 0.75), scale="width")+
  scale_y_continuous(trans = "log10",limits = c(1, max_y),expand = c(0, 0))+
  labs(x="length category", y=NULL)+
  theme(
    axis.text.y = element_text(angle=90),
    # remove the legend
    legend.position="none",
    # set the background as a rectangle filled in white with black borders
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(colour = "black", fill=NA,  linewidth=.2),
    # remove the vertical grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    # explicitly set the horizontal grid lines (or they will disappear too)
    panel.grid.major.y = element_line( linewidth=.1, color="black" ),
    panel.grid.minor.y = element_line( linewidth=.025, color="black" ),
  )
vp_no_no

ggsave("nopor_noloc.png",
       vp_no_no, 
       width = 1750, 
       height = 1500, 
       units = "px")






vp_no_wt <- ggplot(no_timeouts, 
                   aes(x=lengthCat, 
                       y=conf_graph_nopor_wtloc_graph_size, 
                       color=verdict)
) +
  geom_violin(na.rm=TRUE,draw_quantiles = c(0.25, 0.5, 0.75), scale="width")+
  scale_y_continuous(trans = "log10",limits = c(1, max_y),expand = c(0, 0))+
  labs(x="length category", y=NULL)+
  theme(
    axis.text.y = element_text(angle=90),
    # remove the legend
    legend.position="none",
    # set the background as a rectangle filled in white with black borders
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(colour = "black", fill=NA,  linewidth=.2),
    # remove the vertical grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    # explicitly set the horizontal grid lines (or they will disappear too)
    panel.grid.major.y = element_line( linewidth=.1, color="black" ),
    panel.grid.minor.y = element_line( linewidth=.025, color="black" ),
  )
vp_no_wt

ggsave("nopor_wtloc.png",
       vp_no_wt, 
       width = 1750, 
       height = 1500, 
       units = "px")



vp_wt_no <- ggplot(no_timeouts, 
                   aes(x=lengthCat, 
                       y=conf_graph_wtpor_noloc_graph_size, 
                       color=verdict)
) +
  geom_violin(na.rm=TRUE,draw_quantiles = c(0.25, 0.5, 0.75), scale="width")+
  scale_y_continuous(trans = "log10",limits = c(1, max_y),expand = c(0, 0))+
  labs(x="length category", y=NULL)+
  theme(
    axis.text.y = element_text(angle=90),
    # remove the legend
    legend.position="none",
    # set the background as a rectangle filled in white with black borders
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(colour = "black", fill=NA,  linewidth=.2),
    # remove the vertical grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    # explicitly set the horizontal grid lines (or they will disappear too)
    panel.grid.major.y = element_line( linewidth=.1, color="black" ),
    panel.grid.minor.y = element_line( linewidth=.025, color="black" ),
  )
vp_wt_no

ggsave("wtpor_noloc.png",
       vp_wt_no, 
       width = 1750, 
       height = 1500, 
       units = "px")



vp_wt_wt <- ggplot(no_timeouts, 
                   aes(x=lengthCat, 
                       y=conf_graph_wtpor_wtloc_graph_size, 
                       color=verdict)
) +
  geom_violin(na.rm=TRUE,draw_quantiles = c(0.25, 0.5, 0.75), scale="width")+
  scale_y_continuous(trans = "log10",limits = c(1, max_y),expand = c(0, 0))+
  labs(x="length category", y=NULL)+
  theme(
    axis.text.y = element_text(angle=90),
    # remove the legend
    legend.position="none",
    # set the background as a rectangle filled in white with black borders
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(colour = "black", fill=NA,  linewidth=.2),
    # remove the vertical grid lines
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    # explicitly set the horizontal grid lines (or they will disappear too)
    panel.grid.major.y = element_line( linewidth=.1, color="black" ),
    panel.grid.minor.y = element_line( linewidth=.025, color="black" ),
  )
vp_wt_wt

ggsave("wtpor_wtloc.png",
       vp_wt_wt, 
       width = 1750, 
       height = 1500, 
       units = "px")



