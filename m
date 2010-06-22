Content-Type: multipart/mixed; boundary="===============4984809650671093644=="
MIME-Version: 1.0
From: Benoit Monin <benoit.monin@laposte.net>
Subject: hso : swap username and password for PAP
Date: Tue, 22 Jun 2010 09:16:58 +0000
Message-ID: <7342887.98669.1277198212796.JavaMail.www@wwinf8402>
In-Reply-To: <25118539.98442.1277198076995.JavaMail.www@wwinf8402>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4984809650671093644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



The parameters for the AT command AT$QCPDPP must be swapped for PAP in order
to make it work with an Option modem. Tested with a GTM382 development kit.
No idea about CHAP parameters, left unchanged.

Signed-off-by: Beno=C3=AEt Monin =

---
drivers/hsomodem/gprs-context.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index 08c662f..87b6a09 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -166,7 +166,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,

if (ctx->username[0] && ctx->password[0])
snprintf(buf, sizeof(buf), "AT$QCPDPP=3D%u,1,\"%s\",\"%s\"",
- ctx->cid, ctx->username, ctx->password);
+ ctx->cid, ctx->password, ctx->username);
else if (ctx->password[0])
snprintf(buf, sizeof(buf), "AT$QCPDPP=3D%u,2,,\"%s\"",
ctx->cid, ctx->password);
--





Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net


--===============4984809650671093644==--

