# Compiles and runs a c file, compiles to a file of the same name of the c file
# Eg. something.c -> something
function gcrun
    argparse v/valgrind -- $argv
    set -l file $argv[1]
    or return
    # Remove the file type from the file path
    set -l output (string replace -r '\.([^./]+)$' '' -- $file)

    # Determine compiler based on file type
    set -l compiler
    set -l ext (string match -r '\.([^./]+)$' -- "$file" | string lower | head -n 1)

    switch "$ext"
        case '.c'
            set compiler gcc
        case '.cpp' '.cc' '.cxx' '.c++'
            set compiler g++
        case '*'
            echo "Unsupported file type '$ext'"
            return 1
    end

    if test -e $file && test -n "$output"
        eval "$compiler -g -Wall -o $output $file"
        if test $status = 0
            if set -q _flag_v
                valgrind --leak-check=full $output --debug
            else
                eval "./$output"
            end
        end
    else
        echo "File does not exist"
    end
end
