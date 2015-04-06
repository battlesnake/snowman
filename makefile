all:
	./src/make-anim.pl > anim.css
	cat -- anim.css src/style.css > snowman.css
	rm -f -- anim.css

clean:
	rm -f -- snowman.css anim.css
