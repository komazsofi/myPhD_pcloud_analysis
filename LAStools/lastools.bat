set filename=D:\NAEM\Data\ALS_AHN2\SelStudyArea2_AHN1

C:\LAStools\bin\lasground_new -i %filename%.las -o %filename%_ground.las -step 1
C:\LAStools\bin\lasheight -i %filename%_ground.las -o %filename%_ground_height.las