#!/bin/bash

get_pokemon_by_number() {
    # if statement to check if arg list is empty
    if [ -z "$1" ]; then
        #-z === zero characters / zero length     $1 is argument provided to script
        echo "How to use this script: $0 <enter pokedex number>"
        # $0 is the var for name of the script itself
        exit 1
    fi

    pokedex_number="$1"

    API_URL_NAME_TYPE="https://pokeapi.co/api/v2/pokemon/$pokedex_number/"
    API_URL_DESCRIPTION="https://pokeapi.co/api/v2/pokemon-species/$pokedex_number/"

    response1=$(curl -s "$API_URL_NAME_TYPE")
    response2=$(curl -s "$API_URL_DESCRIPTION")

    if [[ $? -eq 0 ]]; then
        echo "success"
        name=$(echo "$response1" | jq -r '.name')
        type=$(echo "$response1" | jq -r '.types[0].type.name')
        description=$(echo "$response2" | jq -r '.flavor_text_entries[5].flavor_text')
    fi

    description=$(echo "$description" | tr '\n\f' ' ' | fmt -w 50)
    #tr trims off the escaped \n and \f that was left in the gameboy description api entries
    # fmt word wraps to prevent words breaking

    echo "Pokedex entry for pokemon number $pokedex_number:"
    echo "Name: $name"
    echo "Type: $type"
    echo "Description: $description"

}

# reference the arg being passed into func as a param with "$1"
get_pokemon_by_number "$1"