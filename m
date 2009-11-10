Content-Type: multipart/mixed; boundary="===============6954113423734195524=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] Add SMS support for Palm Pre with a vendor quirk
Date: Tue, 10 Nov 2009 07:30:39 +0100
Message-ID: <1257834639-22467-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6954113423734195524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c |    7 ++++---
 plugins/palmpre.c     |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index b3d6ff5..20ab47a 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -680,9 +680,10 @@ static gboolean build_cnmi_string(char *buf, int *cnmi=
_opts,
 	const char *mode;
 	int len =3D sprintf(buf, "AT+CNMI=3D");
 =

-	if (data->vendor =3D=3D OFONO_VENDOR_HTC_G1)
-		/* The G1 advertises support for mode 2, but returns an error
-		 * if we attempt to actually use it. */
+	if (data->vendor =3D=3D OFONO_VENDOR_HTC_G1 ||
+			data->vendor =3D=3D OFONO_VENDOR_MSM)
+		/* These devices advertise support for mode 2, but return
+		 * an error if we attempt to actually use it. */
 		mode =3D "1";
 	else
 		/* Sounds like 2 is the sanest mode */
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 37cb7b6..12add93 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -42,6 +42,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/sms.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -182,6 +183,7 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, OFONO_VENDOR_MSM, "atmodem", data->chat);
 	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
-- =

1.6.1


--===============6954113423734195524==--

