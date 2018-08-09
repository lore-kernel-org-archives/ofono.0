Content-Type: multipart/mixed; boundary="===============4096419060097455648=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] added voice call support to ublox plugin
Date: Thu, 09 Aug 2018 09:00:51 +0200
Message-ID: <1533798051-2920-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4096419060097455648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index cfcdd3f..28aaab4 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -40,6 +40,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/netmon.h>
 #include <ofono/lte.h>
+#include <ofono/voicecall.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -286,6 +287,14 @@ static void ublox_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+	/*
+	 * Call support is technically possible only after sim insertion =

+	 * with the module online. However the EMERGENCY_SETUP procedure of
+	 * the 3GPP TS_24.008 is triggered by the same AT command,
+	 * and namely 'ATD112;' and 'ATD911;'. Therefore it makes sense to
+	 * add the voice support as soon as possible.
+	 */
+	ofono_voicecall_create(modem, 0, "atmodem", data->aux);
 	sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
 					data->aux);
 =

-- =

1.9.1


--===============4096419060097455648==--

