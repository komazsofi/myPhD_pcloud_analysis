library(lidR)

filename="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground_height.las"

las=readLAS(filename)

chm2 = grid_canopy(las, 0.2, subcircle = 0.2)
plot(chm2)

entropy = las %>% grid_metrics(entropy(Z))
plot(entropy)

chm = grid_canopy(las, res = 0.5, subcircle = 0.2, na.fill = "knnidw", k = 4)
chm = as.raster(chm)
kernel = matrix(1,3,3)
chm = raster::focal(chm, w = kernel, fun = mean)
chm = raster::focal(chm, w = kernel, fun = mean)

crowns = lastrees(las, "watershed", chm, th = 2, extra = TRUE)

tree = lasfilter(las, !is.na(treeID))
plot(tree, color = "treeID", colorPalette = pastel.colors(100), size = 3)

library(raster)
contour = rasterToPolygons(crowns, dissolve = TRUE)

plot(chm, col = height.colors(50))
plot(contour, add = T)

z=las@data$Z
nofret=matrix(data=NA, nrow=length(seq(min(z), max(z), by=2)), ncol=1)
h=seq(min(z), max(z)-1, by=1)

for (i in seq(min(z), max(z), by=1)) { nofret[i]=length(which((z>i) & (z<i+2)))/length(z)*100}

library(ggplot2)

theme_set(theme_gray(base_size = 18))

qplot(h,nofret)+
  geom_line(linetype="dashed", color="blue", size=1.2)+
  geom_point(color="red", size=3)+ coord_flip()