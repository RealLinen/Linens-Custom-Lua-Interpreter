local function Interpret(...)
    local fenv = getfenv();
    local variables = {}
    local _un = unpack;
    local instr = type(({...})[1])=="table"and({...})[1]or({...});
    local last;
    local PC = 1;
    ------------------------------------
    local function getInstr(m)return instr[PC+m]end
    local function addInstr(m)return PC+m;end
    local function getType(m,a)if not a then return type(m);end;return type(m)==a;end
    ------------------------------------
    while true do if not instr[PC] then break;end
        local instruction = instr[PC]
        if instruction==0 then PC=addInstr(1);end
        if instruction==1 then local next=getInstr(1);last=fenv[next];PC=addInstr(1);end
        if instruction==2 then local next,next2 = getInstr(1),getInstr(2);variables[next]=next2;PC=addInstr(2)end
        if tostring(instruction):lower()=="call"or instruction==3 then
            local next = getInstr(1)
            if getType(next,"string")then if variables[next] then next=variables[next];end;end
            if getType(last,"function")then last(next)end;if(getType(next,"number"))then PC=addInstr(1);else PC=addInstr(2);end
        end
        if instruction==4 then
            local next = getInstr(1)
            if getType(next,"table")then
              Interpret(_un(next))
            end
            PC=addInstr(1)
        end
        if instruction==5 then
            local next = variables[getInstr(1)]
            local next2 = getInstr(2)
            if getType(next,"function")then
               next(next2)
            end
            PC=addInstr(2)
        end
        if instruction==6 then
            local next=getInstr(1);last=next;
            PC=addInstr(1)
        end
        if instruction==7 then local next,next2=getInstr(1),getInstr(2);local vars=variables[next];if not vars then variables[next]=next2;else variables[next]=variables[next][next2]end;addInstr(2);end
        if instruction==8 then local next=getInstr(1);variables[next]=nil;addInstr(1);end
        if instruction=="EQ" or instruction==9 then
            local next,next2,next3 = getInstr(1),getInstr(2),getInstr(3);if next==next2 then Interpret(_un(next3))end
            PC=addInstr(3)
        end
        if instruction==10 then
           local next,next2,next3=getInstr(1),getInstr(2),getInstr(3)
           if getType(next,"number")and getType(next2,"number")and getType(next3,"table")then
               if((#next3)>0)then
                   for i=(next>0 and next-1 or next),next2 do Interpret(next3);end
               end
           end;PC=addInstr(3);
        end
        if instruction==11 then
            local next = getInstr(1)
            if next then
                variables=next
            else
                variables={} 
            end
            PC=addInstr(1)
        end
        if instruction==12 then
            local next,next2,next3,next4=getInstr(1),getInstr(2),getInstr(3),getInstr(4)
            if getType(next,"number")and getType(next2,"string")and getType(next3,"number")and getType(next4,"table")then
                next2 = next2==">"and next>next3 or next2=="<"and next<next3 or next2=="=="and next==next3
                if next2 then
                    Interpret(next4)
                end
            end;PC=addInstr(4);
        end
        PC=PC+1;
    end
    return("Completed #"..(PC-1).." Instrctions!")
end
Interpret(
1,"print",3,"This will print",0, -- Use 0 or else it wont go to the next call/stack.
10,1,4,{1,"print","call","This will print 4 times"}, -- You call call the last function using the number 3 or the string 'call'
"EQ","lol1","lol2",{1,"print",3,"Will this print?"}, -- Will not run because lol1 is not equal to lol2
"EQ","lol1","lol1",{1,"print",3,"I don't know, maybe this will print?"}, -- will run the Interpret table because lol1 is equal to lol1
7,"player",game, -- will set the variable 'player' value to game
7,"player","Players", -- Will add "Players" onto the game variable. So game["Players"]
7,"player","LocalPlayer", -- Will add LocalPlayer, so game["Players"]["LocalPlayer"]
7,"player","Name", -- game["Players"]["LocalPlayer"]["Name"]
1,"warn",3,"Players name:", -- Will warn what its about to print
6,print, -- Since we changed the last function to warn, we will change it back to print
1,"print",3,"player" -- will print the player variable
)
