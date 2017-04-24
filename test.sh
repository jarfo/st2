#!/bin/bash

./tokenizer.perl -l en < newstest2016-deen-ref.en > newstest2016-deen-ref.en.tok
./tokenizer.perl -l en < newstest2015-deen-ref.en > newstest2015-deen-ref.en.tok

corpora="news-commentary-v12.en news.2015.en.shuffled"

for corpus in $corpora; do
  if [ ! -f $corpus.tok ]; then
    wget http://data.statmt.org/wmt17/translation-task/$corpus.gz
    gunzip -c $corpus.gz | ./tokenizer.perl -l en > $corpus.tok
  fi
done

for corpus in $corpora; do
  ngram-count -order 4 -text $corpus.tok -lm $corpus.4.arpa
  ngram -order 4 -lm $corpus.4.arpa -ppl newstest2016-deen-ref.en.tok
  ngram -order 4 -lm $corpus.4.arpa -ppl newstest2015-deen-ref.en.tok -debug 2 > $corpus.4.ppl
done

devppl=""
for corpus in $corpora; do
  devppl="$devppl $corpus.4.ppl"
done
compute-best-mix $devppl
