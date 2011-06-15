Content-Type: multipart/mixed; boundary="===============7518151031729885183=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: PDP Context Activation
Date: Wed, 15 Jun 2011 17:02:46 +0530
Message-ID: <BANLkTimqCxm3vBeTy-tyQ_R737mpogGDjA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7518151031729885183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,


Now i have taken version 0.45. Modem enabled successfully.

When i am trying activate pdp context., It is failing with unknown errors.

*Please refer log messages below*

nod[8803]: src/network.c:__ofono_netreg_add_status_watch() 0xa0295c0
ofonod[8803]: src/network.c:__ofono_netreg_add_status_watch() 0xa0295c0
ofonod[8803]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on
SIM
ofonod[8803]: src/network.c:current_operator_callback() 0xa0295c0, (nil)
ofonod[8803]: src/gprs.c:netreg_status_changed() 4
ofonod[8803]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 38,
toread: 17
ofonod[8803]: src/network.c:current_operator_callback() 0xa0295c0, (nil)
ofonod[8803]: src/gprs.c:netreg_status_changed() 4
ofonod[8803]: src/gprs.c:ofono_gprs_status_notify() /ste0 status 0
ofonod[8803]: src/gprs.c:netreg_status_changed() 1
ofonod[8803]: drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 405, mnc: 034
ofonod[8803]: src/gprs.c:gprs_attach_callback() /ste0 error =3D 0
ofonod[8803]: src/gprs.c:ofono_gprs_status_notify() /ste0 status 1
ofonod[8803]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: ,
405 034 0
ofonod[8803]: src/network.c:current_operator_callback() 0xa0295c0, (nil)
ofonod[8803]: src/gprs.c:netreg_status_changed() 1
ofonod[8803]: src/gprs.c:registration_status_cb() /ste0 error 0 status 1
ofonod[8803]: src/gprs.c:ofono_gprs_status_notify() /ste0 status 1
Control @ ste_gprs_activate_primary
 Command is AT+CGDCONT=3D1,"IP",""
Control @ ste_cgdcont_cb
Control 1 @ ste_cgdcont_cb
ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context failed
with error: Unknown error type



I am trying with ste modem

Note: tried to active through  active_context script file at test folder

Thanks

Yuvaraj R

--===============7518151031729885183==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+PGJyPk5vdyBpIGhhdmUgdGFrZW4gdmVyc2lvbiAwLjQ1LiBNb2RlbSBl
bmFibGVkIHN1Y2Nlc3NmdWxseS48YnI+PGJyPldoZW4gaSBhbSB0cnlpbmcgYWN0aXZhdGUgcGRw
IGNvbnRleHQuLCBJdCBpcyBmYWlsaW5nIHdpdGggdW5rbm93biBlcnJvcnMuPGJyPjxicj48Yj5Q
bGVhc2UgcmVmZXIgbG9nIG1lc3NhZ2VzIGJlbG93PC9iPjxicj48YnI+bm9kWzg4MDNdOiBzcmMv
bmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2goKSAweGEwMjk1YzA8YnI+
Cm9mb25vZFs4ODAzXTogc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dh
dGNoKCkgMHhhMDI5NWMwPGJyPm9mb25vZFs4ODAzXTogc3JjL21lc3NhZ2Utd2FpdGluZy5jOm13
X2NwaHNfbXdpc19yZWFkX2NiKCkgTm8gQ1BIUyBNV0lTIG9uIFNJTTxicj5vZm9ub2RbODgwM106
IHNyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4YTAyOTVjMCwgKG5p
bCk8YnI+Cm9mb25vZFs4ODAzXTogc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSA0
PGJyPm9mb25vZFs4ODAzXTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2soKSBidWZv
ZmY6IDAsIHNlZWtvZmY6IDM4LCB0b3JlYWQ6IDE3PGJyPm9mb25vZFs4ODAzXTogc3JjL25ldHdv
cmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHhhMDI5NWMwLCAobmlsKTxicj5vZm9u
b2RbODgwM106IHNyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgNDxicj4Kb2Zvbm9k
Wzg4MDNdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9zdGUwIHN0YXR1
cyAwPGJyPm9mb25vZFs4ODAzXTogc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAx
PGJyPm9mb25vZFs4ODAzXTogZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6
Y29wc19udW1lcmljX2NiKCkgQ29wcyBudW1lcmljIGdvdCBtY2M6IDQwNSwgbW5jOiAwMzQ8YnI+
Cm9mb25vZFs4ODAzXTogc3JjL2dwcnMuYzpncHJzX2F0dGFjaF9jYWxsYmFjaygpIC9zdGUwIGVy
cm9yID0gMDxicj5vZm9ub2RbODgwM106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19zdGF0dXNfbm90
aWZ5KCkgL3N0ZTAgc3RhdHVzIDE8YnI+b2Zvbm9kWzg4MDNdOiBkcml2ZXJzL2F0bW9kZW0vbmV0
d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX2NiKCkgY29wc19jYjogLCA0MDUgMDM0IDA8YnI+Cm9m
b25vZFs4ODAzXTogc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHhh
MDI5NWMwLCAobmlsKTxicj5vZm9ub2RbODgwM106IHNyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19j
aGFuZ2VkKCkgMTxicj5vZm9ub2RbODgwM106IHNyYy9ncHJzLmM6cmVnaXN0cmF0aW9uX3N0YXR1
c19jYigpIC9zdGUwIGVycm9yIDAgc3RhdHVzIDE8YnI+b2Zvbm9kWzg4MDNdOiBzcmMvZ3Bycy5j
Om9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9zdGUwIHN0YXR1cyAxPGJyPgpDb250cm9sIEAg
c3RlX2dwcnNfYWN0aXZhdGVfcHJpbWFyeTxicj6gQ29tbWFuZCBpcyBBVCtDR0RDT05UPTEsJnF1
b3Q7SVAmcXVvdDssJnF1b3Q7JnF1b3Q7PGJyPkNvbnRyb2wgQCBzdGVfY2dkY29udF9jYjxicj5D
b250cm9sIDEgQCBzdGVfY2dkY29udF9jYjxicj5vZm9ub2RbODgwM106IHNyYy9ncHJzLmM6cHJp
X2FjdGl2YXRlX2NhbGxiYWNrKCkgMHhhMDJmODY4IChudWxsKTxicj4Kb2Zvbm9kWzg4MDNdOiBz
cmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIEFjdGl2YXRpbmcgY29udGV4dCBmYWls
ZWQgd2l0aCBlcnJvcjogVW5rbm93biBlcnJvciB0eXBlPGJyPjxicj48YnI+PGJyPkkgYW0gdHJ5
aW5nIHdpdGggc3RlIG1vZGVtPGJyPjxicj5Ob3RlOiB0cmllZCB0byBhY3RpdmUgdGhyb3VnaKAg
YWN0aXZlX2NvbnRleHQgc2NyaXB0IGZpbGUgYXQgdGVzdCBmb2xkZXI8YnI+Cjxicj5UaGFua3M8
YnI+PGJyPll1dmFyYWogUjxicj48YnI+PGJyPgo=

--===============7518151031729885183==--

