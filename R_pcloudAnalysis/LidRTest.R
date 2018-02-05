library(lidR)

filename="D://NAEM//Data//ALS_AHN2//TestData_ConfCentrum.las"

las=readLAS(filename)

grid_metrics(las, max(Z), 2) %>% plot