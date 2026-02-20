BOOK_DIR := book

.PHONY: build serve clean

build:
	cd $(BOOK_DIR) && quarto render

serve:
	cd $(BOOK_DIR) && quarto preview

clean:
	rm -rf $(BOOK_DIR)/dist
