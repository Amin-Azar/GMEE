initial="
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /data/git/repos/ErrorModeling/Characterization/Files               #
#  bash ./data.sh [Option] <Matlab file  path>                           #
#                                                                        #
#                                                                        #
#  Sample Command:                                                       #
#  bash ./data.sh ./initP.m ./dataGeneration_norm.m                      #
#	./dataCalculation_norm.m                                         #
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

path1='/data/git/repos/ErrorModeling/Characterization/Files'

filter='Error\|Errors\|ERRORS\|ERROR\|line\|Fatal\|failure\|MathWorks\|16384\|MSG'
no='type\|Sig'

#if no input files => default
if [ $1 -eq '']
then
initP='./src/init.m'
else
initP=$1
fi

if [ $2 -eq '']
then
dataGen1='./src/dataGeneration_step1_norm.m'
else
dataGen1=$2
fi

if [ $3 -eq '']
then
sim1='tb_matlab'
else
sim1=$3
fi

if [ $4 -eq '']
then
dataCalc1='./src/dataCalculation_step1_norm.m'
else
dataCalc1=$4
fi

if [ $5 -eq '']
then
dataGen2='./src/dataGeneration_step2_norm.m'
else
dataGen2=$5
fi


if [ $6 -eq '']
then
sim2='tb_matlab_reg'
else
sim2=$6
fi

if [ $7 -eq '']
then
dataCalc2='./src/dataCalculation_step2_norm.m'
else
dataCalc2=$7
fi

#------------------------------------------------------------------------
printf "\n${YELLOW}$initialize${NC}\n\n"

#print input files

echo 'parameter initialization file:'
echo $initP

echo 'data Generation step1 file:'
echo $dataGen
echo 'simulation file step1 file:'
echo $sim1
echo 'data Calculation step1 file:'
echo $dataCalc

echo 'data Generation step2 file:'
echo $dataGen2
echo 'simulation file step2 file:'
echo $sim2
echo 'data Calculation step2 file:'
echo $dataCalc2

printf  "DDDDXXXXXXXXXXXXXXXXXXXXXX ${RED}Date${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXDDDD\n"
outFile=$(date +"%F_%s")
echo  $outFile

#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------

cd $path1 # harjayim berim sare jamun

startTime=`date +%s`
#------------------------------------------< 1 >---------------------------
printf  "MMMMXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab initialize${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXMMMM${RED}\n"
ls | grep -i '\.m'
printf  "${NC}\n\n\n\n\n${YELLOW}"
cat  "$initP"
printf  "${NC}\n\n\n\n\n"
matlab -nojvm < "$initP"| grep -E $filter | grep -v $no
printf  "${NC}\n"
firstTime=`date +%s`
#------------------------------------------< 2 >---------------------------
printf  "MMMMXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab data Generation1${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXMMMM${RED}\n"
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$dataGen1"| grep -E $filter| grep -v $no
printf  "${NC}\n"
secondTime=`date +%s`





#------------------------------------------< 3 >---------------------------
printf  "IIIIXXXXXXXXXXXXXXXXXXXX ${RED}Simulation for EM_in${NC} XXXXXXXXXXXXXXXXXXXXXXXXXIIII\n"
cd ${HOME_DIR}-slow/approxiSynthesys/benchmarks/custom/RCA/
${CMC_DIR}/tools/altera/15.1/modelsim_ae/bin/vlog {CLA4.v,CGEN.v,RCA.v,H_FA.v,ETA.v,TTA.v,ETAIIM.v,tb_matlab.v}| grep -E $filter| grep -v $no # filan faghat in dotaro gozashtam
${CMC_DIR}/tools/altera/15.1/modelsim_ae/bin/vsim -c -do "run -all" $sim1 | grep -E $filter| grep -v $no
printf  "${NC}\n"
thirdTime=`date +%s`


#------------------------------------------< 4 >---------------------------
printf  "SSSSXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab data Calculation1${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXSSSS\n"
cd $path1
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$dataCalc1" | grep -E $filter | grep -v $no
printf  "${NC}\n"
forthTime=`date +%s`

#------------------------------------------< 5 >---------------------------
printf  "MMMMXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab data Generation2${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXMMMM${RED}\n"
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$dataGen2"| grep -E $filter| grep -v $no
printf  "${NC}\n"
fifthTime=`date +%s`





#------------------------------------------< 6 >---------------------------
printf  "IIIIXXXXXXXXXXXXXXXXXXXX ${RED}Simulation for EM_z${NC} XXXXXXXXXXXXXXXXXXXXXXXXXIIII\n"
cd ${HOME_DIR}-slow/approxiSynthesys/benchmarks/custom/RCA/
${CMC_DIR}/tools/altera/15.1/modelsim_ae/bin/vsim -c -do "run -all" $sim2 | grep -E $filter| grep -v $no
printf  "${NC}\n"
sixthTime=`date +%s`

#------------------------------------------< 7 >---------------------------
printf  "SSSSXXXXXXXXXXXXXXXXXXXXXX ${RED}Matlab data Calculation2${NC} XXXXXXXXXXXXXXXXXXXXXXXXXXXSSSS\n"
cd $path1
#ls | grep -i '\.txt'
printf  "${NC}\n"
matlab -nojvm < "$dataCalc2"| grep -E $filter | grep -v $no
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





