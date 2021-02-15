# TP2-CryptoMonsters

Pasos para ejecutar.

1) Crear nodo local con ganache.
2) Deployar el contrato MonsterOwnership. Copiar su dirección.
3) Editar el archivo index.html. Asignar la variable cryptoMonstersAddress (en la línea 59) a la dirección del contrato.
4) En el explorador web, agregar a Metamask las cuentas que se vayan a utilizar.
5) Dentro de la carpeta Dapp, iniciar un servidor de http. Por ejemplo, con:  
npm install -g http-server  
http-server -p 8080  
6) En el explorador Web, ingresar a: http://127.0.0.1:8080.
7) Debería saltar un popup de metamask para conectar la cuenta al sitio.
8) Utilizar la funcionalidades de la página. Al cambiar la cuenta de matamask el sitio se refrescará y mostrará los monstruos de la nueva cuenta si es que tiene.

Nota: Si por alguna razón no se puede conectar el sitio a Metamask, hay un campo llamado Eth User Account donde se pueden poner números del 0 al 9, y al presionar el botón
Change User Account se cambiará a la cuenta correspondiente de las 10 cuentas que abre automáticamente Ganache.

Suposiciones:
- Las cuentas podrán crear un cryptoMonstruo solamente si no poseen ninguno.
