# st2
Speech Technologies

Assignment: Language Modeling 
Professor: José Adrián Rodríguez Fonollosa

### Objective
Hands-on study of the performance of different strategies for language modeling, the trade-off between model order/size and perplexity reduction and the influence of the type and size of the training corpus.

The recommended language modeling toolkit is the SRI LM toolkit
http://www.speech.sri.com/projects/srilm/

The training corpus can be freely selected from public data sources as http://www.statmt.org/wmt17/translation-task.html

You will have to tokenize and normalize the test and training corpus with the provided tokenizer script:
```
./tokenizer.perl -l en < newstest2016-deen-ref.en > newstest2016-deen-ref.en.tok
```
### Task description

- Download and install the SRI Language Modeling Toolkit
- Download training English corpus
- Obtain different language models with different methods and orders and training corpus sizes. You can also try different concatenations of corpus or corpus interpolation with the tool compute-best-mix http://www-speech.sri.com/projects/srilm/manpages/ppl-scripts.1.html
- Evaluate your language models with the ngram program and the test corpus
- Prepare 2-4 pages report in article format. Show your results in tables and graphs. Include the commands used to obtain the best language model and to measure the perpelxity of this model on the test corpus
