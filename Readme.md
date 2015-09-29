# Construir a imagem

	docker build -t zray-standalone .

# Rodar a imagem

	docker run -d -p 80:80 -p 10081:10081 zray-standalone