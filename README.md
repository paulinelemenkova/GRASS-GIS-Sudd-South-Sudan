# GRASS GIS Scripts — Annual MaxLik Land-Cover Classification of the Sudd Wetlands, South Sudan

GRASS GIS shell scripts used in the peer-reviewed article by Polina Lemenkova. This repository holds the per-year maximum-likelihood classification scripts for a Landsat 8-9 OLI/TIRS time series (2015–2023) of the Sudd Wetlands, South Sudan, with k-means clustering and kappa-based accuracy assessment.

**Published in:** *Analytics* **2023**, *2*(3), 745–780
**DOI:** https://doi.org/10.3390/analytics2030040
**Journal (open access):** https://www.mdpi.com/2813-2203/2/3/40
**HAL:** https://hal.science/hal-04214295v1
**Zenodo:** https://doi.org/10.5281/zenodo.8367885
**SSRN:** https://ssrn.com/abstract=4579189

## Contents
One script per year (2015–2023), each calling GRASS GIS modules for raster import (r.import), band grouping (i.group), unsupervised clustering (i.cluster, k-means), maximum-likelihood classification (i.maxlik), rejection-probability mapping, and accuracy assessment (r.kappa, error matrix and kappa coefficient).

## Related repositories
- LaTeX source (article prose): https://github.com/paulinelemenkova/grass-image-segmentation-south-sudan
- Segmentation, clustering and accuracy-matrix scripts (cited in the article's Data Availability): https://github.com/paulinelemenkova/grass-segmentation-classification-sudd

## Citation
Lemenkova, P. Image Segmentation of the Sudd Wetlands in South Sudan for Environmental Analytics by GRASS GIS Scripts. *Analytics* **2023**, *2*(3), 745–780. https://doi.org/10.3390/analytics2030040
