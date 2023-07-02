#!/bin/sh
# 1. Import data
# listing the files
g.list rast
# LC08_L2SP_193036_20140101_20200912_02_T1_SR_B1
# importing the image subset with 7 Landsat bands and display the raster map (polinalemenkova)
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B1.TIF output=L8_2023_01 resample=bilinear extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B2.TIF output=L8_2023_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B3.TIF output=L8_2023_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B4.TIF output=L8_2023_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B5.TIF output=L8_2023_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B6.TIF output=L8_2023_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/SSudan/LC09_L2SP_173055_20230514_20230516_02_T1_SR_B7.TIF output=L8_2023_07 extent=region resolution=region
#
g.list rast
#
# grouping data by i.group
# Set computational region to match the scene
g.region raster=L8_2023_01 -p
# store VIZ, NIR, MIR into group/subgroup (leaving out TIR)
i.group group=L8_2023 subgroup=res_30m \
  input=L8_2023_01,L8_2023_02,L8_2023_03,L8_2023_04,L8_2023_05,L8_2023_06,L8_2023_07
#
# 4. Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2023 subgroup=res_30m \
  signaturefile=cluster_L8_2023 \
  classes=10 reportfile=rep_clust_L8_2023.txt --overwrite
# 5. Classification by i.maxlik module
#
i.maxlik group=L8_2023 subgroup=res_30m \
  signaturefile=cluster_L8_2023 \
  output=L8_2023_cluster_classes reject=L8_2023_cluster_reject --overwrite
#
# 6. Mapping
d.mon wx0
g.region raster=L8_2023_cluster_classes -p
r.colors L8_2023_cluster_classes color=rainbow -e
d.rast L8_2023_cluster_classes
d.legend raster=L8_2023_cluster_classes title="2023" title_fontsize=12 font="Helvetica" fontsize=10 bgcolor=white border_color=white
d.out.file output=SSudan_2023 format=jpg --overwrite
#
d.mon wx1
g.region raster=L8_2023_cluster_classes -p
d.rast L8_2023_cluster_reject
d.legend raster=L8_2023_cluster_reject title="2023" title_fontsize=12 font="Helvetica" fontsize=10 bgcolor=white border_color=white
d.out.file output=SSudan_2023_reject format=jpg --overwrite
#d.rast.leg L8_2014_cluster_reject
#
# r.kappa - Calculates error matrix and kappa parameter for accuracy assessment of classification result.
g.region raster=L8_2023_cluster_classes -p
r.kappa -w classification=L8_2023_cluster_classes reference=training_classes_Sudd

# g.rename raster=L8_2017_cluster_classes,training_classes_Sudd

# export Kappa matrix as CSV file "kappa.csv"
r.kappa classification=L8_2023_cluster_classes reference=training_classes_Sudd output=kappa.csv -m -h --overwrite
