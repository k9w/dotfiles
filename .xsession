# Enable webassembly in Chromium for Bitwarden login to use argon2id KDF.
# Set in .xsession rather than .profile to apply to whole X session, not
# just the shell.
export ENABLE_WASM=1

# Pick the window manager or desktop environment you want to start from 
# the .xsession.d folder. It must already be installed. Many need the
# services `apmd` and `messagebus` enabled and running.

. ./.xsession.d/cwm

