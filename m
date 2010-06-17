Content-Type: multipart/mixed; boundary="===============0299698109075464238=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: [PATCH] Enabling PDP Context support in atmodem.
Date: Thu, 17 Jun 2010 23:17:23 +0300
Message-ID: <AANLkTinDk9-gwLP0pC_8Wqud8MXotrAkVxYHBPP7rmys@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0299698109075464238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From d30d8658767de97b0ffb45697616604fb1576741 Mon Sep 17 00:00:00 2001
From: arun <arunlee@gmail.com>
Date: Thu, 17 Jun 2010 21:42:00 +0300
Subject: [PATCH] Enabling PDP Context support in atmodem.

---
 plugins/atgen.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index 4e9c5e7..f3757fb 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -50,6 +50,8 @@
 #include <ofono/voicecall.h>

 #include <drivers/atmodem/sim-poll.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>

 static const char *tty_opts[] =3D {
     "Baud",
@@ -175,6 +177,8 @@ static void atgen_post_sim(struct ofono_modem *modem)
 {
     GAtChat *chat =3D ofono_modem_get_data(modem);
     struct ofono_message_waiting *mw;
+    struct ofono_gprs *gprs;
+    struct ofono_gprs_context *gc;

     DBG("%p", modem);

@@ -187,6 +191,11 @@ static void atgen_post_sim(struct ofono_modem *modem)
     ofono_ssn_create(modem, 0, "atmodem", chat);
     ofono_sms_create(modem, 0, "atmodem", chat);
     ofono_phonebook_create(modem, 0, "atmodem", chat);
+    gprs =3D ofono_gprs_create(modem,0, "atmodem", chat);
+    gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
+
+    if (gprs && gc)
+        ofono_gprs_add_context(gprs, gc);

     mw =3D ofono_message_waiting_create(modem);
     if (mw)
-- =

1.6.3.3

--===============0299698109075464238==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPkZyb20gZDMwZDg2NTg3NjdkZTk3YjBmZmI0NTY5NzYxNjYwNGZiMTU3Njc0MSBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDE8YnI+RnJvbTogYXJ1biAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFydW5s
ZWVAZ21haWwuY29tIj5hcnVubGVlQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPkRhdGU6IFRodSwgMTcg
SnVuIDIwMTAgMjE6NDI6MDAgKzAzMDA8YnI+U3ViamVjdDogW1BBVENIXSBFbmFibGluZyBQRFAg
Q29udGV4dCBzdXBwb3J0IGluIGF0bW9kZW0uPGJyPgoKPGJyPi0tLTxicj6gcGx1Z2lucy9hdGdl
bi5jIHygoKAgOSArKysrKysrKys8YnI+oDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKTxicj48YnI+ZGlmZiAtLWdpdCBhL3BsdWdpbnMvYXRnZW4uYyBiL3Bs
dWdpbnMvYXRnZW4uYzxicj5pbmRleCA0ZTljNWU3Li5mMzc1N2ZiIDEwMDY0NDxicj4tLS0gYS9w
bHVnaW5zL2F0Z2VuLmM8YnI+KysrIGIvcGx1Z2lucy9hdGdlbi5jPGJyPgoKQEAgLTUwLDYgKzUw
LDggQEA8YnI+oCNpbmNsdWRlICZsdDtvZm9uby92b2ljZWNhbGwuaCZndDs8YnI+oDxicj6gI2lu
Y2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2RlbS9zaW0tcG9sbC5oJmd0Ozxicj4rI2luY2x1ZGUgJmx0
O29mb25vL2dwcnMuaCZndDs8YnI+KyNpbmNsdWRlICZsdDtvZm9uby9ncHJzLWNvbnRleHQuaCZn
dDs8YnI+oDxicj6gc3RhdGljIGNvbnN0IGNoYXIgKnR0eV9vcHRzW10gPSB7PGJyPgoKoKCgoCAm
cXVvdDtCYXVkJnF1b3Q7LDxicj5AQCAtMTc1LDYgKzE3Nyw4IEBAIHN0YXRpYyB2b2lkIGF0Z2Vu
X3Bvc3Rfc2ltKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPqB7PGJyPqCgoKAgR0F0Q2hh
dCAqY2hhdCA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8YnI+oKCgoCBzdHJ1Y3Qgb2Zv
bm9fbWVzc2FnZV93YWl0aW5nICptdzs8YnI+K6CgoCBzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Byczs8
YnI+CgoroKCgIHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjOzxicj6gPGJyPqCgoKAgREJH
KCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7PGJyPqA8YnI+QEAgLTE4Nyw2ICsxOTEsMTEgQEAgc3Rh
dGljIHZvaWQgYXRnZW5fcG9zdF9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+oKCg
oCBvZm9ub19zc25fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8
YnI+CgqgoKCgIG9mb25vX3Ntc19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDss
IGNoYXQpOzxicj6goKCgIG9mb25vX3Bob25lYm9va19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0
bW9kZW0mcXVvdDssIGNoYXQpOzxicj4roKCgIGdwcnMgPSBvZm9ub19ncHJzX2NyZWF0ZShtb2Rl
bSwwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8YnI+K6CgoCBnYyA9IG9mb25vX2dwcnNf
Y29udGV4dF9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNoYXQpOzxicj4K
Cis8YnI+K6CgoCBpZiAoZ3BycyAmYW1wOyZhbXA7IGdjKTxicj4roKCgIKCgoCBvZm9ub19ncHJz
X2FkZF9jb250ZXh0KGdwcnMsIGdjKTs8YnI+oDxicj6goKCgIG13ID0gb2Zvbm9fbWVzc2FnZV93
YWl0aW5nX2NyZWF0ZShtb2RlbSk7PGJyPqCgoKAgaWYgKG13KTxicj4tLSA8YnI+MS42LjMuMzxi
cj48YnI+Cg==

--===============0299698109075464238==--

