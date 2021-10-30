# See the POSIX make standard here:
# 	https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
.POSIX:

.DEFAULT:
	mail.nix

.SUFFIXES: .esh .gpg .nix

EMAIL_SECRETS=$(PASSWORD_STORE_DIR)/personal/email
TMPL_DIR=provider-config-templates
OUT_DIR=generated
GET_EMAIL=basename --suffix=.gpg $?
FILL_TMPL=xargs -I {} esh -o $(OUT_DIR)/{}.nix $(TMPL_DIR)/$*.esh email={}


mail.nix: outlook.com.nix web.de.nix yahoo.de.nix mni.thm.de.nix
	@echo Generating mail.nix...
	@cat $(OUT_DIR)/* | xargs -I {} -0 printf "{\n%s}" {} > $(OUT_DIR)/mail.nix

outlook.com.nix: $(EMAIL_SECRETS)/*@outlook.*.gpg
	@mkdir -p $(OUT_DIR)
	@$(GET_EMAIL) | $(FILL_TMPL)

web.de.nix: $(EMAIL_SECRETS)/*@web.de.gpg
	@mkdir -p $(OUT_DIR)
	@$(GET_EMAIL) | $(FILL_TMPL)

yahoo.de.nix: $(EMAIL_SECRETS)/*@yahoo.de.gpg
	@mkdir -p $(OUT_DIR)
	@$(GET_EMAIL) | $(FILL_TMPL)

mni.thm.de.nix: $(EMAIL_SECRETS)/*@mni.thm.de.gpg
	@mkdir -p $(OUT_DIR)
	@$(GET_EMAIL) | $(FILL_TMPL)

clean:
	rm -r $(OUT_DIR)

