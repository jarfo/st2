#!/bin/bash

./tokenizer.perl -l en < newstest2016-deen-ref.en > newstest2016-deen-ref.en.tok
./tokenizer.perl -l en < newstest2015-deen-ref.en > newstest2015-deen-ref.en.tok

corpora="
  http://data.statmt.org/wmt17/translation-task/news-commentary-v12.en.gz
  http://data.statmt.org/wmt16/translation-task/news.2015.en.shuffled.gz
"

for url in $corpora; do
  corpus=`basename $url`
  corpus=${corpus%.*}
  if [ ! -f $corpus.tok ]; then
    wget $url 
    gunzip -c $corpus.gz | ./tokenizer.perl -l en > $corpus.tok
  fi
done

for url in $corpora; do
  corpus=`basename $url`
  corpus=${corpus%.*}
  ngram-count -order 4 -text $corpus.tok -lm $corpus.4.arpa
  ngram -order 4 -lm $corpus.4.arpa -ppl newstest2016-deen-ref.en.tok
  ngram -order 4 -lm $corpus.4.arpa -ppl newstest2015-deen-ref.en.tok -debug 2 > $corpus.4.ppl
done

devppl=""
for url in $corpora; do
  corpus=`basename $url`
  corpus=${corpus%.*}
  devppl="$devppl $corpus.4.ppl"
done
compute-best-mix $devppl

ngram -order 4 -lm news.2015.en.shuffled.4.arpa -mix-lm news-commentary-v12.en.4.arpa -lambda 0.92 -ppl newstest2016-deen-ref.en.tok
