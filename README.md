
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <img src="https://i.imgur.com/vTLlhbp.png" align="right" height=88 /> fgeo.validate

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/forestgeo/fgeo.validate.svg?branch=master)](https://travis-ci.org/forestgeo/fgeo.validate)
[![CRAN
status](https://www.r-pkg.org/badges/version/fgeo.validate)](https://cran.r-project.org/package=fgeo.validate)
<!-- badges: end -->

The goal of fgeo.validate is to validate ForestGEO tables. Specifically,
it aims to meet these [Requirements](#requirements).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("forestgeo/fgeo.validate")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fgeo.validate)
## basic example code
```

## Requirements

    From: Lao, Suzanne
    Sent: Tuesday, April 30, 2019 2:47 PM
    To: Lepore, Mauro <LeporeM@si.edu>; Shameema Jafferjee Esufali (shameemaesufali@gmail.com)
    <shameemaesufali@gmail.com>
    Cc: Krizel, Lauren <KrizelL@si.edu>
    Subject: RE: Building R stem tables for the upcomming workshop

> When making the R stem tables, please note the following comments when
> determining the status variable.

1.  DFstatus is exactly the same as the status variable in
    ViewFullTable.

2.  The status variable in the R tables is calculated as follows for
    stems:

| status\_in\_viewfulltable | status\_after\_rtbl |
| :------------------------ | :------------------ |
| alive                     | A                   |
| dead                      | D                   |
| broken below or stem dead | G                   |
| missing                   | M                   |

> Also, do the following:

3.  Give an Rstatus of P -“prior”, if a stem does not appear in the
    first censuses, i.e. stem is first measured in a later census.

Propagate `status == P` forward in all censuses until it first appears.

4.  Propagate the Rstatus D (dead) forward, even if the stem disappears
    in later censuses.

5.  G - “gone” - propagate forward (even if stem disappears in later
    censuses) until the stem is measured again in a later census.

6.  If a stem was dead in a census, then later found alive, go back and
    change all the Rstatus ‘D’ to ‘A’.

> Stems may go through the following Rstatuses and in this order:

`P (prior) -> A (alive) -> G (gone) -> D (dead)`

P, G, and/or D may be missing.

> Problems that have to be fixed in the Rstatus sequence:

7.  P should NEVER follow any of the other Rstatuses. It should be the
    first Rstatus, or not appear at all.

8.  P should not go directly to G or D, without first going to A.

9.  D should never be followed by A or G.

10. Stems should not start with a G, they should start with P or A.
    Somemes they start with a D when the site tags and measures dead
    stems

> The folder called “onecensus” contains the data from sites for which I
> have one census only. You may not need to make R tables for these
> sites, since the R tables that already exist should be fine. You may
> still want to make them to compare with those that are on the server.
