Content-Type: multipart/mixed; boundary="===============2278563009622731769=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 8/8] gobi: add LTE atom
Date: Tue, 11 Apr 2017 10:18:18 +0200
Message-ID: <20170411081818.19544-9-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2278563009622731769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index df35f94..58df2ce 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -42,6 +42,7 @@
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/lte.h>
 #include <ofono/radio-settings.h>
 #include <ofono/location-reporting.h>
 #include <ofono/log.h>
@@ -506,6 +507,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 		if (gprs && gc)
 			ofono_gprs_add_context(gprs, gc);
 	}
+
+	ofono_lte_create(modem, "qmimodem", data->device);
 }
 =

 static struct ofono_modem_driver gobi_driver =3D {
-- =

2.9.3


--===============2278563009622731769==--

