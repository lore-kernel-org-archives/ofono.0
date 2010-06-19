Content-Type: multipart/mixed; boundary="===============3570052009325254148=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Re: [PATCH] Enabling PDP Context support in atmodem.
Date: Sat, 19 Jun 2010 17:53:54 +0300
Message-ID: <AANLkTilwEB1HCRX74FewYplcBa4Pj7roHJDIOxJIpN5M@mail.gmail.com>
In-Reply-To: <201006181257.58444.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3570052009325254148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From b3ad9e14d7cfbe3bd7375cfb56bca3d4f3549585 Mon Sep 17 00:00:00 2001
From: Arun Ravindran <arunlee@gmail.com>
Date: Fri, 18 Jun 2010 23:12:12 +0300
Subject: [PATCH] Enabling PDP Context support in atmodem.

---
 plugins/atgen.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index 4e9c5e7..a6eee60 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -51,6 +51,9 @@

 #include <drivers/atmodem/sim-poll.h>

+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+
 static const char *tty_opts[] =3D {
     "Baud",
     "Read",
@@ -175,6 +178,8 @@ static void atgen_post_sim(struct ofono_modem *modem)
 {
     GAtChat *chat =3D ofono_modem_get_data(modem);
     struct ofono_message_waiting *mw;
+    struct ofono_gprs *gprs;
+    struct ofono_gprs_context *gc;

     DBG("%p", modem);

@@ -187,6 +192,10 @@ static void atgen_post_sim(struct ofono_modem *modem)
     ofono_ssn_create(modem, 0, "atmodem", chat);
     ofono_sms_create(modem, 0, "atmodem", chat);
     ofono_phonebook_create(modem, 0, "atmodem", chat);
+    gprs =3D ofono_gprs_create(modem,0, "atmodem", chat);
+    gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
+    if (gprs && gc)
+        ofono_gprs_add_context(gprs, gc);

     mw =3D ofono_message_waiting_create(modem);
     if (mw)
-- =

1.6.3.3

--===============3570052009325254148==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PkZyb20gYjNhZDllMTRkN2NmYmUzYmQ3Mzc1Y2ZiNTZiY2EzZDRmMzU0OTU4NSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDE8YnI+RnJvbTogQXJ1biBSYXZpbmRyYW4gJmx0OzxhIGhyZWY9Im1haWx0
bzphcnVubGVlQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFydW5sZWVAZ21haWwuY29tPC9h
PiZndDs8YnI+RGF0ZTogRnJpLCAxOCBKdW4gMjAxMCAyMzoxMjoxMiArMDMwMDxicj5TdWJqZWN0
OiBbUEFUQ0hdIEVuYWJsaW5nIFBEUCBDb250ZXh0IHN1cHBvcnQgaW4gYXRtb2RlbS48YnI+Cgo8
YnI+LS0tPGJyPqBwbHVnaW5zL2F0Z2VuLmMgfKCgoCA5ICsrKysrKysrKzxicj6gMSBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj5kaWZmIC0tZ2l0
IGEvcGx1Z2lucy9hdGdlbi5jIGIvcGx1Z2lucy9hdGdlbi5jPGJyPmluZGV4IDRlOWM1ZTcuLmE2
ZWVlNjAgMTAwNjQ0PGJyPi0tLSBhL3BsdWdpbnMvYXRnZW4uYzxicj4rKysgYi9wbHVnaW5zL2F0
Z2VuLmM8YnI+CgpAQCAtNTEsNiArNTEsOSBAQDxicj6gPGJyPqAjaW5jbHVkZSAmbHQ7ZHJpdmVy
cy9hdG1vZGVtL3NpbS1wb2xsLmgmZ3Q7PGJyPqA8YnI+KyNpbmNsdWRlICZsdDtvZm9uby9ncHJz
LmgmZ3Q7PGJyPisjaW5jbHVkZSAmbHQ7b2Zvbm8vZ3Bycy1jb250ZXh0LmgmZ3Q7PGJyPis8YnI+
oHN0YXRpYyBjb25zdCBjaGFyICp0dHlfb3B0c1tdID0gezxicj6goKCgICZxdW90O0JhdWQmcXVv
dDssPGJyPgoKoKCgoCAmcXVvdDtSZWFkJnF1b3Q7LDxicj5AQCAtMTc1LDYgKzE3OCw4IEBAIHN0
YXRpYyB2b2lkIGF0Z2VuX3Bvc3Rfc2ltKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPqB7
PGJyPqCgoKAgR0F0Q2hhdCAqY2hhdCA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8YnI+
oKCgoCBzdHJ1Y3Qgb2Zvbm9fbWVzc2FnZV93YWl0aW5nICptdzs8YnI+K6CgoCBzdHJ1Y3Qgb2Zv
bm9fZ3BycyAqZ3Byczs8YnI+CgoroKCgIHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjOzxi
cj6gPGJyPqCgoKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7PGJyPqA8YnI+QEAgLTE4Nyw2
ICsxOTIsMTAgQEAgc3RhdGljIHZvaWQgYXRnZW5fcG9zdF9zaW0oc3RydWN0IG9mb25vX21vZGVt
ICptb2RlbSk8YnI+oKCgoCBvZm9ub19zc25fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVt
JnF1b3Q7LCBjaGF0KTs8YnI+CgqgoKCgIG9mb25vX3Ntc19jcmVhdGUobW9kZW0sIDAsICZxdW90
O2F0bW9kZW0mcXVvdDssIGNoYXQpOzxicj6goKCgIG9mb25vX3Bob25lYm9va19jcmVhdGUobW9k
ZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNoYXQpOzxicj4roKCgIGdwcnMgPSBvZm9ub19n
cHJzX2NyZWF0ZShtb2RlbSwwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8YnI+K6CgoCBn
YyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVv
dDssIGNoYXQpOzxicj4KCiugoKAgaWYgKGdwcnMgJmFtcDsmYW1wOyBnYyk8YnI+K6CgoCCgoKAg
b2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJzLCBnYyk7PGJyPqA8YnI+oKCgoCBtdyA9IG9mb25v
X21lc3NhZ2Vfd2FpdGluZ19jcmVhdGUobW9kZW0pOzxicj6goKCgIGlmIChtdyk8YnI+LS0gPGJy
PjEuNi4zLjM8YnI+Cg==

--===============3570052009325254148==--

