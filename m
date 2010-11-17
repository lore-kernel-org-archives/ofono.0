Content-Type: multipart/mixed; boundary="===============8664582802828423734=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH] ifxmodem: Adding fast dormancy support to Infineon modem
Date: Wed, 17 Nov 2010 11:29:24 -0800
Message-ID: <1290022164-24730-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8664582802828423734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Initial patch to add fast dormancy to Infineon modem. Timeout is not
supported yet.

Thanks,
-- r.

---
 drivers/ifxmodem/radio-settings.c |   40 +++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index 89e97e7..68077db 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <errno.h>
 =

 #include <glib.h>
@@ -45,6 +46,7 @@ static const char *xrat_prefix[] =3D { "+XRAT:", NULL };
 =

 struct radio_settings_data {
 	GAtChat *chat;
+	uint16_t fast_dormancy;
 };
 =

 static void xrat_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -196,12 +198,48 @@ static void ifx_radio_settings_remove(struct ofono_ra=
dio_settings *rs)
 	g_free(rsd);
 }
 =

+static void update_fast_dormancy(struct radio_settings_data *rsd)
+{
+	char buf[20];
+
+	snprintf(buf, sizeof(buf), "AT+XFDOR=3D%u", rsd->fast_dormancy);
+
+	if (g_at_chat_send(rsd->chat, buf, NULL, NULL, NULL, NULL) > 0)
+		DBG("3G fast dormancy %s.",
+			rsd->fast_dormancy ? "enabled" : "disabled");
+	else
+		DBG("3G fast dormancy unchanged.");
+}
+
+static void ifx_set_fast_dormancy(struct ofono_radio_settings *rs,
+				int enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	rsd->fast_dormancy =3D enable ? 1 : 0;
+	update_fast_dormancy(rsd);
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void ifx_query_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+
+	/* there is no read AT command */
+	CALLBACK_WITH_SUCCESS(cb, rsd->fast_dormancy, data);
+}
+
 static struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "ifxmodem",
 	.probe			=3D ifx_radio_settings_probe,
 	.remove			=3D ifx_radio_settings_remove,
 	.query_rat_mode		=3D ifx_query_rat_mode,
-	.set_rat_mode		=3D ifx_set_rat_mode
+	.set_rat_mode		=3D ifx_set_rat_mode,
+	.query_fast_dormancy	=3D ifx_query_fast_dormancy,
+	.set_fast_dormancy	=3D ifx_set_fast_dormancy
 };
 =

 void ifx_radio_settings_init()
-- =

1.7.0.4


--===============8664582802828423734==--

