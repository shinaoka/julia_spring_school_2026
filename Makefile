BOOK_DIR := book

.PHONY: build serve clean

build:
	cd $(BOOK_DIR) && shiroa build --mode static-html --path-to-root /
	python3 $(BOOK_DIR)/scripts/relativize_dist.py $(BOOK_DIR)/dist

serve:
	cd $(BOOK_DIR) && shiroa serve --mode static-html --path-to-root /

clean:
	rm -rf $(BOOK_DIR)/dist $(BOOK_DIR)/.shiroa

