#!/bin/env expect  
  
set timeout 10  
spawn make oldconfig  
while {1} {  
        expect {  
                "] (NEW)" { send "\n" }  
                "# configuration written to .config" {break}  
        }  
}  
   
interact  
