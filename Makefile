PREFIX ?= /usr/local
VERSION = 2.1
LIBRARY_NAME = pam_watchid.so
DESTINATION = $(addprefix $(PREFIX), /lib/pam)
TARGET := $(shell uname -m)-apple-darwin$(shell uname -r)

.PHONY: all

all: $(LIBRARY_NAME)

$(LIBRARY_NAME): watchid-pam-extension.swift
	swiftc watchid-pam-extension.swift -o $(LIBRARY_NAME) -target $(TARGET) -emit-library

.PHONY: install
install: all
	mkdir -p $(DESTINATION)
	cp $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME)

clean:
	rm $(LIBRARY_NAME)
