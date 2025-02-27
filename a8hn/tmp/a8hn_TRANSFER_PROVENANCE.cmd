#!/bin/bash

###############################################################################
#                   TRANSFER_PROVENANCE a8hn EXPERIMENT
###############################################################################
#
#
#
#
#SBATCH -A bsc32
#
#SBATCH --cpus-per-task=1
#
#
#SBATCH -n 1
#
#SBATCH -t 00:10:00
#SBATCH -J a8hn_TRANSFER_PROVENANCE
#SBATCH --output=/gpfs/scratch//bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_TRANSFER_PROVENANCE.cmd.out.0
#SBATCH --error=/gpfs/scratch//bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_TRANSFER_PROVENANCE.cmd.err.0

#
#
###############################################################################
###################
# Autosubmit header
###################
locale_to_set=$(locale -a | grep ^C.)
if [ -z "$locale_to_set" ] ; then
    # locale installed...
    export LC_ALL=$locale_to_set
else
    # locale not installed...
    locale_to_set=$(locale -a | grep ^en_GB.utf8)
    if [ -z "$locale_to_set" ] ; then
        export LC_ALL=$locale_to_set
    else
        export LC_ALL=C
    fi 
fi

set -xuve
job_name_ptrn='/gpfs/scratch/bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_TRANSFER_PROVENANCE'
echo $(date +%s) > ${job_name_ptrn}_STAT

################### 
# AS CHECKPOINT FUNCTION
###################
# Creates a new checkpoint file upon call based on the current numbers of calls to the function

AS_CHECKPOINT_CALLS=0
function as_checkpoint {
    AS_CHECKPOINT_CALLS=$((AS_CHECKPOINT_CALLS+1))
    touch ${job_name_ptrn}_CHECKPOINT_${AS_CHECKPOINT_CALLS}
}

###################
# Autosubmit job
###################

#!/bin/bash

############ AUTOSUBMIT INPUTS ############
outdir=/esarchive/scratch/apuiggro/sunset_MR/sunset/outputs/ex1_4-recipe_20250211112138
expid=a8hn
###############################

#JSON directory
dir1=/esarchive/autosubmit/${expid}/tmp/$(basename ${outdir})/outputs/provenance

destdir1=/gpfs/archive/bsc32/${dir1}

#Recipes directory
dir2=/esarchive/autosubmit/${expid}/tmp/$(basename ${outdir})/logs/recipes

destdir2=/gpfs/archive/bsc32/${dir2}

#Create directories and copy files
mkdir -p ${destdir1}

cp -r /gpfs/archive/bsc32/${outdir}/outputs/provenance/* ${destdir1}

mkdir -p ${destdir2}

cp -r /gpfs/archive/bsc32/${outdir}/logs/recipes/* ${destdir2}
###################
# Autosubmit tailer
###################
set -xuve
echo $(date +%s) >> ${job_name_ptrn}_STAT
touch ${job_name_ptrn}_COMPLETED
exit 0

