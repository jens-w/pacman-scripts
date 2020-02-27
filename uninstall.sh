#!/bin/bash
if [ $1 != "" ]
then
        echo ".:: pacman -Rsc "$@
        echo ".:: does this look right to you? [y/n]"

        read continue

        if [ "$continue" = "y" ] || [ "$continue" = "Y" ] || [ -z "$continue" ] || [ "$continue" = "" ]
        then
                readarray installed_packages < <(pacman -Qqe)
                readarray -d ' ' arguments <<< "$@"

                declare -a to_remove

                for p in ${installed_packages[@]}
                do
                        if [[ "${arguments[@]}" =~ "$p" ]]
                        then
                                to_remove+=($p)
                        fi
                done

                echo ".:: pacman -Rsc ${to_remove[@]}"
                pacman -Rsc ${to_remove[@]}
        fi
fi
