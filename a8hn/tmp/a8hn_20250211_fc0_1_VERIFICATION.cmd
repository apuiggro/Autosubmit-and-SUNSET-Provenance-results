#!/bin/bash

###############################################################################
#                   VERIFICATION a8hn EXPERIMENT
###############################################################################
#
#SBATCH --qos=gp_bsces
#
#
#SBATCH -A bsc32
#
#
#SBATCH --cpus-per-task=1
#
#SBATCH -n 4
#
#
#SBATCH -t 03:00:00
#SBATCH -J a8hn_20250211_fc0_1_VERIFICATION
#SBATCH --output=/gpfs/scratch//bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_20250211_fc0_1_VERIFICATION.cmd.out.0
#SBATCH --error=/gpfs/scratch//bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_20250211_fc0_1_VERIFICATION.cmd.err.0
#SBATCH --exclusive
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
job_name_ptrn='/gpfs/scratch/bsc32/bsc032533/a8hn/LOG_a8hn/a8hn_20250211_fc0_1_VERIFICATION'
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
projdir=/esarchive/autosubmit/a8hn/proj/auto-s2s
outdir=/esarchive/scratch/apuiggro/sunset_MR/sunset/outputs/ex1_4-recipe_20250211112138
tmpdir=/gpfs/scratch/bsc32/bsc032533/tmp/
script=./use_cases/ex1_4_provenance_autosubmit/ex1_4-script.R
CHUNK=1
###############################

if [ -d $projdir ]; then
  cd $projdir
  srcdir=${outdir}
else
  cd ${tmpdir}/sunset/$(basename ${outdir})/
  srcdir=${tmpdir}/$(basename ${outdir})
fi

source chunk_to_recipe

atomic_recipe=${srcdir}/logs/recipes/atomic_recipe_${recipe}.yml

set +eu
source MODULES
set -eu

Rscript ${script} ${atomic_recipe}

###################
# Autosubmit tailer
###################
set -xuve
echo $(date +%s) >> ${job_name_ptrn}_STAT
touch ${job_name_ptrn}_COMPLETED
exit 0

