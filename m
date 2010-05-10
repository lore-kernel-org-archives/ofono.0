Content-Type: multipart/mixed; boundary="===============6942389650941786315=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 18:39:59 +0530
Message-ID: <COL106-W404338438AC87F55761AA5F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6942389650941786315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

I installed phonesim1.1 source. I compiled and installed.

I =

started phonesim as you suggested "./phonesim -p gui default.xml"
 (now i got default.xml file in /phonesim/src)
I started ofono using "ofonod
 -n -d"
I executed "./list-modems".  It is not displaying =

any thing. I am just getting prompt. For your reference i am posting =

ofonod -n -d o/p at the end of the mail.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Please note this is additional information..

I found one file named =

blacklist-modem.conf in /etc/modprobe.d path. Please find the =

content of that file.

# Uncomment these entries in order to =

blacklist unwanted modem drivers
# blacklist snd-atiixp-modem
# =

blacklist snd-intel8x0m
# blacklist snd-via82xx-modem

Is it =

creating any trouble for me to start the phonesim? Any idea on this?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

modem.conf
 file is presented in 2 locations.

1. /etc/ofono
2. =

/usr/share/alsa/pcm

After changing the modem.conf am I need to =

restart the system?

Thanks in advance.

Note:- oFono version is 0.9 and phonesim version is 1.1

sudo ofono -n -d =

(output)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
ofonod[5458]:
 oFono version 0.9
ofonod[5458]: src/plugin.c:__ofono_plugin_init() =

ofonod[5458]:
 plugins/hfp.c:hfp_init() =

ofonod[5458]: =

src/modem.c:ofono_modem_driver_register() driver: 0x66de80, name: hfp
ofonod[5458]:
 src/modem.c:ofono_modem_driver_register() driver: 0x66de00, name: =

novatel
ofonod[5458]: src/modem.c:ofono_modem_driver_register() =

driver: 0x66dd80, name: huawei
ofonod[5458]: =

src/modem.c:ofono_modem_driver_register() driver: 0x66dd00, name: hso
ofonod[5458]:
 src/modem.c:ofono_modem_driver_register() driver: 0x66dc60, name: mbm
ofonod[5458]:
 src/modem.c:ofono_modem_driver_register() driver: 0x66dbe0, name: =

calypso
ofonod[5458]: src/modem.c:ofono_modem_driver_register() =

driver: 0x66db60, name: g1
ofonod[5458]: =

src/modem.c:ofono_modem_driver_register() driver: 0x66dae0, name: atgen
ofonod[5458]:
 src/modem.c:ofono_modem_driver_register() driver: 0x66da60, name: =

phonesim
ofonod[5458]: Reading of /etc/ofono/modem.conf failed: Key =

file contains line 'pcm.!phoneline {' which is not a key-value pair, =

group, or comment
ofonod[5458]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0x66d9a0, name: =

mbm
ofonod[5458]: src/voicecall.c:ofono_voicecall_driver_register() =

driver: 0x66d8c0, name: hfpmodem
ofonod[5458]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0x66d7e0, =

name: calypsomodem
ofonod[5458]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0x66d4e0, =

name: atmodem
ofonod[5458]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0x66d660, name: =

atmodem
ofonod[5458]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: =

0x66d5a0, name: atmodem
ofonod[5458]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0x66d280, name: atmodem
ofonod[5458]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0x66d2e0, =

name: atmodem
ofonod[5458]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0x66d100, name: atmodem
ofonod[5458]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0x66d5e0, =

name: atmodem
ofonod[5458]: src/ssn.c:ofono_ssn_driver_register() =

driver: 0x66d630, name: atmodem
ofonod[5458]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0x66d4a0, name: atmodem
ofonod[5458]:
 src/sms.c:ofono_sms_driver_register() driver: 0x66d1a0, name: atmodem
ofonod[5458]:
 src/sim.c:ofono_sim_driver_register() driver: 0x66d400, name: atmodem
ofonod[5458]:
 src/network.c:ofono_netreg_driver_register() driver: 0x66d380, name: =

atmodem
ofonod[5458]: src/cbs.c:ofono_cbs_driver_register() driver: =

0x66d240, name: atmodem
ofonod[5458]: =

src/call-volume.c:ofono_call_volume_driver_register() driver: 0x66d6a0, =

name: atmodem
ofonod[5458]: src/gprs.c:ofono_gprs_driver_register() =

driver: 0x66d700, name: atmodem
ofonod[5458]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0x66d760, name: =

atmodem
ofonod[5458]: src/modem.c:ofono_devinfo_driver_register() =

driver: 0x66cb00, name: isimodem
ofonod[5458]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0x66cae0, =

name: isimodem
ofonod[5458]: =

src/network.c:ofono_netreg_driver_register() driver: 0x66cb40, name: =

isimodem
ofonod[5458]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0x66cba0, =

name: isimodem
ofonod[5458]: src/sms.c:ofono_sms_driver_register() =

driver: 0x66cc40, name: isimodem
ofonod[5458]: =

src/cbs.c:ofono_cbs_driver_register() driver: 0x66cc80, name: isimodem
ofonod[5458]:
 src/sim.c:ofono_sim_driver_register() driver: 0x66ccc0, name: isimodem
ofonod[5458]:
 src/ssn.c:ofono_ssn_driver_register() driver: 0x66cd50, name: isimodem
ofonod[5458]:
 src/ussd.c:ofono_ussd_driver_register() driver: 0x66cd80, name: =

isimodem
ofonod[5458]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0x66cdc0, name: isimodem
ofonod[5458]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0x66ce00, name: isimodem
ofonod[5458]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: =

0x66ce60, name: isimodem
ofonod[5458]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0x66cea0, =

name: isimodem
ofonod[5458]: =

src/modem.c:ofono_modem_driver_register() driver: 0x66caa0, name: =

isimodem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Regards,
Krishna
 K Kandula.
 		 	   		  =

_________________________________________________________________
South Cinema This Decade
http://entertainment.in.msn.com/southcinemathisdecade/

--===============6942389650941786315==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGks
PGJyPjxicj5JIGluc3RhbGxlZCBwaG9uZXNpbTEuMSBzb3VyY2UuIEkgY29tcGlsZWQgYW5kIGlu
c3RhbGxlZC48YnI+PGJyPkkgCnN0YXJ0ZWQgcGhvbmVzaW0gYXMgeW91IHN1Z2dlc3RlZCAiPGI+
Li9waG9uZXNpbSAtcCBndWkgZGVmYXVsdC54bWw8L2I+IgogKG5vdyBpIGdvdCBkZWZhdWx0Lnht
bCBmaWxlIGluIC9waG9uZXNpbS9zcmMpPGJyPkkgc3RhcnRlZCBvZm9ubyB1c2luZyAiPGI+b2Zv
bm9kCiAtbiAtZDwvYj4iPGJyPkkgZXhlY3V0ZWQgIjxiPi4vbGlzdC1tb2RlbXM8L2I+Ii4mbmJz
cDsgSXQgaXMgbm90IGRpc3BsYXlpbmcgCmFueSB0aGluZy4gSSBhbSBqdXN0IGdldHRpbmcgcHJv
bXB0LiBGb3IgeW91ciByZWZlcmVuY2UgaSBhbSBwb3N0aW5nIApvZm9ub2QgLW4gLWQgby9wIGF0
IHRoZSBlbmQgb2YgdGhlIG1haWwuPGJyPjxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPlBsZWFzZSBub3Rl
IHRoaXMgaXMgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4uPGJyPjxicj5JIGZvdW5kIG9uZSBmaWxl
IG5hbWVkIApibGFja2xpc3QtbW9kZW0uY29uZiBpbiA8Yj4vZXRjL21vZHByb2JlLmQ8L2I+IHBh
dGguIFBsZWFzZSBmaW5kIHRoZSAKY29udGVudCBvZiB0aGF0IGZpbGUuPGJyPjxicj4jIFVuY29t
bWVudCB0aGVzZSBlbnRyaWVzIGluIG9yZGVyIHRvIApibGFja2xpc3QgdW53YW50ZWQgbW9kZW0g
ZHJpdmVyczxicj4jIGJsYWNrbGlzdCBzbmQtYXRpaXhwLW1vZGVtPGJyPiMgCmJsYWNrbGlzdCBz
bmQtaW50ZWw4eDBtPGJyPiMgYmxhY2tsaXN0IHNuZC12aWE4Mnh4LW1vZGVtPGJyPjxicj5JcyBp
dCAKY3JlYXRpbmcgYW55IHRyb3VibGUgZm9yIG1lIHRvIHN0YXJ0IHRoZSBwaG9uZXNpbT8gQW55
IGlkZWEgb24gdGhpcz88YnI+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPjxicj5tb2RlbS5jb25mCiBmaWxl
IGlzIHByZXNlbnRlZCBpbiAyIGxvY2F0aW9ucy48YnI+PGJyPjEuIC9ldGMvb2Zvbm88YnI+Mi4g
Ci91c3Ivc2hhcmUvYWxzYS9wY208YnI+PGJyPkFmdGVyIGNoYW5naW5nIHRoZSBtb2RlbS5jb25m
IGFtIEkgbmVlZCB0byAKcmVzdGFydCB0aGUgc3lzdGVtPzxicj48YnI+VGhhbmtzIGluIGFkdmFu
Y2UuPGJyPjxiPjxicj5Ob3RlOi0gb0Zvbm8gdmVyc2lvbiBpcyAwLjkgYW5kIHBob25lc2ltIHZl
cnNpb24gaXMgMS4xPC9iPjxicj48YnI+c3VkbyBvZm9ubyAtbiAtZCAKKG91dHB1dCk8YnI+PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PTxicj5vZm9ub2RbNTQ1OF06CiBvRm9ubyB2ZXJzaW9uIDAu
OTxicj5vZm9ub2RbNTQ1OF06IHNyYy9wbHVnaW4uYzpfX29mb25vX3BsdWdpbl9pbml0KCkgPGJy
Pm9mb25vZFs1NDU4XToKIHBsdWdpbnMvaGZwLmM6aGZwX2luaXQoKSA8YnI+b2Zvbm9kWzU0NThd
OiAKc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2
ZGU4MCwgbmFtZTogaGZwPGJyPm9mb25vZFs1NDU4XToKIHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2NmRlMDAsIG5hbWU6IApub3ZhdGVsPGJyPm9m
b25vZFs1NDU4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgCmRy
aXZlcjogMHg2NmRkODAsIG5hbWU6IGh1YXdlaTxicj5vZm9ub2RbNTQ1OF06IApzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NjZkZDAwLCBuYW1lOiBo
c288YnI+b2Zvbm9kWzU0NThdOgogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDY2ZGM2MCwgbmFtZTogbWJtPGJyPm9mb25vZFs1NDU4XToKIHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2NmRiZTAsIG5h
bWU6IApjYWx5cHNvPGJyPm9mb25vZFs1NDU4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgCmRyaXZlcjogMHg2NmRiNjAsIG5hbWU6IGcxPGJyPm9mb25vZFs1NDU4
XTogCnNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2
NmRhZTAsIG5hbWU6IGF0Z2VuPGJyPm9mb25vZFs1NDU4XToKIHNyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2NmRhNjAsIG5hbWU6IApwaG9uZXNpbTxi
cj5vZm9ub2RbNTQ1OF06IFJlYWRpbmcgb2YgL2V0Yy9vZm9uby9tb2RlbS5jb25mIGZhaWxlZDog
S2V5IApmaWxlIGNvbnRhaW5zIGxpbmUgJ3BjbS4hcGhvbmVsaW5lIHsnIHdoaWNoIGlzIG5vdCBh
IGtleS12YWx1ZSBwYWlyLCAKZ3JvdXAsIG9yIGNvbW1lbnQ8YnI+b2Zvbm9kWzU0NThdOiAKc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2
ZDlhMCwgbmFtZTogCm1ibTxicj5vZm9ub2RbNTQ1OF06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192
b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgCmRyaXZlcjogMHg2NmQ4YzAsIG5hbWU6IGhmcG1v
ZGVtPGJyPm9mb25vZFs1NDU4XTogCnNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2ZDdlMCwgCm5hbWU6IGNhbHlwc29tb2RlbTxicj5v
Zm9ub2RbNTQ1OF06IApzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg2NmQ0ZTAsIApuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs1NDU4XTog
CnNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2
ZDY2MCwgbmFtZTogCmF0bW9kZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL2NhbGwtYmFycmluZy5j
Om9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IAoweDY2ZDVhMCwg
bmFtZTogYXRtb2RlbTxicj5vZm9ub2RbNTQ1OF06IApzcmMvY2FsbC1mb3J3YXJkaW5nLmM6b2Zv
bm9fY2FsbF9mb3J3YXJkaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogCjB4NjZkMjgwLCBu
YW1lOiBhdG1vZGVtPGJyPm9mb25vZFs1NDU4XTogCnNyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2Fs
bF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NjZkMmUwLCAKbmFtZTogYXRtb2Rl
bTxicj5vZm9ub2RbNTQ1OF06IApzcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGlu
Z3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAKMHg2NmQxMDAsIG5hbWU6IGF0bW9kZW08YnI+
b2Zvbm9kWzU0NThdOiAKc3JjL3Bob25lYm9vay5jOm9mb25vX3Bob25lYm9va19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NjZkNWUwLCAKbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbNTQ1OF06
IHNyYy9zc24uYzpvZm9ub19zc25fZHJpdmVyX3JlZ2lzdGVyKCkgCmRyaXZlcjogMHg2NmQ2MzAs
IG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2NmQ0YTAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9k
WzU0NThdOgogc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NjZkMWEwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFs1NDU4XToKIHNyYy9zaW0uYzpvZm9ub19z
aW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2ZDQwMCwgbmFtZTogYXRtb2RlbTxicj5v
Zm9ub2RbNTQ1OF06CiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NjZkMzgwLCBuYW1lOiAKYXRtb2RlbTxicj5vZm9ub2RbNTQ1OF06IHNyYy9j
YnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAKMHg2NmQyNDAsIG5hbWU6
IGF0bW9kZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92
b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2ZDZhMCwgCm5hbWU6IGF0bW9kZW08
YnI+b2Zvbm9kWzU0NThdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkg
CmRyaXZlcjogMHg2NmQ3MDAsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL2dw
cnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2ZDc2
MCwgbmFtZTogCmF0bW9kZW08YnI+b2Zvbm9kWzU0NThdOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZp
bmZvX2RyaXZlcl9yZWdpc3RlcigpIApkcml2ZXI6IDB4NjZjYjAwLCBuYW1lOiBpc2ltb2RlbTxi
cj5vZm9ub2RbNTQ1OF06IApzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg2NmNhZTAsIApuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTQ1
OF06IApzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NjZjYjQwLCBuYW1lOiAKaXNpbW9kZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL3ZvaWNlY2Fs
bC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NjZjYmEwLCAK
bmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzU0NThdOiBzcmMvc21zLmM6b2Zvbm9fc21zX2RyaXZl
cl9yZWdpc3RlcigpIApkcml2ZXI6IDB4NjZjYzQwLCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2Rb
NTQ1OF06IApzcmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg2
NmNjODAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFs1NDU4XToKIHNyYy9zaW0uYzpvZm9ub19z
aW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2Y2NjMCwgbmFtZTogaXNpbW9kZW08YnI+
b2Zvbm9kWzU0NThdOgogc3JjL3Nzbi5jOm9mb25vX3Nzbl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NjZjZDUwLCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTQ1OF06CiBzcmMvdXNzZC5j
Om9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDY2Y2Q4MCwgbmFtZTogCmlz
aW1vZGVtPGJyPm9mb25vZFs1NDU4XTogCnNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxs
X2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAKMHg2NmNkYzAsIG5hbWU6IGlz
aW1vZGVtPGJyPm9mb25vZFs1NDU4XTogCnNyYy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IAoweDY2Y2UwMCwgbmFtZTogaXNpbW9k
ZW08YnI+b2Zvbm9kWzU0NThdOiAKc3JjL2NhbGwtYmFycmluZy5jOm9mb25vX2NhbGxfYmFycmlu
Z19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IAoweDY2Y2U2MCwgbmFtZTogaXNpbW9kZW08YnI+
b2Zvbm9kWzU0NThdOiAKc3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg2NmNlYTAsIApuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbNTQ1
OF06IApzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NjZjYWEwLCBuYW1lOiAKaXNpbW9kZW08YnI+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj5S
ZWdhcmRzLDxicj5LcmlzaG5hCiBLIEthbmR1bGEuPGJyPiAJCSAJICAgCQkgIDxiciAvPjxociAv
PlRoZSBsYXRlc3QgYXV0byBsYXVuY2hlcyBhbmQgdGVzdCBkcml2ZXMgPGEgaHJlZj0naHR0cDov
L2F1dG9zLmluLm1zbi5jb20vJyB0YXJnZXQ9J19uZXcnPkRyYWcgbicgZHJvcDwvYT48L2JvZHk+
CjwvaHRtbD4=
--===============6942389650941786315==--

