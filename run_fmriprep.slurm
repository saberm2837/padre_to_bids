#!/bin/bash
#SBATCH --job-name=fmriprep_sub98
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --account=bgross
#SBATCH --partition=normal
#SBATCH --output=logs/fmriprep_sub98.out
#SBATCH --error=logs/fmriprep_sub98.err

SUB_ID=98
module load singularity

# Define paths
SIMG="/home/msaber/fates_rest/fmriprep.sif"
BIDS_DIR="/scratch/g/bgross/fates_rest/bids_data"
OUT_DIR="/scratch/g/bgross/fates_rest/fmriprep_out"
FS_LICENSE="/home/msaber/fates_rest/license.txt"
WORK_DIR="/scratch/g/bgross/fates_rest/fmriprep_work"

# Create logs and output directories if they don't exist
mkdir -p logs
mkdir -p $OUT_DIR
mkdir -p $WORK_DIR

# Run fMRIPrep
singularity run --cleanenv \
  -B $BIDS_DIR:/data \
  -B $OUT_DIR:/out \
  -B $FS_LICENSE:/opt/freesurfer/license.txt \
  -B $WORK_DIR:/work \
  $SIMG \
  /data /out participant \
  --participant-label sub-$SUB_ID \
  --nprocs 16 --nthreads 8 --omp-nthreads 4 --mem_mb 32000 \
  --output-spaces MNI152NLin2009cAsym:res-2 fsLR:den-32k \
  --random-seed 1234567890 \
  --fs-license-file /opt/freesurfer/license.txt \
  --work-dir /work \
  --stop-on-first-crash \
  --slice-time-ref 0 \
  --no-submm-recon \
  --cifti-output 91k
  
# Clean up only if successful
if [ $? -eq 0 ]; then
  rm -rf $WORK_DIR/sub-$SUB_ID
  echo "fMRIPrep completed successfully for sub-$SUB_ID at $(date)"
else
  echo "fMRIPrep failed for sub-$SUB_ID at $(date)"
fi
