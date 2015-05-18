PARCC - Protected Areas Resilient to Climate Change
===========================

The main objective of the project is to help countries design protected area
systems resilient to the effects of climate change by:

* Providing the tools for assessing the vulnerability of PAs to climate change
* Helping design strategies to strengthen the resilience of PAs
* Building capacity in the region for using the tools and implement the strategies

# Sources

The PARCC project feeds its data from two main sources: the Protected Planet
API, and a set of CSV files containing various information on the targeted
protected areas.

# Importing

When new versions of the CSV files are provided, the importing process can be started by calling the rake task `parcc:import`. This will read the CSV files in the `lib/data/parcc` subfolders, and import their content.

Note that this task will initially fill the CSV file `lib/data/parcc/protected_areas.csv` with a subset of the information contained in one of the CSV files in the folder `lib/data/parcc/turnover` (doesn't matter which one). These information are then used to identify, and merge, with the information coming from the Protected Planet API.
