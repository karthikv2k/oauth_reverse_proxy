pushd /tmp
git clone https://github.com/vouch/vouch-proxy
pushd vouch-proxy
git checkout artagel-add_support_to_pass_tokens
docker build . -t vouch-proxy
popd
rm -rf vouch-proxy
popd
