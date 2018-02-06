set lasfile1=D:\NAEM\Data\ALS_AHN2\AHN1_g40bn2
set lasfile2=D:\NAEM\Data\ALS_AHN2\AHN1_40bn2

set shpfile=D:\NAEM\Data\Field\SelStudyArea2.shp

set outfile=D:\NAEM\Data\ALS_AHN2\SelStudyArea2_AHN1

C:\LAStools\bin\lasclip -i %lasfile1%.laz -poly %shpfile% -v -o %lasfile1%_1.las
C:\LAStools\bin\lasclip -i %lasfile2%.laz -poly %shpfile% -v -o %lasfile2%_1.las

C:\LAStools\bin\lasmerge -i %lasfile1%_1.las %lasfile2%_1.las -o %outfile%.las