Content-Type: multipart/mixed; boundary="===============4156267239893044215=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 4/6] atmodem: follow separate event chat with huawei
Date: Fri, 30 Apr 2010 15:55:18 +0300
Message-ID: <20100430125518.30019.69142.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4156267239893044215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CGREG notifications are received in this channel.
---

 drivers/atmodem/gprs.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index d12d9eb..36f5ce3 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -47,7 +47,7 @@ static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NU=
LL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
-	GAtChat *chat;
+	GAtChat *chat, *event;
 	unsigned int vendor;
 };
 =

@@ -170,9 +170,18 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtChat *chat;
+
+	DBG("");
+
+	if (gd->vendor =3D=3D OFONO_VENDOR_HUAWEI)
+		/* Huawei uses separate serial port for events */
+		chat =3D gd->event;
+	else
+		chat =3D gd->chat;
 =

-	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
-	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
+	g_at_chat_register(chat, "+CGREG:", cgreg_notify,
 				FALSE, gprs, NULL);
 =

 	ofono_gprs_register(gprs);
@@ -297,6 +306,7 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	gd =3D g_new0(struct gprs_data, 1);
 	gd->chat =3D atmodem->chat;
+	gd->event =3D atmodem->event;
 	gd->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, gd);


--===============4156267239893044215==--

