# Maps for:
# Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean 
# by Luigi Colin
#
# REQUIRED EXTERNAL FILES:
#   Maps/all_population_sites.tsv
#       GPS coordinates and display labels for each sample site.
#       Key columns: Label_Numb, Site, label_plot, GPS_poin_1 (lon), GPS_point_ (lat)
#   Maps/STR-Probability_of_clusters_A_tenuis.csv
#       STRUCTURE cluster assignment probabilities.
#       Required columns: Population, Probability_Cluster.1, Probability_Cluster.2
#   Maps/shape_files/reefs/WCMC008_CoralReef2021_Py_v4_1.shp
#       Coral reef shapefile for map backgrounds.
# NOTE: Background map tiles are fetched from Stadia Maps, which requires a free
#       API key (https://stadiamaps.com). Register your key before running:
#       ggmap::register_stadiamaps("YOUR_KEY")

library("pacman")
p_load(dplyr, ggplot2, ggmap, patchwork, sf, ggspatial, RColorBrewer, purrr, ggrepel, scatterpie)

dir.create("plots", showWarnings = FALSE, recursive = TRUE)

#---  SHARED DATA ---#
sf::sf_use_s2(TRUE)
reefs    <- st_read("Maps/shape_files/reefs/WCMC008_CoralReef2021_Py_v4_1.shp", quiet = TRUE)
all_sites_tsv <- read.delim("Maps/all_population_sites.tsv", header = TRUE, fill = TRUE)

# Read individual-level population shapefiles and attach display labels from TSV
all_population_sites <- map_dfr(
  list.files("Maps/shape_files", pattern = "^population_.*\\.shp$", full.names = TRUE),
  function(file) {
    st_read(file, quiet = TRUE) %>%
      st_transform(crs = 4326) %>%
      mutate(population = gsub("^population_|\\.shp$", "", basename(file)))
  }
) %>%
  left_join(all_sites_tsv %>% select(Label_Numb, label_plot), by = "Label_Numb")

# Population colour palette
unique_pops <- unique(all_population_sites$population)
colors <- setNames(brewer.pal(max(3, length(unique_pops)), "Dark2")[seq_along(unique_pops)],
                   unique_pops)


#--- FIGURE 1 — OVERVIEW MAP WITH REEF SITES ---#
# Aggregates individual GPS points into 18 named reef-site centroids.
# Each entry lists the site names (matching all_sites_tsv$Site) that belong to it.
reef_site_mapping <- list(
  "Grand Glorieuse (north)" = list(sites = c("Grand Glorieuse (north)"),
                                    population = "Iles Glorieuses"),
  "Assumption"              = list(sites = c("Assumption Jetty Left"),
                                    population = "Seychelles Outer Islands"),
  "Aldabra"                 = list(sites = c("Anse Var 20m", "ARM07", "ARM9", "Lag 1"),
                                    population = "Seychelles Outer Islands"),
  "Astove"                  = list(sites = c("Astove"),
                                    population = "Seychelles Outer Islands"),
  "Praslin Atoll"           = list(sites = c("Praslin APC"),
                                    population = "Seychelles Inner Islands"),
  "Curieuse"                = list(sites = c("Curieuse.Larai"),
                                    population = "Seychelles Inner Islands"),
  "Aride"                   = list(sites = c("Aride"),
                                    population = "Seychelles Inner Islands"),
  "Fregate"                 = list(sites = c("Fregate"),
                                    population = "Seychelles Inner Islands"),
  "Cannon Point"            = list(sites = c("Cannon Point"),
                                    population = "Diego Garcia"),
  "Mid Island"              = list(sites = c("Mid Island"),
                                    population = "Diego Garcia"),
  "Barton Point"            = list(sites = c("Barton Point", "Barton point (lagoon)", "Barton point (seaward)"),
                                    population = "Diego Garcia"),
  "South Brothers"          = list(sites = c("South Brother", "Brothers Mid Lagoon", "Brothers North", "Middle Brother lagoon"),
                                    population = "Chagos western atolls"),
  "Egmont Atoll"            = list(sites = c("Eagle Seaward", "Egmont Mid"),
                                    population = "Chagos western atolls"),
  "South Peros Banhos"      = list(sites = c("Ile du coin"),
                                    population = "Chagos northern atolls"),
  "North Peros Banhos"      = list(sites = c("Diamont Seaward", "Lagoon Diamont", "Moresby", "Ile de Poule (outside)"),
                                    population = "Chagos northern atolls"),
  "West Salomon"            = list(sites = c("Ile Anglaise lagoon", "Ile Anglaise seaward"),
                                    population = "Chagos northern atolls"),
  "North Salomon"           = list(sites = c("Courts Knoll", "Ile de Passe"),
                                    population = "Chagos northern atolls"),
  "Nelson"                  = list(sites = c("Nelson seaward"),
                                    population = "Chagos northern atolls")
)

reef_sites_sf <- imap_dfr(reef_site_mapping, function(info, reef_name) {
  sub <- all_sites_tsv[all_sites_tsv$Site %in% info$sites, ]
  data.frame(
    reef_site  = reef_name,
    population = info$population,
    lon        = mean(sub$GPS_poin_1, na.rm = TRUE),
    lat        = mean(sub$GPS_point_, na.rm = TRUE)
  )
}) %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

# Builds a ggplot map with population site markers.
#   map        — background raster from get_stadiamap() (NULL for no background)
#   point_size — size of site markers
#   xlim/ylim  — WGS84 bounding box; must match the bbox used in get_stadiamap()
#   show_labels — overlay repelled reef-site name labels (uses label_col column)
create_map <- function(map = NULL, point_size, xlim, ylim,
                       show_legend = TRUE, show_labels = FALSE,
                       label_col = "label_plot", sites = all_population_sites) {
  bbox_3857 <- st_transform(
    st_as_sfc(st_bbox(c(xmin = xlim[1], xmax = xlim[2], ymin = ylim[1], ymax = ylim[2]),
                      crs = st_crs(4326))),
    crs = 3857
  ) %>% st_bbox()

  reefs$feature_type <- "Reefs"

  p <- ggplot()
  if (!is.null(map)) {
    p <- p + annotation_raster(map,
                               xmin = bbox_3857["xmin"], xmax = bbox_3857["xmax"],
                               ymin = bbox_3857["ymin"], ymax = bbox_3857["ymax"])
  }
  p <- p +
    geom_sf(data = reefs, aes(fill = feature_type),
            color = "lightblue", size = 0.1, inherit.aes = FALSE, show.legend = TRUE) +
    geom_sf(data = sites, aes(fill = population),
            color = "black", size = point_size, shape = 21, stroke = 0.8, alpha = 0.8,
            inherit.aes = FALSE, show.legend = FALSE) +
    scale_fill_manual(values = c("Reefs" = "lightblue", colors),
                      name = "",
                      breaks = c("Reefs", names(colors)),
                      labels = c("Reefs", names(colors))) +
    coord_sf(xlim = c(bbox_3857["xmin"], bbox_3857["xmax"]),
             ylim = c(bbox_3857["ymin"], bbox_3857["ymax"]),
             expand = FALSE, crs = st_crs(3857)) +
    theme_minimal() +
    theme(axis.text        = element_text(size = 10),
          panel.grid       = element_blank(),
          plot.background  = element_rect(fill = "white", color = NA),
          legend.position  = if (show_legend) "right" else "none") +
    xlab("Longitude") + ylab("Latitude")

  if (show_labels) {
    unique_sites <- sites[!duplicated(sites[[label_col]]), ]
    coords       <- st_coordinates(unique_sites)
    unique_sites <- unique_sites[coords[, "X"] >= xlim[1] & coords[, "X"] <= xlim[2] &
                                 coords[, "Y"] >= ylim[1] & coords[, "Y"] <= ylim[2], ]
    p <- p + ggrepel::geom_text_repel(
      data    = unique_sites,
      mapping = aes(label = .data[[label_col]], geometry = geometry),
      stat    = "sf_coordinates",
      size    = point_size * 1.2, fontface = "bold",
      nudge_y = 0.1, min.segment.length = 0,
      box.padding = 0.5, max.overlaps = Inf
    )
  }
  p
}

# Download background tiles once; cached in overall_map across re-runs
if (!exists("overall_map")) {
  overall_map <- get_stadiamap(
    bbox    = c(left = 44, bottom = -14, right = 75, top = -2),
    zoom    = 10,
    maptype = "stamen_terrain_background"
  )
}

scalebar_arrow <- list(
  annotation_scale(location = "br", width_hint = 0.2),
  annotation_north_arrow(location = "br", pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)
)

overall <- create_map(overall_map, 3, c(44, 75), c(-14, -2), sites = reef_sites_sf)
overall <- overall + scalebar_arrow

ggsave("plots/Figure_1-overall_map.png",
       plot = overall, width = 21, height = 12, dpi = 300, scale = 0.7)
# ggsave("plots/Figure_1-overall_map.svg",
#        plot = overall, width = 21, height = 12, dpi = 300, scale = 0.7)

ggsave("plots/Figure_1-overall_map_bottom.png",
       plot = overall + theme(legend.position = "bottom"),
       width = 21, height = 12, dpi = 300, scale = 0.7)
# ggsave("plots/Figure_1-overall_map_bottom.svg",
#        plot = overall + theme(legend.position = "bottom"),
#        width = 21, height = 12, dpi = 300, scale = 0.7)

overall_labeled <- create_map(overall_map, 3, c(44, 75), c(-14, -2),
                              sites = reef_sites_sf,
                              show_labels = TRUE, label_col = "reef_site")
overall_labeled <- overall_labeled + scalebar_arrow

ggsave("plots/Figure_1-overall_map_labeled.png",
       plot = overall_labeled + theme(legend.position = "bottom"),
       width = 21, height = 12, dpi = 300, scale = 0.7)
# ggsave("plots/Figure_1-overall_map_labeled.svg",
#        plot = overall_labeled + theme(legend.position = "bottom"),
#        width = 21, height = 12, dpi = 300, scale = 0.7)

#--- FIGURE 4 — STRUCTURE CLUSTER ASSIGNMENT MAP ---#
cluster_prob <- read.csv("Maps/STR-Probability_of_clusters_A_tenuis.csv") %>%
  mutate(across(starts_with("Probability_Cluster"), as.numeric)) %>%
  select(1:3)

locations_sf <- st_read("Maps/shape_files/Mean_coord_plot.shp", quiet = TRUE) %>%
  st_transform(crs = 4326) %>%
  mutate(population = case_when(
    population == "Chagos northern atolls" ~ "Chagos Northern Atolls",
    population == "Chagos western atolls"  ~ "Chagos Western Atolls",
    population == "Diego Garcia"           ~ "Chagos Diego Garcia",
    TRUE                                   ~ population
  )) %>%
  left_join(cluster_prob, by = c("population" = "Population"))

# geom_scatterpie requires a plain data frame (not sf).
# offset_x/y shift pie centres slightly to avoid overlap with point markers.
locations_df <- as.data.frame(locations_sf) %>%
  mutate(MEAN_X_offset = MEAN_X + 0.4,
         MEAN_Y_offset = MEAN_Y + 0.4)

create_cluster_map <- function(map, r, xlim, ylim) {
  ggplot() +
    annotation_raster(map, xmin = xlim[1], xmax = xlim[2],
                      ymin = ylim[1], ymax = ylim[2]) +
    geom_sf(data = reefs, fill = "#B0E6F8") +
    geom_sf(data = locations_sf, color = "black", size = 1) +
    geom_scatterpie(data = locations_df,
                    aes(x = MEAN_X_offset, y = MEAN_Y_offset, r = r), pie_scale = 1,
                    cols = c("Probability_Cluster.1", "Probability_Cluster.2")) +
    coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
    scale_fill_manual(name   = "Cluster",
                      labels = c("Cluster 1", "Cluster 2"),
                      values = c("#219CE2", "#F76F27")) +
    theme_minimal() +
    xlab("Longitude") + ylab("Latitude")
}

overall_cluster <- create_cluster_map(overall_map, 0.45, c(45, 75), c(-13, -2)) +
  scalebar_arrow

ggsave("plots/Figure_4-cluster_map.png",
       plot = overall_cluster, width = 20, height = 15, dpi = 300, scale = 0.8)
# ggsave("plots/Figure_4-cluster_map.svg",
#        plot = overall_cluster, width = 20, height = 15)
