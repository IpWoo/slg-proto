# 需要加载的代码路径
LOAD_PATH = \
	ebin \
	deps/*/ebin \
	$(NULL)

# 节点名称
NODE = galaxy-empire@127.0.0.1
# cookie
COOKIE = abcdeft

# 部分配置参数
OPTS = \
	-pa $(LOAD_PATH) \
	-env ERL_MAX_ETS_TABLES 10000 \
	-setcookie $(COOKIE) \
	+A 8 +K true +P 120000  # -smp disable \
	-detached  \
	-noshell \
	$(NULL)

# rebar-用于编译
REBAR := ./bin/rebar
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
REBAR := ./bin/rebar.linux
# do something Linux-y
endif

# 编译全部
all:
	$(REBAR) compile

# 获取到所有的依赖
deps:
	$(REBAR) get-deps

t:
	$(REBAR) compile eunit

c:
	$(REBAR) clean

# cc:
# 	rm proto/code/*
# 	rm ebin/proto/

# 调用生成器生成代码
g:
	ruby src/proto_gen2.rb

s:
	erl $(OPTS) -name $(NODE) -s slg_proto start

e:
	erl $(OPTS)

r:
	erl $(OPTS) -s robot start

.PHONY: deps get-deps
