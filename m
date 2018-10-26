Content-Type: multipart/mixed; boundary="===============2225989114097375523=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 3/6] gobi: modem driver cannot be a plugin
Date: Fri, 26 Oct 2018 11:54:16 +0200
Message-ID: <20181026095419.26260-4-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2225989114097375523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch converts the gobi driver from being a 'plugin' to being a
regular 'modem driver'.

Modem drivers, in general, use a lot of internal ofono functionality and
cannot be built standalone against just the exported ofono headers.  As
such, these cannot be built as plugins and therefore should netiher be part
of the plugins directory nor declared as plugins.
---
 Makefile.am                          |  5 ++---
 {plugins =3D> drivers/qmimodem}/gobi.c | 13 +------------
 2 files changed, 3 insertions(+), 15 deletions(-)
 rename {plugins =3D> drivers/qmimodem}/gobi.c (97%)

diff --git a/Makefile.am b/Makefile.am
index e8e4ed95..f7bcb4cd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -237,10 +237,9 @@ builtin_sources +=3D $(qmi_sources) \
 			drivers/qmimodem/lte.c \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c \
-			drivers/qmimodem/netmon.c
+			drivers/qmimodem/netmon.c \
+			drivers/qmimodem/gobi.c
 =

-builtin_modules +=3D gobi
-builtin_sources +=3D plugins/gobi.c
 endif
 =

 if ATMODEM
diff --git a/plugins/gobi.c b/drivers/qmimodem/gobi.c
similarity index 97%
rename from plugins/gobi.c
rename to drivers/qmimodem/gobi.c
index d5a5965e..69a682a8 100644
--- a/plugins/gobi.c
+++ b/drivers/qmimodem/gobi.c
@@ -529,15 +529,4 @@ static const struct ofono_modem_driver gobi_driver =3D=
 {
 	.post_online	=3D gobi_post_online,
 };
 =

-static int gobi_init(void)
-{
-	return ofono_modem_driver_register(&gobi_driver);
-}
-
-static void gobi_exit(void)
-{
-	ofono_modem_driver_unregister(&gobi_driver);
-}
-
-OFONO_PLUGIN_DEFINE(gobi, "Qualcomm Gobi modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, gobi_init, gobi_exit)
+OFONO_MODEM_DRIVER(&gobi_driver)
-- =

2.17.1


--===============2225989114097375523==--

