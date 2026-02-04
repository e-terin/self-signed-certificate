DOMAIN = "app.loc"

create-v3-ext:
	mkdir ./ssl
	cp v3.ext.example ./ssl/v3.ext
	printf "\nDNS.1 = $(DOMAIN)\n" >> ./ssl/v3.ext
	printf "DNS.2 = *.$(DOMAIN)\n" >> ./ssl/v3.ext

generate-cert: create-v3-ext
	# Генерация корневого ключа
	openssl genrsa -out ./ssl/rootCA.key 2048
	# Генерация корневого сертификата  - заполняем страну, город, компанию
	openssl req -x509 -new -nodes -key ./ssl/rootCA.key -sha256 -days 1825 -out ./ssl/rootCA.crt
	# Файл подписи
	openssl req -new -newkey rsa:2048 -sha256 -nodes -keyout ./ssl/site.key -subj /C=CA/ST=None/L=NB/O=None/CN=$(DOMAIN) -out ./ssl/sign.csr
	# Выпускаем сертификат
	openssl x509 -req -in ./ssl/sign.csr -CA ./ssl/rootCA.crt -CAkey ./ssl/rootCA.key -CAcreateserial -out ./ssl/site.crt -days 1825 -sha256 -extfile ./ssl/v3.ext