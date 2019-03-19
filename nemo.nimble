# Package

version       = "0.1.0"
author        = "Yuri Vendruscolo"
description   = "Simple(r) CSS for python"
license       = "MIT"
installExt    = @["nim"]
bin           = @["nemo.so"]


# Dependencies

requires "nim >= 0.19.4"
requires "nimquery >= 1.1.2"
requires "nimpy"

task bld, "builds sharedlib":
    exec "nimble build --app:lib -d:release --opt:speed --gc:regions -y"

task tst, "tests the bult sharedlib":
    exec "python3 nemo.py"

task src, "generate c sources":
    exec "nimble c -c --genscript --nimcache:./csources nemo.nim -y"