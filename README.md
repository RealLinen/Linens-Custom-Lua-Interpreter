# Note
I wrote this at the age of 12-13, please do NOT use it as it's shitty lmao.
# Lua-Releases
This is an custom Lua Interpreter. It only has an Interpret function, not an function to convert code into t Interpretable one.
To understand this you need to be smart and have good lua knowlege.
Created by Linen#3485
# Documentation
Numbers: 
     
     * 0 -- before calling a new stak, call this for the next stack to run ( or next number/function )
     
     * 1, <variable> -- Will set the last function to getfenv[<variable>]
     
     * 2, <variable>, <value> -- sets variable arg1 to arg2 in the vm
     
     * 3 -- Will call the last function that was set set. See examples for more info.
     
     * 4, <table> -- Will Interpret arg1. arg1 must be a table
    
     * 5, <func>, <arguments> -- Will call func [ func was be set as a variable ] with the arguments ( Argument can be a table, string, anything excepct more variables or the '...' term) 
     
     * 6, <function> -- Will set the last function to the provided function which can be called using 3
    
     * 7, <variable>, <value> -- The same as what 2 does, but extends in the <variable>. Look at "OTHER NUMBERS" [ below ] for more information

     * 8, <variable> -- Will set the variable to nil/clear the <variable> provided

     * 9 || "EQ", <statement1>, <statement2>, <table> -- Will EQ statement1 and statement 2, which means will check if statement1 is equal to statement 2 and if it is, it will run the <table> [ Which is basically the Instructions ]

     * 10 <num1>, <num2>, <Instructions> -- Will do an for i=<num1>,<num2> do Interpret(<Instructions>) end loop. The Instructions are basically these or the vm or the Interpret function with the variables/arguments.

     * 11 <anything> -- Will set the variables table to <anything>

     * 12 <num1> <sign> <num2> <To Interpret> -- Will check if num1<sign>num2 and interpret argument 4 if its true.
# Examples
    [ ->>>> PRINTING ]
  Interpret(1,"print") -- will set last function to getfenv['print']
  
  Interpret(1,"print",3,"testing") -- the number 3 will call the last function set ( which was print )
  
  Interpret(1,"print",3,"testing",1,"print",3,"this will print") -- doing multiple things

    [ ->>>> CALLING FUNCTIONS ]

  Interpret(4,{1,"print",3,"haha"}) -- Will Interpret this. No use of this unless you want clean code

    [ ->>>> PRINTING/SETTING VARIABLES ]

  Interpret(2,"hello","I dont know") -- will set variable "hello" to "I dont know"

  Interpret(2,"hello","Will this print?",1,"print",3,"hello") -- will print "Will this print?"

  Interpret(6,function()

    print'dodo'
  end,3,0,1,"print",3,"sup") -- will set the last function to that function. Then the number 3 will call the function. And 1,print,3,sup will print "sup"
  
  Interpret(2, "prn",function(var)

       print(var)
    end,
    5, "prn","Will this print? [ #5 ]"
  ) -- Will set the variable prn to the function, then using the number 5 will call the variable prn with the arguments

  Interpret(2,"prn","will this print or will 'prn' print"8,"prn",1,"print",3,"prn") -- The number 8 will clear this variable in the variables list. which will print prn because the variable was not found.

    [ ->>>> OTHER NUMBERS ]
        [ #7 ]
  Interpret(7,"t",game, -- Set variable 't' to table 'game'

    7,"t","Players", -- Adds on to variable t. t["Players"]

    7,"t","LocalPlayer", -- Adds on to variable t. t["Players"]

    7,"t","Name",

    1,"print", -- Sets last function to getfenv()["print"]

    3,"t" -- Calls the last function with the argument 't' which will print the variable we set)

  ^^ IS THE SAME AS: print(game.Players.LocalPlayer.Name)


  Interpret(9, -- you can also use "EQ"

    "lol1","lol2",{
        1,"print",3,"This wont print because lol1 is not equal to lol2"
    },

    9,"kik","kik",{
        1,"print",3,"Yay, this prints!"
    })
