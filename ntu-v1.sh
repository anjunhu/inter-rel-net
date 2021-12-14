#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=1:00:00

module load StdEnv/2018 
module load python/3.6.3 
P2REPO='/home/anjunhu/projects/def-mudl/anjunhu/inter-rel-net'
source /home/anjunhu/projects/def-mudl/anjunhu/env/bin/activate

# NTU-V1
mkdir $SLURM_TMPDIR/nturgbd_skeletons
cp /home/rohitram/projects/def-mudl/rohitram/nturgbd_skeletons/skl.npy $SLURM_TMPDIR/nturgbd_skeletons
cp /home/rohitram/projects/def-mudl/rohitram/nturgbd_skeletons/descs.csv $SLURM_TMPDIR/nturgbd_skeletons

# joint/temp
# python3 $P2REPO/src/run_protocol.py final_temp_rel_ave_v1 $P2REPO/configs/NTU-V1/final/final_temp_rel_ave.cfg NTU -n 5 -v 2

# joint_lstm/temp_lstm
# python3 $P2REPO/src/run_protocol.py final_joint_no_rel_att_lstm_v1 $P2REPO/configs/NTU-V1/final/lstm/final_joint_no_rel_att_lstm.cfg NTU -n 5 -t -v 2 -f cross_subject

# IRN
# python3 $P2REPO/src/run_protocol.py IRN_final_rel_att_after_v1 $P2REPO/configs/NTU-V1/final/IRN_final_rel_att_after.cfg NTU -F middle -n 5 -v 2 -f cross_view

# IRN_lstm
python3 $P2REPO/src/run_protocol.py IRN_final_no_rel_ave_after_lstm_v1 $P2REPO/configs/NTU-V1/final/lstm/IRN_final_no_rel_ave_after_lstm.cfg NTU -t -F middle -n 5 -v 2 -f cross_view

# Copy models to scratch from compute node 
cp -r $SLURM_TMPDIR/models $P2REPO/my_models
