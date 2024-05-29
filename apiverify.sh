#!/bin/bash

# Nombre del archivo que contiene las URLs
archivo="apis.txt"

# Nombre del archivo de salida
archivo_salida="urls_json.txt"

# Recorrer cada línea del archivo
while IFS= read -r url; do
    # Realizar la solicitud GET a la URL y guardar la respuesta en un archivo temporal
    respuesta=$(curl -s -o /dev/null -w "%{http_code}" -H "Accept: application/json" "$url")

    # Verificar si la respuesta es 200 (OK) y si el contenido es JSON
    if [[ "$respuesta" -eq 200 && $(curl -s "$url" -H "Accept: application/json" | jq -e . >/dev/null 2>&1; echo $?) -eq 0 ]]; then
        echo "La URL $url responde con un formato JSON."
        echo "$url" >> "$archivo_salida"
    fi
done < "$archivo"
