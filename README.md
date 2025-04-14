# padre_to_bids

This repository provides a Jupyter notebook to convert fMRI datasets from the **PADRE format** (as used in [azraq27/padre](https://github.com/azraq27/padre)) into the **BIDS format**, making the data compatible with modern tools like [fMRIPrep](https://fmriprep.org/).

## Description

- The PADRE format is a structured fMRI data format with `.nii.gz` files and JSON sidecars, similar to BIDS, but not directly compatible with BIDS apps.
- This notebook helps convert your existing PADRE-format dataset into a fully BIDS-compliant dataset.

## Dependencies

- Python 2.7 (legacy support)
- Jupyter Notebook
- `nibabel`, `os`, `json`, `shutil`

You will also need the following two repositories:
- [`padre`](https://github.com/azraq27/padre)
- [`neural`](https://github.com/azraq27/neural)

## Repository Structure
