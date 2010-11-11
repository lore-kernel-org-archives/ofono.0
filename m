Content-Type: multipart/mixed; boundary="===============4228554165551418351=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/1] isigen: create four gprs contexts
Date: Thu, 11 Nov 2010 17:50:00 +0200
Message-ID: <1289490600-25795-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1289490600-25795-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4228554165551418351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isigen.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 838d060..fad4e20 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -58,6 +58,8 @@
 #include "drivers/isimodem/mtc.h"
 #include "drivers/isimodem/debug.h"
 =

+#define ISI_DEFAULT_PDPS 4	/* Number of supported PDP contexts */
+
 struct isi_data {
 	struct ofono_modem *modem;
 	char const *ifname;
@@ -407,6 +409,7 @@ static void isigen_post_online(struct ofono_modem *mode=
m)
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	int i;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

@@ -420,13 +423,21 @@ static void isigen_post_online(struct ofono_modem *mo=
dem)
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
+
 	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
-	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
+	if (!gprs)
+		return;
+
+	for (i =3D 0; i < ISI_DEFAULT_PDPS; i++) {
+		gc =3D ofono_gprs_context_create(isi->modem, 0,
+						"isimodem", isi->idx);
+		if (!gc) {
+			DBG("Failed to add context %d", i);
+			break;
+		}
 =

-	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-	else
-		DBG("Failed to add context");
+	}
 }
 =

 static int isigen_enable(struct ofono_modem *modem)
-- =

1.7.0.4


--===============4228554165551418351==--

