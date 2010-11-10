Content-Type: multipart/mixed; boundary="===============3841194813848453225=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 4/4] isigen: make number of PDP contexts configurable
Date: Wed, 10 Nov 2010 14:22:31 +0200
Message-ID: <1289391751-2844-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1289391751-2844-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3841194813848453225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isigen.c |   23 +++++++++++++++++------
 plugins/udev.c   |    6 +++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 838d060..cee4e44 100644
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
@@ -407,6 +409,8 @@ static void isigen_post_online(struct ofono_modem *mode=
m)
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	int pdps =3D ofono_modem_get_integer(modem, "PDPS");
+	int i;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

@@ -420,13 +424,20 @@ static void isigen_post_online(struct ofono_modem *mo=
dem)
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
-	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-	else
-		DBG("Failed to add context");
+	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
+	if (!gprs)
+		return;
+	if (!pdps)
+		pdps =3D ISI_DEFAULT_PDPS;
+	for (i =3D 1; i <=3D pdps; i++) {
+		gc =3D ofono_gprs_context_create(isi->modem, 0,
+						"isimodem", isi->idx);
+		if (gc)
+			ofono_gprs_add_context(gprs, gc);
+		else
+			DBG("Failed to add context %d", i);
+	}
 }
 =

 static int isigen_enable(struct ofono_modem *modem)
diff --git a/plugins/udev.c b/plugins/udev.c
index 737a637..a25adcd 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -423,7 +423,7 @@ static void add_nokia(struct ofono_modem *modem,
 static void add_isi(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-	const char *ifname, *type, *addr;
+	const char *ifname, *type, *addr, *pdps;
 =

 	DBG("modem %p", modem);
 =

@@ -434,6 +434,10 @@ static void add_isi(struct ofono_modem *modem,
 	if (addr !=3D NULL)
 		ofono_modem_set_integer(modem, "Address", atoi(addr));
 =

+	pdps =3D get_property(udev_device, "OFONO_ISI_PDPS");
+	if (pdps !=3D NULL)
+		ofono_modem_set_integer(modem, "PDPS", atoi(pdps));
+
 	if (g_strcmp0(udev_device_get_subsystem(udev_device), "net") !=3D 0)
 		return;
 =

-- =

1.7.0.4


--===============3841194813848453225==--

