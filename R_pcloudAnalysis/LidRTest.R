library(lidR)
library(ggplot2)

theme_set(theme_gray(base_size = 18))

filename1="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground_height.las"
filename2="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground_height_sub1.las"
filename3="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground_height_sub2.las"
filename4="D://NAEM//Data//ALS_AHN2//SelStudyArea2_sel1_ground_height_sub3.las"

las1=readLAS(filename1)
las2=readLAS(filename2)
las3=readLAS(filename3)
las4=readLAS(filename4)

chm1 = grid_canopy(las1, 0.2, subcircle = 0.2)
plot(chm1)
chm2 = grid_canopy(las2, 0.2, subcircle = 0.2)
plot(chm2)
chm3 = grid_canopy(las3, 0.2, subcircle = 0.2)
plot(chm3)
chm4 = grid_canopy(las4, 0.2, subcircle = 0.2)
plot(chm4)

boxplot(as.vector(chm1$Z),as.vector(chm2$Z),as.vector(chm3$Z),as.vector(chm4$Z),names=c("10 pt/m2","7 pt/m2","4 pt/m2","2 pt/m2"),col="blue")

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

qplot(h,nofret)+
  geom_line(linetype="dashed", color="blue", size=1.2)+
  geom_point(color="red", size=3)+ coord_flip()