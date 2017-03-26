# Speech Technologies. Universitat Politècnica de Catalunya

Assignment: Language Modeling  
Professor: José Adrián Rodríguez Fonollosa

### Objective
Hands-on study of the performance of different strategies for language modeling, the trade-off between model order/size and perplexity reduction and the influence of the type and size of the training corpus.

The recommended language modeling toolkit is the SRI LM toolkit
http://www.speech.sri.com/projects/srilm/

The training corpus can be freely selected from public data sources as http://www.statmt.org/wmt17/translation-task.html

You will have to tokenize and normalize the test (newstest2016-deen-ref.en), dev (newstest2015-deen-ref.en) and training corpus with the provided tokenizer script:
```
$ ./tokenizer.perl -l en < newstest2016-deen-ref.en > newstest2016-deen-ref.en.tok
$ ./tokenizer.perl -l en < newstest2015-deen-ref.en > newstest2015-deen-ref.en.tok
```
### Task description

- Clone this repository
```
$ git clone https://github.com/jarfo/st2.git
```
- Download and install the SRI Language Modeling Toolkit
- Download English corpora for training
- Obtain different language models with different methods, orders and training corpus sizes. You can also try different concatenations of corpus or corpus interpolation with the tool compute-best-mix http://www-speech.sri.com/projects/srilm/manpages/ppl-scripts.1.html  
Example:
```
$ ./tokenizer.perl -l en < train_a.en > train_a.en.tok
$ ./tokenizer.perl -l en < train_b.en > train_b.en.tok
$ ngram-count -order 4 -text train_a.en.tok -lm model_a.arpa
$ ngram-count -order 4 -text train_b.en.tok -lm model_b.arpa
$ ngram -order 4 -lm model_a.arpa -ppl newstest2015-deen-ref.en.tok -debug 2 > model_a.ppl
$ ngram -order 4 -lm model_b.arpa -ppl newstest2015-deen-ref.en.tok -debug 2 > model_b.ppl
$ compute-best-mix model_a.ppl model_b.ppl
iteration 1, lambda = (0.5 0.5), ppl = 27.7627
iteration 2, lambda = (0.761282 0.238718), ppl = 22.7665
iteration 3, lambda = (0.85053 0.14947), ppl = 22.005
iteration 4, lambda = (0.882713 0.117287), ppl = 21.8698
iteration 5, lambda = (0.895449 0.104551), ppl = 21.8445
iteration 6, lambda = (0.900771 0.0992293), ppl = 21.8397
iteration 7, lambda = (0.903055 0.0969449), ppl = 21.8387
59749 non-oov words, best lambda (0.904048 0.0959522)
pairwise cumulative lambda (1 0.0959522)
$ ngram -order 4 -lm model_a.arpa -mix-lm model_b.arpa -lambda 0.9 -write-lm mymodel.arpa
```
- Evaluate your language models with the ngram program and the provided test corpus (newstest2016-deen-ref.en) in terms of perplexity and Out Of Vocabulary (OOV) words
```
$ ngram -lm mymodel.arpa -ppl newstest2016-deen-ref.en.tok
file newstest2016-deen-ref.en.tok: 2999 sentences, 64503 words, 2471 OOVs
0 zeroprobs, logprob= -173665 ppl= 468.275 ppl1= 630.39
```
- Prepare 2-4 pages report in article format. Show your results in tables and graphs. Include the commands used to obtain the best language model and to measure the perpelxity of this model on the test corpus
