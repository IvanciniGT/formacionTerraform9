```py

numero = 7          # Statement: Enunciado, Frase, Oración

numero = 7 + 15     # Statement: Enunciado, Frase, Oración
        ########      Expression (sintagma)
        
if numero > 15:
    print("GRANDECITO !!!!")

texto = "GRANDECITO" if numero > 15 else "PEQUIÑIN"
        # Valor si se cumple la condicion IF condicion ELSE valor si no se cumple

for numero in [1,2,3]:
    print(numero)

lista = [ item for item in [1,5,8] ]

def miFuncion():
    pass
```

Me tengo que asegurar que:

TERRAFORM NUNCA JAMAS comience a ejecutar un plan
que de antemano sé que va a fallar.
Y QUE ME DEJE A MEDIAS UNA INFRA !!!!

Esto hay que EVITARLO A TODA COSTA !!!!

# Qué es el operado Operador && en cualquier lenguaje de programación

Es el operador Y (AND) en CORTOCIRCUITO

# Qué es el operado Operador || en cualquier lenguaje de programación

Es el operador O (OR) en CORTOCIRCUITO

# Operador AND

condicion1 AND condicion2       AND
true            true            true
true            false           false
false           true            false
false           false           false

# Operador AND EN CORTOCIRUITO

condicion1 AND EN CORTOCIRCUITO  condicion2       AND EN CORTOCIRCUITO
true                                true            true
true                                false           false
false                                -              false

El operador "and" de python ES EN CORTOCIRCUITO

# El operador && de terraform NO ES EN CORTOCIRCUITO ! CUIDADO , PRECAUCION!, OJO !!!!!!!
NO ES EN CORTOCIRCUITO

En TERRAFORM NO EXISTE EL OR ni el AND en CORTOCIRCUITO !

En su lugar, vamos a usar un CONDICIONAL EN LINEA (como expresion)


## CONDICIONALES EN LINEA (como expresion) EN TERRAFORM

    condicion ? valor si verdadero : valor si falso
    
    En este caso, SOLO se ejecuta(evalua) el código que toque 

Sería el equivalente en python a:

    valor si verdadero IF condicion ELSE valor si falso

# Expresiones regulares: PERL

PATRON: es una expresion que debe verificarse en un texto

PATRON Esta compuesto de SUBPATRONES

UN SUBPATRON: 
    Una secuencia de caracteres
    Seguido de un modificador de cantidad
    

SUBPATRON                       TEXTO                                   CUMPLE con TENER el SUBPATRON
Letras minusculas               Tengo 44 años y el año que viene 45         √

Solo letras minúsculas                                                      x

Letra mayuscula seguido de                                                  √
letras minusculas


    SECUENCIA DE CARACTERES                 SIGNIFICADO
        hola                                Encontrar literalmente el texto "hola"
        [hola]                              Encontrar alguno de los caracteres h o l a
        [a-z]                               Encontrar caracter en mínuscula
        [A-Za-z0-9]
        [0-5]                               Encontrar un DIGITO del 0 al 5
        [0-57a]                             Encontrar un DIGITO del 0 al 5 o un 5 o la a
        .                                   Cualquier caracter
        \s                                  Cualquier espacio en blanco (" " \t \r n)

    MODIFICADORES DE CANTIDAD
        no poner nada                       Una vez
        ?                                   Opcional (0 o 1 vez)
        +                                   Al menos 1 vez
        *                                   Opcional o muchas veces (0 a infinito)
        {4}                                 4 veces
        {2,5}                               De 2 a 5 veces

    Ejemplos
        [a-z]+                              Una secuencia con al menos una letra minuscula
        [0-9]{3,}                           Una secuencia con al menos 3 digitos

    CARACTERES ESPECIALES
        ^                                   Que empiece por                                  
        $                                   Que acabe
        |                                   o
        ()                                  Agrupar subpatrones
        
    
    ^   (   (   [1-9]   )               |  (  [1-2][0-9]  )  )     $
                un digito del 1 al 9
                                             Un digito del 1 al 2 seguido de un digito del 0 al 9
                                   
                Un numero del 1 al 9    
                                        O 
                                            Un numero del 10 al 29
    Empezar por                                                         Acabar
    
    
    CUMPLE? 
        Tengo 23 años           x
        23 años                 x
        5                       √
        21                      √
        0                       x
        
    En definitiva mi patron valida que un texto contenga un número del 1 al 29
    
    Parar trabajar con expresiones regulares: regex101.com
                