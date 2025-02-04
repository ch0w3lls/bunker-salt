#!/bin/bash -x

for number in {{ numbers }}; do
	ssh -i ~/.ssh/bunker admin@10.0.4.1 "/tool sms send port=lte1 ${number} message=\"Hello this is chris\""
done
