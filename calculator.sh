#!/bin/bash
#add()----------------------------------------------------#
#input : two integers
#integers output : on integer as answer
#---------------------------------------------------------#

add(){
    local answer=0
    for sum in $@
    do
        let answer=$answer+$sum
    done
        echo $answer
}

#subtract()-----------------------------------------------#
#input : more than 1 integer
#integers output : on integer as answer
#---------------------------------------------------------#
subtract(){
    local answer=0
    local index=1
    for sub in $@
    do
    [ $index -eq 1 ] && answer=$sub && ((index++)) || let answer=$answer-$sub  #first time assign the first element to answer
    done
    echo $answer
}

#multiply()-----------------------------------------------#
#input : more than 1  integers
#integers output : on integer as answer
#---------------------------------------------------------#
multiply(){
    local answer=1
    for mult in $@
    do
        let answer=$answer*$mult
    done
        echo $answer
}

#divide()-------------------------------------------------#
#input : more than 1 integer after the secound not zero
#integers output : on integer as answer
#---------------------------------------------------------#
divide(){
    local answer=0
    local index=1
    for div in $@
    do
        [ $index -eq 1 ] && answer=$div && ((index++)) || let answer=$answer/$div  #first time assign the first element to answer
    done
        echo $answer
}

#power_of()-----------------------------------------------#
#input : more than 1 integer
#integers output : on integer as answer
#---------------------------------------------------------#
power_of(){
    local answer=1
    local index=1
    for power in $@  # big loop
    do
    if [ $index -eq 1 ] 
    then
        answer=$power
        ((index++))
    elif [ $power -eq 0 ]
    then
        answer=1
    else 
    local count=1
    while [ $count -lt $power ] # small loop
    do
        let answer=$answer*$answer
        echo $answer
        let count=$count+1
    done
    if [ $power -lt 0 ]
    then
        let answer=1/$answer
    fi
    fi
    done

echo $answer
}
#display()------------------------------------------------#
#this function get the answer and display it and another three options
#input  : 1 number as answer
#output : print on the display 
#used_function :is_prime() & is_odd_even() & is_div_by_five()
#---------------------------------------------------------#

display(){
    local answer=$1
    echo
    echo the answer is $answer
    is_prime $answer
    is_odd_even $answer
    is_div_by_five $answer
    echo
}

#calculate()----------------------------------------------#
#function that get two numbers and one operatoras number then use other functions to calculate
#input  : multiple integers, first argument operator , after  inputs numbers 
#output : 1 number as answer
#used_function : add() & subtract() & multiply() & divide() & power_of() modulus_%()
#---------------------------------------------------------#

calculate() {
    local operator=$1
    local numbers=$(echo $@ | cut -d" " -f 2-)
    case $operator in
        1)
            add $numbers
        ;;
        
    esac
}
#input()--------------------------------------------------#
#funcation that ask the user for two integers (can be positive or negative) and validate the input
#validation : not zero or one input , the inputs are positive or negative integers 
#input      : multiple  numbers , one argument and several integers
#outbut     : excute display or ask the user to insert again
#used_functions : display
#---------------------------------------------------------#

input () {
    local re='^[+-]?[0-9]+$'
    local operator=$1
    local tester=1
    while [[ $tester -eq 1 ]]
    do
        tester=2
	    echo -n "please enter 2 numbers " 
	    read -a arr_num
	    if [ ${#arr_num[@]} -lt 2 ]
        then
	        tester=1
            echo "please enter at least 2 arguments "
	    echo
	    else # test the array members
		for num in ${arr_num[@]}
		do
		if  [[ ! $num =~ $re ]] 
		then
		    tester=1
		fi
		done
	    [ $tester -eq 1 ] && echo -e "please enter integer only\n"
	    fi
    done
    display $(calculate $operator ${arr_num[@]})
}

#menu()---------------------------------------------------#
#funcation that display menu for the user to select an operation
#input  : None
#output : display()
#usedfunctions: input() 
#---------------------------------------------------------#

function menu() {
    select menu_answer in Add Subtract Multiply Divide Power_of Modulos Exit
    do
        local action=0;
    case $menu_answer in
        Add)
            action=1
            echo "$menu_answer selected"
        ;;
        Subtract)
            action=2
            echo "$menu_answer selected"
        ;;
        Multiply)
            action=3
            echo "$menu_answer selected"
        ;;
        Divide)
            action=4
            echo "$menu_answer selected"
        ;;
        Power_of)
            action=5
            echo  "$menu_answer selected"
        ;;
        Modulos)
            action=6
            echo  "$menu_answer selected"
        ;;
        Exit)
            exit 1
        ;;
        *)
            echo -e "Try again, your input should be between 1-7\n1) Add\n2) Subtract\n3) Multiply\n4) Divide\n5) Power_of\n6) Modulos\n7) Exit "
        ;;
    esac
        [ $action -ne 0 ] 	&& input $action 	 #needed  to skip if case is *

    done
}

menu


