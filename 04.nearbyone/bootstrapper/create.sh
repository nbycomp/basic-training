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

yq e -n -P '{ "placement": {"site": {"label": "placeholder" } }}' > values.yaml



cdcount=`yq e '.ChartDeployments | length' $RES`
if [ $cdcount -ne 0 ]; then
cdtop=`expr $cdcount - 1`
  echo "Processing $cdcount ChartDeployment objects"
  for cdi in `seq 0 $cdtop`; do
    echo ".. Processing item #$cdi"

    echo "`yq e '.ChartDeployments['$cdi'] | { "ChartDeployment": . } | .ChartDeployment.enabled = "true"'  $RES `" > tmpvalues.yaml
    #cat tmpvalues.yaml

    helm template $SAMPLES -f tmpvalues.yaml > templates/chart_deployment_$cdi.yaml

    rm -rf tmpvalues.yaml

    name=`yq e '.ChartDeployments['$cdi'].name' $RES`
    yq e -n -P '{ "deployments":
                  {"'$name'":
                    {
                      "configuration":
                      {
                        "chart": "fill",
                        "version": "fill",
                        "repo": {
                          "url": "fill"
                        }
                      },
                      "variables": null,
                      "values": ""
                    }
                  }
                }' > localvalues.yaml

    cp values.yaml invalues.yaml
    yq '. *= load("invalues.yaml")' localvalues.yaml > values.yaml

    rm -rf localvalues.yaml
    rm -rf invalues.yaml
  done
fi

cscount=`yq e '.ConnectionSets | length' $RES`
if [ $cscount -ne 0 ]; then
  cstop=`expr $cscount - 1`
  echo "Processing $cscount ConnectionSet objects"
  for cdi in `seq 0 $cstop`; do
    echo ".. Processing item #$csi"

    echo "`yq e '.ConnectionSets['$csi'] | { "ConnectionSet": . } | .ConnectionSet.enabled = "true"'  $RES `" > tmpvalues.yaml
    #cat tmpvalues.yaml

    helm template $SAMPLES -f tmpvalues.yaml > templates/connection_set_$csi.yaml

    rm -rf tmpvalues.yaml
  done
fi

cacount=`yq e '.ConnectionAggregators | length' $RES`
if [ $cacount -ne 0 ]; then
  catop=`expr $cacount - 1`
  echo ".. Processing $cacount ConnectionSet objects"
  for cai in `seq 0 $catop`; do
    echo "Processing item #$cai"

    echo "`yq e '.ConnectionAggregators['$cdi'] | { "ConnectionAggregator": . } | .ConnectionAggregator.enabled = "true"'  $RES `" > tmpvalues.yaml
    #cat tmpvalues.yaml

    helm template $SAMPLES -f tmpvalues.yaml > templates/connection_aggregator_$cai.yaml

    rm -rf tmpvalues.yaml
  done
fi

mv * $OUT

cd $SRC

rm -rf $TMP
rm -rf $SAMPLES
