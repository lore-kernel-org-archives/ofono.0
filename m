Content-Type: multipart/mixed; boundary="===============2194808335728934839=="
MIME-Version: 1.0
From: Benoit Monin <benoit.monin@laposte.net>
Subject: [PATCH] hso : swap username and password for PAP
Date: Mon, 27 Sep 2010 14:38:27 +0200
Message-ID: <25022413.26143.1285591107292.JavaMail.www@wwinf8219>
In-Reply-To: <4701421.25982.1285590974586.JavaMail.www@wwinf8219>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2194808335728934839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


The parameters for the AT command AT$QCPDPP must be swapped for PAP in order
to make to work with an Option modem. Tested with a GTM382 development kit.
No idea about CHAP parameters.
---
drivers/hsomodem/gprs-context.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index e1c94ad..dc6f1b6 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -165,7 +165,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
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


--===============2194808335728934839==--

