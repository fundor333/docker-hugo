for WORD in $(cat branches); do
  echo git tag v$WORD $WORD
  command git tag v$WORD $WORD
done
