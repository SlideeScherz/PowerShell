
#requires -version 5.1

param() # ← enter script parameters here

#	← enter functions here 

try {
#	← enter instructions here 

    "$($Icons.Success) Done."
    exit 0 # success
}
catch {
    "$($Icons.Error) Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}
