# 1. padre_to_bids

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

## Output Structure (BIDS)
<pre>
bids_data/
├── sub-01/
│   └── ses-01/
│       ├── anat/
│       │   ├── sub-01_ses-01_T1w.nii.gz
│       │   └── sub-01_ses-01_T1w.json
│       └── func/
│           ├── sub-01_ses-01_task-rest_bold.nii.gz
│           └── sub-01_ses-01_task-rest_bold.json
</pre>

# 2. Data preprocessing step

This repository contains a SLURM batch script used to preprocess resting-state fMRI data with fMRIPrep, executed within a Singularity container on an HPC cluster. The script prepares a specific subject (e.g., sub-98) by setting up directories, loading necessary modules, and running fMRIPrep with appropriate resource allocations and output specifications (MNI152NLin2009cAsym and fsLR spaces with CIFTI outputs).

## Key features:
- Configurable subject ID (SUB_ID variable).
- Automatic setup of output, working, and log directories.
- Outputs both volumetric (MNI space) and surface-based (fsLR) preprocessed data.
- Cleans up the intermediate working directory upon successful completion.
- Includes crash stopping, memory, and threading settings optimized for typical HPC environments.

## Requirements
- HPC cluster with SLURM workload manager.
- Singularity installed and accessible (module load singularity).
- fMRIPrep Singularity image (fmriprep.sif).
- BIDS-compliant input dataset.
- FreeSurfer license file.
  
## Useage
### 1. Prepare necessary files and directories:
- BIDS-formatted dataset directory.
- Singularity image file for fMRIPrep (fmriprep.sif).
- FreeSurfer license file (license.txt).
### 2. Edit the script:
- Set SUB_ID to the subject number you want to preprocess.
- Update paths (SIMG, BIDS_DIR, OUT_DIR, FS_LICENSE, WORK_DIR) to match your environment.
### 3. Submit the job:
sbatch fmriprep_sub98.sh
### 4. Outputs:
- Preprocessed outputs are saved to the designated output directory.
- Log files (.out, .err) are saved under the logs/ folder.
### 5. Post-processing:
- If successful, the subject’s temporary working directory is automatically deleted to save space.
