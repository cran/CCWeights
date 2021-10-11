
# Welcome to CCWeights <img src='https://github.com/YonghuiDong/CCWeights/blob/main/inst/shiny/Gui/mds/pix/logo.png' align="right" height="130"/>

[![CRAN status](http://www.r-pkg.org/badges/version/CCWeights)](https://cran.r-project.org/package=CCWeights) 

Calibration curves are used to understand the instrumental response to an analyte and predict the concentration in an unknown sample. A well-established and interpreted calibration curve is essential for any analytical methodology. 

**CCweights</span>** is a web-based tool (also an R package), which provides automated and efficient data analysis workflow to evaluate and select the best weighting factor for linear calibration curve and quantify targeted analytes accordingly. 

CCWeights can be applied for any analytical assays, in which linear calibration curves are used for quantification. For instance, Ultraviolet-visible spectroscopy- and liquid/gas chromatography mass spectrometry-based quantitative studies.

# Installation

1. stable version

```r
install.packages("CCWeights")
```

2. development version

```
require(devtools)
install_github("YonghuiDong/CCWeights")
```

Note: you need to install R package `bs4Dash` version <= 0.50 in order to run CCWeights shiny app locally. Please refer to section [Known Issues](#known-issues) for more details.

# Workflow

Below is an overview of CCWeights workflow:

<img src="https://github.com/YonghuiDong/CCWeights/blob/main/inst/shiny/Gui/mds/pix/workflow.png" width = "50%"/>

<em>Figure 1. Schematic workflow of CCWeights</em>

**Data Preparation:** 

- Data must contain at least two columns, one is `Concentration`, and another one is `Response`. In case you have more than one compound in your sample, you need to have a third column called `Compound`. If internal standards are used (e.g., stable isotope labeled internal standards), please include another column named `IS`, with the corresponding response value filled in the cell. 

- Use `unknown` for compounds with `Concentrations` to be determined in samples.

- Data with known `Concentration` will be regarded as calibration standards for calibration curve construction and evaluation.

- Data with `unknown` concentration will be regarded as unknown samples, and the `Concentration` will be predicted.
  
- You can refer to the example data in the **Upload Data** tab or **Figure 2** for the data format.
  
- You can also **[<b><span style="color:#F17F42">download the templates here</span></b>](https://github.com/YonghuiDong/CCWeights/tree/main/inst/shiny/Templete)** to prepare your data accordingly.

<img src="https://github.com/YonghuiDong/CCWeights/blob/main/inst/shiny/Gui/mds/pix/datafile.png" width="50%"/>

<em>Figure 2. Data format requirement</em>

- Once data file is successfully uploaded, you can perform data analysis following the steps shown in Figure 1.

## Known Issues

Due to substantial breaking changes in the API of R package `bs4Dash`, CCWeights, built with bs4Dash (version <= 0.5.0), is not compatible with v2.0.0. Therefore, users need to install the old version in order to run the shiny App of CCWeights locally.

There are two simple ways to install the old version of `bs4Dash`:

#### 1. Using devtools to install the older package version

```r
require(devtools)
install_version("bs4Dash", version = "0.5.0", repos = "http://cran.us.r-project.org")
```

#### 2. Installing an older package from source

You can download the old version (e.g., v0.5.0) [here](https://cran.r-project.org/src/contrib/Archive/bs4Dash/), and install it manually.

## Citation

If you find `CCWeights` useful, please consider citing our publication :smiley::

- CCWeights: An R package and web application for automated evaluation and selection of weighting factors for accurate quantification using linear calibration curve.

<br></br>


