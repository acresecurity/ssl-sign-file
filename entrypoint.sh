#!/bin/sh -l

filepath=$1
sslusername=$2
sslpassword=$3
sslsecretpassword=$4
sslclientid=$5
istest=$6

apt-get -qq update

echo "Installing JavaRuntime Environment"
apt-get install -y -qq default-jre > /dev/null

codeSignDir=$(ls | grep -w CodeSignTool-v*)

if [ -z "$codeSignDir" ] || [ ! -d ${codeSignDir} ]; then

    echo "-----INSTALLING CURL------"
    apt-get -y install curl

    echo "Installing unzip"
    apt-get install -y unzip

    echo "Downloading CodeSignTool"
    curl https://www.ssl.com/download/codesigntool-for-linux-and-macos/ --output CodeSignTool.zip
    echo "Extracting CodeSignTool"
    unzip -o CodeSignTool.zip
    echo "Extracting Complete"

    codeSignDir=$(ls | grep -w CodeSignTool-v*)
    echo "codeSignDirectory 1: ${codeSignDir}"

    if [ -z "$codeSignDir" ] || [ ! -d ${codeSignDir} ]; then
      echo "Unzipping to CodeSignTool-vFeenics"
      unzip -o CodeSignTool.zip -d CodeSignTool-vFeenics
    fi

    codeSignDir=$(ls | grep -w CodeSignTool-v*)
    echo "codeSignDirectory 2: ${codeSignDir}"

    if [ -z "$codeSignDir" ] || [ ! -d ${codeSignDir} ]; then
      echo "Using locally stored code sign tool"
      unzip -o LocalCodeSignTool.zip -d CodeSignTool-vLocalFeenics
    fi

    codeSignDir=$(ls | grep -w CodeSignTool-v*)
    echo "codeSignDirectory 3: ${codeSignDir}"

    cd ${codeSignDir}
    mkdir -p "ssl-output"
else
    codeSignDir=$(ls | grep -w CodeSignTool-v*)
    cd ${codeSignDir}
fi

export CODE_SIGN_TOOL_PATH="."

if [ ${istest} = true ] ; then
  # TESTING ONLY - Sandbox creds
  echo "Running Test"
  printf "CLIENT_ID=${sslclientid}\nOAUTH2_ENDPOINT=https://oauth-sandbox.ssl.com/oauth2/token\nCSC_API_ENDPOINT=https://cs-try.ssl.com\nTSA_URL=http://ts.ssl.com" > 'conf/code_sign_tool.properties'
  bash CodeSignTool.sh sign -username='esigner_demo' -password='esignerDemo#1' -totp_secret='RDXYgV9qju+6/7GnMf1vCbKexXVJmUVr+86Wq/8aIGg=' -input_file_path="${filepath}" -output_dir_path='ssl-output'
else
  # SINGLE FILE
  echo "Running Real UseCase"
  printf "CLIENT_ID=${sslclientid}\nOAUTH2_ENDPOINT=https://login.ssl.com/oauth2/token\nCSC_API_ENDPOINT=https://cs.ssl.com\nTSA_URL=http://ts.ssl.com" > 'conf/code_sign_tool.properties'
  bash CodeSignTool.sh sign -username="${sslusername}" -password="${sslpassword}" -totp_secret="${sslsecretpassword}" -input_file_path="${filepath}" -output_dir_path='ssl-output'
fi

echo "Copying Signed File to root"
ls ssl-output/
cp -r ./ssl-output/* ../

