alias b := build
 
host := `uname -a`

# build main
build:
    echo 'hola'
#    {{host}}

test TEST1F:
    ls {{TEST1F}}
    echo FIN!      
