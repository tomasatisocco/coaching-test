tryPubGet(){
  {
    pubGet $1
  } || {
    echo "Retrying pub get for $1"
    pubGet $1
  } || {
    echo "Failed to get packages for $1"
  }
}

pubGet(){
  {
    {
    flutter pub get
    } &> /dev/null
    echo "Packages for $1 ✔️"
  } &
  cd ../../
}

podUpdate(){
  {
    find ios -name "Podfile.lock" | xargs rm
    cd ios
    pod repo update
    pod install
    cd ../
  } &> /dev/null
  echo "Pod updated ✔️" &
}

find . -name "pubspec.lock" | xargs rm
start=`date +%s`
echo "Getting packages..."

if [[ $OSTYPE == 'darwin'* ]]; then
  podUpdate
fi
for package in ./packages/**/pubspec.yaml
do
  cd $(dirname $package)
  # Replace the ./packages/ and /pubspec.yaml with nothing
  packageName=${package//.\/packages\//}
  packageName=${packageName//\/pubspec.yaml/}
  tryPubGet $packageName
done
tryPubGet "coaching"

wait

end=`date +%s`
runtime=$((end-start))
echo "Done in $runtime seconds"
wait