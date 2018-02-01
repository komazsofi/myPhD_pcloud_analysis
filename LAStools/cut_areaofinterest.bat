set lasfile1=D:\NAEM\Data\ALS_AHN2\g32hz1
set lasfile2=D:\NAEM\Data\ALS_AHN2\u32hz1

set shpfile=D:\NAEM\Data\Field\ConfCentrum.shp

set outfile=D:\NAEM\Data\ALS_AHN2\ConfCentrum

C:\LAStools\bin\lasclip -i %lasfile1%.laz -poly %shpfile% -v -o %lasfile1%_1.las
C:\LAStools\bin\lasclip -i %lasfile2%.laz -poly %shpfile% -v -o %lasfile2%_1.las

C:\LAStools\bin\lasmerge -i %lasfile1%_1.las %lasfile2%_1.las -o %outfile%.las