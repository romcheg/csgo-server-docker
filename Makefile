VERSION?='local'

.PHONY: image

image:
	docker build -t	romcheg/csgo-dedicated-server:latest -t "romcheg/csgo-dedicated-server:$(VERSION)" ./

