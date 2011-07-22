Content-Type: multipart/mixed; boundary="===============8642458842021438838=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] CDMA devinfo: send AT+GCAP to check devinfo.
Date: Fri, 22 Jul 2011 06:28:04 +0200
Message-ID: <1311308884-11237-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8642458842021438838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/devinfo.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
index 9603e05..2a5813c 100644
--- a/drivers/cdmamodem/devinfo.c
+++ b/drivers/cdmamodem/devinfo.c
@@ -36,6 +36,8 @@
 =

 #include "cdmamodem.h"
 =

+static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
+
 static void attr_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
          struct cb_data *cbd =3D user_data;
@@ -123,13 +125,11 @@ static void cdma_query_serial(struct ofono_devinfo *i=
nfo,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

-static gboolean cdma_devinfo_register(gpointer user_data)
+static void capability_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct ofono_devinfo *info =3D user_data;
 =

 	ofono_devinfo_register(info);
-
-	return FALSE;
 }
 =

 static int cdma_devinfo_probe(struct ofono_devinfo *info,
@@ -138,7 +138,9 @@ static int cdma_devinfo_probe(struct ofono_devinfo *inf=
o,
 	GAtChat *chat =3D data;
 =

 	ofono_devinfo_set_data(info, g_at_chat_clone(chat));
-	g_idle_add(cdma_devinfo_register, info);
+
+	g_at_chat_send(chat, "AT+GCAP", gcap_prefix,
+				capability_cb, info, NULL);
 =

 	return 0;
 }
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8642458842021438838==--

