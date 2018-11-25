CXXFLAGS += -std=c++11 -Wall -Wextra -Wno-unused-variable -Wno-unused-parameter -Wno-missing-field-initializers
GPP := g++

all: udp2raw

%.o: %.cpp Makefile
	@echo "  G++ $@"
	@$(GPP) $(CFLAGS) -c -o $@ $< -Os -Wno-unused-result -I. -isystem libev

udp2raw: main.o lib/aes_faster_c/aes.o lib/aes_faster_c/wrapper.o lib/md5.o lib/pbkdf2-sha1.o lib/pbkdf2-sha256.o encrypt.o log.o network.o common.o connection.o misc.o fd_manager.o client.o server.o my_ev.o 
	@echo "  LD  $@"
	@$(GPP) $(LDFLAGS) -o $@ $^ -lpthread

install: udp2raw
	mkdir -p $(ROOT)/usr/bin
	install -m755 udp2raw $(ROOT)/usr/bin/udp2raw

clean:
	rm -f udp2raw {main,lib/aes_faster_c/aes,lib/aes_faster_c/wrapper,lib/md5,lib/pbkdf2-sha1,lib/pbkdf2-sha256,encrypt,log,network,common,connection,misc,fd_manager,client,server,my_ev}.o

unistall:
	rm -f $(ROOT)/usr/bin/udp2raw
