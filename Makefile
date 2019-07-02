image:
	sudo docker build . -t go-readonly

issue:
	rm -rf go.mod
	go mod init github.com/ekalinin/go-readonly

fix:
	chmod a+r go.mod 
