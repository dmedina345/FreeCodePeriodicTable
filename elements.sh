
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then
if [[ $1 =~ [0-9]+ ]]
then
ATOMIC_NUMBER=$1
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
if [[ -z $SYMBOL ]]
then
echo "I could not find that element in the database."
else
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
echo "$PROPERTIES" | while IFS="|" read ATOMIC_MASS MELTING_POINT BOILING_POINT
do
echo "The element with atomic number "$ATOMIC_NUMBER "is "$NAME "("$SYMBOL"). It's a $TYPE, with a mass of "$ATOMIC_MASS" amu. $NAME has a melting point of "$MELTING_POINT" celsius and a boiling point of "$BOILING_POINT" celsius."
done
fi
else
if [[ ${#1} -le 2 ]]
then
SYMBOL=$1
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL'")
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
else
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
echo "$PROPERTIES" | while IFS="|" read ATOMIC_MASS MELTING_POINT BOILING_POINT
do
echo "The element with atomic number "$ATOMIC_NUMBER "is "$NAME "("$SYMBOL"). It's a $TYPE, with a mass of "$ATOMIC_MASS" amu. $NAME has a melting point of "$MELTING_POINT" celsius and a boiling point of "$BOILING_POINT" celsius."
done
fi
else
NAME=$1
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME'")
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
else
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
echo "$PROPERTIES" | while IFS="|" read ATOMIC_MASS MELTING_POINT BOILING_POINT
do
echo "The element with atomic number "$ATOMIC_NUMBER "is "$NAME "("$SYMBOL"). It's a "$TYPE", with a mass of "$ATOMIC_MASS" amu. "$NAME" has a melting point of "$MELTING_POINT" celsius and a boiling point of "$BOILING_POINT" celsius."
done
fi
fi
fi
else
echo "Please provide an element as an argument."
fi
