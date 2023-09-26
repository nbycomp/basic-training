SRC=$PWD
OUT=$SRC/output
TMP=$SRC/temp
BPNAME=boilerplate
TEMPLATES=templates
NAME=foo #$1
RES=$SRC/resources.yaml
HELPERS=$SRC/helpers
SAMPLES=$TMP/templates

rm -rf $OUT
mkdir $OUT

rm -rf $TMP
mkdir $TMP

cd $TMP

tar xzf $HELPERS/$BPNAME.tgz
tar xzf $HELPERS/$TEMPLATES.tgz

cd $BPNAME

cdcount=`yq e '.ChartDeployments | length' $RES`
cdtop=`expr $cdcount - 1`
echo "Processing $cdcount ChartDeployment objects"
for cdi in `seq 0 $cdtop`; do
  echo "going with $cdi"

  echo "`yq e '.ChartDeployments['$cdi'] | { "ChartDeployment": . } | .ChartDeployment.enabled = "true"'  $RES `" > tmpvalues.yaml
  cat tmpvalues.yaml

  helm template $SAMPLES -f tmpvalues.yaml > templates/chart_deployment_$cdi.yaml

  rm -rf tmpvalues.yaml
done


cscount=`yq e '.ConnectionSets | length' $RES`
cstop=`expr $cscount - 1`
echo "Processing $cscount ConnectionSet objects"
for cdi in `seq 0 $cstop`; do
  echo "going with $csi"

  echo "`yq e '.ConnectionSets['$csi'] | { "ConnectionSet": . } | .ConnectionSet.enabled = "true"'  $RES `" > tmpvalues.yaml
  cat tmpvalues.yaml

  helm template $SAMPLES -f tmpvalues.yaml > templates/connection_set_$csi.yaml

  rm -rf tmpvalues.yaml
done


cacount=`yq e '.ConnectionAggregators | length' $RES`
catop=`expr $cacount - 1`
echo "Processing $cacount ConnectionSet objects"
for cai in `seq 0 $catop`; do
  echo "going with $cai"

  echo "`yq e '.ConnectionAggregators['$cdi'] | { "ConnectionAggregator": . } | .ConnectionAggregator.enabled = "true"'  $RES `" > tmpvalues.yaml
  cat tmpvalues.yaml

  helm template $SAMPLES -f tmpvalues.yaml > templates/connection_aggregator_$cai.yaml

  rm -rf tmpvalues.yaml
done


mv * $OUT

cd $SRC

rm -rf $TMP
rm -rf $SAMPLES
