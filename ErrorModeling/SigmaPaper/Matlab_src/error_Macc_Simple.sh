initial="
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  bash ./data.sh [Option] <Matlab file  path>                           #
#                                                                        #
#                                                                        #
#                                                                        #
#  Sample Command:                                                       #
#  bash ./data.sh ./dataGeneration_norm.m ./dataCalculation_norm.m       #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - June  2016  contact:aming@ece.ubc.ca                #
#------------------------------------------------------------------------#
"
#! /bin/bash
source /CMC/scripts/altera.15.1.sh
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\e[1;33m'

path1='${HOME_DIR}/approxiSynthesys/simulations'

filter='Error|Errors|ERRORS|ERROR|line|Fatal|failure|MathWorks|16384'
no='type|Sig'

dataGen=$1
dataCalc=$2
#------------------------------------------------------------------------
printf "\n${YELLOW}$initial${NC}\n\n"

#get files
echo 'data Generation file path'
echo $dataGen
echo 'data Calculation file path'
echo $dataCalc


printf  "DDDDXXXXXXXXXXXXXXXXXXXXXX ${RED}Date${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXDDDD\n"
outFile=$(date +"%F_%s")
echo  $outFile

#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------

cd ~ # harjayim berim sare jamun

startTime=`date +%s`
#------------------------------------------< 1 >---------------------------
printf  "MMMMXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab dataGen1${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXMMMM${RED}\n"
ls | grep -i '\.m'
printf  "${NC}\n\n\n\n\n${YELLOW}"
head  "$path1/dataGenMacc.m"
printf  "${NC}\n\n\n\n\n"
matlab -nojvm < "$path1/dataGenMacc.m"| grep -E $filter | grep -v $no
printf  "${NC}\n"
firstTime=`date +%s`


#------------------------------------------< 2 >---------------------------
printf  "IIIIXXXXXXXXXXXXXXXXXXXX ${RED}Simulation for ZA2${NC} XXXXXXXXXXXXXXXXXXXXXXXXXIIII\n"
cd ${HOME_DIR}/approxiSynthesys/benchmarks/custom/RCA/

${CMC_DIR}/tools/altera/15.1/modelsim_ae/bin/vsim -c -do "run -all" 'tb_matlab'| grep -E $filter| grep -v $no
printf  "${NC}\n"
thirdTime=`date +%s`

#------------------------------------------< 3 >---------------------------
printf  "MMMMXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab data Calc1${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXMMMM${RED}\n"
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$path1/dataCalcMacc.m"| grep -E $filter| grep -v $no
printf  "${NC}\n"
secondTime=`date +%s`



#------------------------------------------< 4 >---------------------------
printf  "SSSSXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab dataGen2${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXSSSS\n"
cd
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$path1/dataGenMacc2.m" | grep -E $filter | grep -v $no
printf  "${NC}\n"
forthTime=`date +%s`



#------------------------------------------< 5 >---------------------------
printf  "IIIIXXXXXXXXXXXXXXXXXXXX ${RED}Simulation for ZA3${NC} XXXXXXXXXXXXXXXXXXXXXXXXXIIII\n"
cd ${HOME_DIR}/approxiSynthesys/benchmarks/custom/RCA/

${CMC_DIR}/tools/altera/15.1/modelsim_ae/bin/vsim -c -do "run -all" 'tb_matlab'| grep -E $filter| grep -v $no
printf  "${NC}\n"
sixthTime=`date +%s`

#------------------------------------------< 6 >---------------------------
printf  "SSSSXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab dataCalc2${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXSSSS\n"
cd
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$path1/dataCalcMacc2.m"| grep -E $filter | grep -v $no
printf  "${NC}\n"
seventhTime=`date +%s`

#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------
endTime=`date +%s`

runTime=$((endTime-startTime))
printf  "Simulation Time is: ${GREEN}$runTime${NC} (s)\n\n" #| tee >(grep " " >>  ./temp/"$fileName._log.log" )
runTime=$((endTime-startTime))

_1=$((firstTime  - startTime))
_2=$((secondTime - firstTime))
_3=$((thirdTime  - secondTime))
_4=$((forthTime  - thirdTime))
_5=$((fifthTime  - forthTime))
_6=$((sixthTime  - fifthTime))
_7=$((seventhTime- sixthTime))
_8=$((endTime    - seventhTime))

printf  "Simulation breaktime: ${GREEN}[1]:$_1 [2]:$_2 [3]:$_3 [4]:$_4 \n[5]:$_5 [6]:$_6 [7]:$_7 [8]:$_8${NC} (s)\n\n"

#------------------------------------------------------------------------





