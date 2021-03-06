all-linux: mergJSON-x86.so mergJSON-x64.so

sources = mergJSON/mergJSON.c \
			mergJSON/external.h \
			mergJSON/external.c\
			mergJSON/jansson/src/dump.c \
			mergJSON/jansson/src/error.c \
			mergJSON/jansson/src/hashtable.c \
			mergJSON/jansson/src/hashtable_seed.c \
			mergJSON/jansson/src/load.c \
			mergJSON/jansson/src/memory.c \
			mergJSON/jansson/src/pack_unpack.c \
			mergJSON/jansson/src/strbuffer.c \
			mergJSON/jansson/src/strconv.c \
			mergJSON/jansson/src/utf.c \
			mergJSON/jansson/src/value.c

$(info $(shell mkdir -p build))

mergJSON-x86.so: $(sources)
	gcc -v -Wall -Wextra -m32 -O -I mergJSON -I mergJSON/jansson/src -I mergJSON/include -L.-D_LINUX \
	-DHAVE_CONFIG_H=1 -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined \
	-fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(sources) \
	-o build/mergJSON-x86.so

mergJSON-x64.so: $(sources)
	gcc -v -Wall -Wextra -fPIC -m64 -O -I mergJSON -I mergJSON/jansson/src -I mergJSON/include -L.-D_LINUX \
	-DHAVE_CONFIG_H=1 -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined \
	-fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -shared $(sources) \
	-o build/mergJSON-x64.so
