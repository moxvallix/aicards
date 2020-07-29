#!/bin/bash

#VARIABLES
VER="1.2"
DATE=$(date '+%Y-%m-%d-%H-%M')
MAX=5


#STARTUP
echo "Materials generator for AI card game (CSV)"
echo "V$VER by Alexander Khoo"

#CARD GENERATION (CHANGE LAST NUMBER FOR CARD AMOUNT)
for i in {1..45}
do
#RESETTING VARS
    ROLLS=9
    LOOP=0
    SLOT1=0
    SLOT2=0
    SLOT3=0
    PAPER=0
    REEDS=0
    STRING=0
    GOLD=0
    CRYSTAL=0
    while (($LOOP != $ROLLS))
    do
        RAND=$(shuf -i1-20 -n1)
            case $RAND in
                1|2|3|4|5) ((PAPER++)); TYPE=1;;
                6|7|8|9|10) ((REEDS++)); TYPE=2;;
                11|12|13|14) ((STRING++)); TYPE=3;;
                15|16|17) ((GOLD++)); TYPE=4;;
                18|19|20) ((CRYSTAL++)); TYPE=5;;
            esac
        ((N++))
            if (($SLOT1 == 0)) && (($SLOT1 != $TYPE))
                then
                SLOT1=$TYPE
            elif (($SLOT2 == 0)) && (($SLOT1 != $TYPE))
                then
                SLOT2=$TYPE
            elif (($SLOT3 == 0)) && (($SLOT1 != $TYPE))
                then
                SLOT3=$TYPE
            fi
        ((LOOP++))

            if (($SLOT1 != 0 && $SLOT2 != 0 && $SLOT3 != 0)) && (($TYPE != $SLOT1 && $TYPE != $SLOT2 && $TYPE != $SLOT3))
                then
                    case $TYPE in
                        1) ((PAPER--)); ((LOOP--));;
                        2) ((REEDS--)); ((LOOP--));;
                        3) ((STRING--)); ((LOOP--));;
                        4) ((GOLD--)); ((LOOP--));;
                        5) ((CRYSTAL--)); ((LOOP--));;
                    esac
            fi
            if (($PAPER > $MAX))
                then
                ((PAPER--))
                ((LOOP--))
            elif (($REEDS > $MAX))
                then
                ((REEDS--))
                ((LOOP--))
            elif (($STRING > $MAX))
                then
                ((STRING--))
                ((LOOP--))
            elif (($GOLD > $MAX))
                then
                ((GOLD--))
                ((LOOP--))
            elif (($CRYSTAL > $MAX))
                then
                ((CRYSTAL--))
                ((LOOP--))
            fi
    done

#PRINT LINE TO CSV
    case $SLOT1 in
        1) TYPE1="paper"; AMOUNT1=$PAPER;;
        2) TYPE1="reeds"; AMOUNT1=$REEDS;;
        3) TYPE1="string"; AMOUNT1=$STRING;;
        4) TYPE1="gold"; AMOUNT1=$GOLD;;
        5) TYPE1="crystal"; AMOUNT1=$CRYSTAL;;
    esac
    case $SLOT2 in
        1) TYPE2="paper"; AMOUNT2=$PAPER;;
        2) TYPE2="reeds"; AMOUNT2=$REEDS;;
        3) TYPE2="string"; AMOUNT2=$STRING;;
        4) TYPE2="gold"; AMOUNT2=$GOLD;;
        5) TYPE2="crystal"; AMOUNT2=$CRYSTAL;;
    esac
    case $SLOT3 in
        1) TYPE3="paper"; AMOUNT3=$PAPER;;
        2) TYPE3="reeds"; AMOUNT3=$REEDS;;
        3) TYPE3="string"; AMOUNT3=$STRING;;
        4) TYPE3="gold"; AMOUNT3=$GOLD;;
        5) TYPE3="crystal"; AMOUNT3=$CRYSTAL;;
    esac
    if (($SLOT1 == $SLOT2))
    then
        echo "$TYPE1,$AMOUNT1,$TYPE3,$AMOUNT3,," >> materials_$DATE.csv
        elif (($SLOT1 == $SLOT3)); then
        echo "$TYPE1,$AMOUNT1,$TYPE2,$AMOUNT2,," >> materials_$DATE.csv
        elif (($SLOT2 == $SLOT3)); then
        echo "$TYPE1,$AMOUNT1,$TYPE2,$AMOUNT2,," >> materials_$DATE.csv
        else
        echo "$TYPE1,$AMOUNT1,$TYPE2,$AMOUNT2,$TYPE3,$AMOUNT3" >> materials_$DATE.csv
    fi
done
echo "Cards generated and outputted to file materials_$DATE.txt"
