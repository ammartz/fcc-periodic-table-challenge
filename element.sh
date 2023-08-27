#!/bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  REG='^[0-9]+$'
  if [[ $1 =~ $REG ]]
    then
    AT_N=$1
    NAME="$($PSQL "select name from elements where atomic_number = $1")"
    SYMBOL="$($PSQL "select symbol from elements where atomic_number = $1")"
    TYPE="$($PSQL "select types.type from properties inner join types using(type_id) where properties.atomic_number = $1")"
    MASS="$($PSQL "select atomic_mass from properties where atomic_number = $1")"
    M_P="$($PSQL "select melting_point_celsius from properties where atomic_number = $1")"
    B_P="$($PSQL "select boiling_point_celsius from properties where atomic_number = $1")"
    if [[ -z $NAME ]]
      then
      echo "I could not find that element in the database."
      else
      echo "The element with atomic number $AT_N is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
    fi
    
    else
    if [[ ${#1} > 2 ]]
    then
      NAME=$1
      AT_N="$($PSQL "select atomic_number from elements where name = '$1'")"
      SYMBOL="$($PSQL "select symbol from elements where name = '$1'")"
      TYPE="$($PSQL "select types.type from properties inner join types using(type_id) where properties.atomic_number = $AT_N")"
      MASS="$($PSQL "select atomic_mass from properties where atomic_number = $AT_N")"
      M_P="$($PSQL "select melting_point_celsius from properties where atomic_number = $AT_N")"
      B_P="$($PSQL "select boiling_point_celsius from properties where atomic_number = $AT_N")"
      if [[ -z $AT_N ]]
      then
      echo "I could not find that element in the database."
      else
      echo "The element with atomic number $AT_N is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
    fi

    else 
      SYMBOL=$1
      NAME="$($PSQL "select name from elements where symbol = '$1'")"
      AT_N="$($PSQL "select atomic_number from elements where name = '$NAME'")"
      TYPE="$($PSQL "select types.type from properties inner join types using(type_id) where properties.atomic_number = $AT_N")"
      MASS="$($PSQL "select atomic_mass from properties where atomic_number = $AT_N")"
      M_P="$($PSQL "select melting_point_celsius from properties where atomic_number = $AT_N")"
      B_P="$($PSQL "select boiling_point_celsius from properties where atomic_number = $AT_N")"
      if [[ -z $AT_N ]]
      then
      echo "I could not find that element in the database."
      else
      echo "The element with atomic number $AT_N is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
    fi
    fi
  fi
  
  
fi

