#!/bin/bash
LOCALES='en af id'

if [ $1 ]; then
  LOCALES=$1
fi

for LOCALE in $LOCALES
do
  for POFILE in `ls i18n/${LOCALE}/LC_MESSAGES/*.po`
  do
    MOFILE=i18n/${LOCALE}/LC_MESSAGES/`basename ${POFILE}`.mo
    # Compile the translated strings
    echo "Compiling messages to ${MOFILE}"
    RESULT=`msgfmt --statistics -o ${MOFILE} ${POFILE}`
  done

  # Compile the html docs for that locale
  sphinx-build -D language=${LOCALE} -b html . _build/html/${LOCALE}

  # Compile the latex docs for that locale
  #sphinx-build -D language=${LOCALE} -b latex . _build/latex/${LOCALE}

  # Compile the pdf docs for that locale
  #sphinx-build -D language=${LOCALE} -b latexpdf . _build/pdf/${LOCALE}
done
