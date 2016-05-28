#!/bin/bash

set -o nounset
set -o errexit

VERBOSE_MODE=0

function error_handler()
{
  local STATUS=${1:-1}
  [ ${VERBOSE_MODE} == 0 ] && exit ${STATUS}
  echo "Exits abnormally at line "`caller 0`
  exit ${STATUS}
}
trap "error_handler" ERR

PROGNAME=`basename ${BASH_SOURCE}`
DRY_RUN_MODE=0

function print_usage_and_exit()
{
  set +x
  local STATUS=$1
  echo "Usage: ${PROGNAME} [-v] [-v] [--dry-run] [-h] [--help]"
  echo ""
  echo " Options -"
  echo "  -v                 enables verbose mode 1"
  echo "  -v -v              enables verbose mode 2"
  echo "      --dry-run      show what would have been dumped"
  echo "  -h, --help         shows this help message"
  exit ${STATUS:-0}
}

function debug()
{
  if [ "$VERBOSE_MODE" != 0 ]; then
    echo $@
  fi
}

GETOPT=`getopt -o vh --long dry-run,help -n "${PROGNAME}" -- "$@"`
if [ $? != 0 ] ; then print_usage_and_exit 1; fi

eval set -- "${GETOPT}"

while true
do case "$1" in
     -v)            let VERBOSE_MODE+=1; shift;;
     --dry-run)     DRY_RUN_MODE=1; shift;;
     -h|--help)     print_usage_and_exit 0;;
     --)            shift; break;;
     *) echo "Internal error!"; exit 1;;
   esac
done

if (( VERBOSE_MODE > 1 )); then
  set -x
fi


# template area is ended.
# -----------------------------------------------------------------------------
if [ ${#} != 0 ]; then print_usage_and_exit 1; fi

# current dir of this script
CDIR=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE[0]})))
PDIR=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE[0]}))/..)

# -----------------------------------------------------------------------------
# functions

function make_calmness()
{
	exec 3>&2 # save 2 to 3
	exec 2> /dev/null
}

function revert_calmness()
{
	exec 2>&3 # restore 2 from previous saved 3(originally 2)
}

function close_fd()
{
	exec 3>&-
}

function jumpto
{
	label=$1
	cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
	eval "$cmd"
	exit
}


# end functions
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# main 

make_calmness
if (( VERBOSE_MODE > 1 )); then
	revert_calmness
fi

python=/usr/bin/python

if [ ! -e ${CDIR}/results ]; then
	mkdir ${CDIR}/results
fi

cd ${CDIR}/sejong
./split.sh
./c2d.sh
cd ${CDIR}

${python} ${CDIR}/bist-parser/barchybrid/src/parser.py \
		--cnn-seed 123456789 \
		--outdir ${CDIR}/results \
		--train ${CDIR}/sejong/deptree.txt.v3.training \
		--dev ${CDIR}/sejong/deptree.txt.v3.tuning \
		--test ${CDIR}/sejong/deptree.txt.v3.test \
		--epochs 30 \
		--lstmdims 125 \
		--lstmlayers 2 \
		--bibi-lstm \
		--k 3 \
		--usehead \
		--userl

function evaluate_parser_by_eoj {
	for SET in training tuning test; do
		cut -f8 ${CDIR}/sejong/wdir/deptree.txt.v3.${SET} > ${CDIR}/sejong/wdir/deptree.txt.v3.${SET}.deprel
		paste ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus ${CDIR}/sejong/wdir/deptree.txt.v3.${SET}.deprel > ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus-add
		${python} ${CDIR}/sejong/align_r.py < ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus-add > ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus-eoj
		${python} ${CDIR}/sejong/eval.py -a ${CDIR}/sejong/wdir/deptree.txt.v2.${SET} -b ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus-eoj \
			> ${TMP_DIR}/brain_parser/greedy/${LP_PARAMS}/parsed-${SET}-corpus-eoj-ret
	done
}


close_fd

# end main
# -----------------------------------------------------------------------------
