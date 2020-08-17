initial="
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /data/git/repos/ErrorModeling/Characterization/Files               #
#  bash ./initRemoteSim.sh                                               #
#                                                                        #
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - June  2016  contact:aming@ece.ubc.ca                #
#------------------------------------------------------------------------#
"
#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\e[1;33m'

origFiles='/data/git/repos/benchmarks/custom/RCA'
workFolder='${HOME_DIR}/tmp/modelsim/simulations'
tmpFolder='/data/tmp'


cp $origFiles/*.v 			$workFolder
#cp $origFiles/tb_matlab.v 		$workFolder
#cp $origFiles/tb_matlab_reg.v 		$workFolder

cp $tmpFolder/out_MAT/in_data.txt	$workFolder


#------------------------------------------------------------------------





