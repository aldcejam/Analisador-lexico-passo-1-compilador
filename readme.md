## Passos para analisar código

### Executar:
- 1 ``flex analisador.l`` (gera o arquivo lex.yy.c)
- 2 ``gcc lex.yy.c`` (gera executável a.out)
- 3 ``./a.out < exemplo.txt`` (executa o analisador léxico)