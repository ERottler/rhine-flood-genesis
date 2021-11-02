# Spatio-temporal analysis of historic and projected flood formation in the Rhine River basin

### Summary

This repository stores software code of a Shiny dashboard that enables the spatio-temporal analysis of historic and projected flood formation in the Rhine River basin. The genesis of riverine floods in large river basins often is complex. Streamflow originating from precipitation and snowmelt and from different tributaries can superimpose and cause high water levels threatening cities and comunities residing along the river banks. Our investigations base on hydrological simulations using the mesoscale Hydrolgical Model [mHM](https://www.ufz.de/index.php?en=40114) forced with historic meteorological data based on observations and an ensemble of climate projections. A detailed description of the model simulations analysed in this study can be found in [Rottler et al. 2021](https://doi.org/10.5194/hess-25-2353-2021). For each meteorological forcing, we determine the ten highest runoff peaks at four locations along the Rhine River (Cologne, Kaub, Worms and Speyer) and analyse the genesis of the peak in detail. The spatio-temporal analyis of the streamflow peak genesis includes the assessment and visualization of antecedent liquid precipitation, snow cover changes, runoff generated, flood extent and the excess runoff from major sub-basins up to ten days before the streamflow peak.
       
Preliminary results are available at: http://natriskchange.ad.umwelt.uni-potsdam.de:3838/rhine-flood-genesis/


### Overview figures on streamflow peak characteristics (using [plotly](https://plotly.com/r/))

<img src="www/screenshots/screenshot_2.png" width=100%>          

### Interactive analysis of peak flow formation

<img src="www/screenshots/screenshot_1.png" width=100%>  

### Authors and Contact

This analysis was conducted by Erwin Rottler (member of the working group Hydrology & Climatology, University of Potsdam) in the framework of investigations focusing on future changes Rhine River flood seasonality. The analysis was supported by Axel Bronstert (head of the working group Hydrology & Climatology, University of Potsdam) and Gerd Bürger (senior scientist within the working group Hydrology & Climatology, University of Potsdam). We thank our colleagues from the Department of Computational Hydrosystems, Helmholtz Centre for Environmental Research (UFZ), particularly Oldrich Rakovec and Luis Samaniego, for their support during model setup and data analysis. Should you have any comments, questions or suggestions, please do not hesitate to use the [GitHub Issue Tracker](https://github.com/ERottler/rhine-flood-genesis/issues) or write an email to: rottler(at)uni-potsdam.de

