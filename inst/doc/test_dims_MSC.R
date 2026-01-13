## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
install_dir = tempfile()
dir.create(install_dir)

## -----------------------------------------------------------------------------
library(cifti)
download_cifti_data(outdir = install_dir)

## -----------------------------------------------------------------------------
mscfile = file.path(
  install_dir, 
  "sub-MSC01_ses-func01_task-rest_bold_32k_fsLR.dtseries.nii")
if (!file.exists(mscfile)) {
  # url = paste0(
  #   "https://openneuro.org/crn/datasets/ds000224/snapshots/00002/files/", 
  #   "derivatives:", "surface_pipeline:", "sub-MSC01:",
  #   "processed_restingstate_timecourses:",  "ses-func01:cifti:",
  #   "sub-MSC01_ses-func01_task-rest_bold_32k_fsLR.dtseries.nii")
  url = paste0("https://s3.amazonaws.com/openneuro/ds000224/ds000224_R1.0.2/",
               "uncompressed/derivatives/surface_pipeline/sub-MSC01/", 
               "processed_restingstate_timecourses/ses-func01/cifti/", 
               "sub-MSC01_ses-func01_task-rest_bold_32k_fsLR.dtseries.nii")
  res = download.file(url = url, 
    destfile = mscfile, mode = "wb")
  stopifnot(file.exists(mscfile))
}

## -----------------------------------------------------------------------------
test_dir = file.path(install_dir, "cifti-2_test_data")

ds <- read_cifti(
  file.path(test_dir,
            "Conte69.MyelinAndCorrThickness.32k_fs_LR.dscalar.nii")
  )
dt <- read_cifti(
  file.path(test_dir,
            "Conte69.MyelinAndCorrThickness.32k_fs_LR.dtseries.nii")
  )
pt <- read_cifti(
  file.path(test_dir,
            "Conte69.MyelinAndCorrThickness.32k_fs_LR.ptseries.nii")
  )
dl <- read_cifti(
  file.path(test_dir, 
            "Conte69.parcellations_VGD11b.32k_fs_LR.dlabel.nii") 
  )
msc <- read_cifti(mscfile, trans_data = FALSE)
msc_trans <- read_cifti(mscfile, trans_data = TRUE)

## ----echo = FALSE-------------------------------------------------------------
matfile = system.file("extdata", "msc01_10by10.csv.gz", package = "cifti")
mat = read.csv(matfile, header = FALSE)
msc01_refmat <- as.matrix(mat)
print(msc01_refmat[1:5,1:5])

## -----------------------------------------------------------------------------
msc$hdr
dim(msc$data)

msc$data[1:5,1:5]

## -----------------------------------------------------------------------------
t(msc_trans$data[1:5,1:5])

## -----------------------------------------------------------------------------
ds$hdr
attributes(ds$BrainModel[[1]])
attributes(ds$BrainModel[[2]])
dim(ds$data)
head(ds$data)

## -----------------------------------------------------------------------------
dt$hdr
attributes(dt$BrainModel[[1]])
attributes(dt$BrainModel[[2]])
dim(dt$data)
head(dt$data)

## -----------------------------------------------------------------------------
pt$hdr
dim(pt$data)
head(pt$data)

## -----------------------------------------------------------------------------
dl$hdr
dim(dl$data)
head(dl$data)

