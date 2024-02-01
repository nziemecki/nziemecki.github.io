# -*- coding: utf-8 -*-
"""
Created on Wed Jan  3 12:16:00 2024

@author: Nathan.Ziemecki
"""

import pandas as pd
import geopandas as gpd

sampling_sites = gpd.read_file('C:/Users/Nathan.Ziemecki/Desktop/Tasks/GIS/rts_points/monitoring_sites.shp')
low_cl_count = pd.read_csv('C:/Users/Nathan.Ziemecki/Desktop/Tasks/cl2samp/low_cl_count.csv')
water_age = pd.read_csv('C:/Users/Nathan.Ziemecki/Desktop/Tasks/cl2samp/water_age.csv')

LOC_ID_dtype = sampling_sites['LOC_ID'].dtype
low_cl_count['LOC_ID'] = low_cl_count['LOC_ID'].astype(LOC_ID_dtype)
water_age['LOC_ID'] = water_age['LOC_ID'].astype(LOC_ID_dtype)

result1 = sampling_sites.merge(water_age, how="left", left_on="LOC_ID", right_on="LOC_ID")

result2 = result1.merge(low_cl_count, how="left", left_on="LOC_ID", right_on="LOC_ID")

result2.to_file('C:/Users/Nathan.Ziemecki/Desktop/Tasks/cl2samp/water_quality.shp', driver='ESRI Shapefile')
