# Сборка книги. Порядок глав берётся из book.yml.
# Требуется: pandoc, python3, (для pdf) xelatex.

DIST := dist
TITLE := web-glazami-drevnego-cheloveka

.PHONY: all epub pdf html files clean

# Извлекаем упорядоченный список файлов из book.yml (без внешних зависимостей)
FILES := $(shell python3 -c "import yaml,sys; \
print(' '.join(yaml.safe_load(open('book.yml'))['files']))" 2>/dev/null || \
python3 -c "import re; \
print(' '.join(re.findall(r'^\s*-\s*\"(.+?)\"', open('book.yml').read(), re.M)))")

$(DIST):
	mkdir -p $(DIST)

files:
	@echo $(FILES) | tr ' ' '\n'

epub: $(DIST)
	pandoc --metadata-file=book.yml \
	       --toc --toc-depth=2 \
	       -o $(DIST)/$(TITLE).epub $(FILES)
	@echo "→ $(DIST)/$(TITLE).epub"

html: $(DIST)
	pandoc --metadata-file=book.yml \
	       --toc --toc-depth=2 --standalone --embed-resources \
	       -o $(DIST)/$(TITLE).html $(FILES)
	@echo "→ $(DIST)/$(TITLE).html"

pdf: $(DIST)
	pandoc --metadata-file=book.yml \
	       --toc --toc-depth=2 \
	       --pdf-engine=xelatex \
	       -V mainfont="DejaVu Serif" \
	       -V lang=ru \
	       -o $(DIST)/$(TITLE).pdf $(FILES)
	@echo "→ $(DIST)/$(TITLE).pdf"

all: epub html pdf

clean:
	rm -rf $(DIST)
