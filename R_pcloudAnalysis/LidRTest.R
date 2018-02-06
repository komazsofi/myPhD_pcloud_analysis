library(lidR)

filename="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground.las"

las=readLAS(filename)

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