Content-Type: multipart/mixed; boundary="===============3694028677891101234=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 6/6] telitmodem: modem driver is not a plugin
Date: Fri, 26 Oct 2018 11:54:19 +0200
Message-ID: <20181026095419.26260-7-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3694028677891101234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'modem driver' part of this file uses a lot of internal ofono
functionality and therefore belongs in drivers/, not plugins/.

By using the driver registration macros, the driver is registered on
load, whether it be by way of a plugin or by nature of being part of a
monolithic ofono biuld.  As such, the plugin doesn't need to explicity
register the driver; that leaves this plugin with nothing to do so the
plugin declaration can be dropped altogether.
---
 Makefile.am                             |  4 +---
 {plugins =3D> drivers/telitmodem}/telit.c | 15 +--------------
 2 files changed, 2 insertions(+), 17 deletions(-)
 rename {plugins =3D> drivers/telitmodem}/telit.c (97%)

diff --git a/Makefile.am b/Makefile.am
index 49b6cbb7..76d1769a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -321,6 +321,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/location-reporting.c
 =

 builtin_sources +=3D drivers/atmodem/atutil.h \
+		        drivers/telitmodem/telit.c \
 			drivers/telitmodem/location-reporting.c \
 			drivers/telitmodem/gprs-context-ncm.c
 =

@@ -503,9 +504,6 @@ builtin_sources +=3D plugins/sim7100.c
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

-builtin_modules +=3D telit
-builtin_sources +=3D plugins/telit.c
-
 builtin_modules +=3D quectel
 builtin_sources +=3D plugins/quectel.c
 =

diff --git a/plugins/telit.c b/drivers/telitmodem/telit.c
similarity index 97%
rename from plugins/telit.c
rename to drivers/telitmodem/telit.c
index 5b17aee5..0a394bdf 100644
--- a/plugins/telit.c
+++ b/drivers/telitmodem/telit.c
@@ -549,17 +549,4 @@ static const struct ofono_modem_driver telit_driver =
=3D {
 	.post_online	=3D telit_post_online,
 };
 =

-static int telit_init(void)
-{
-	DBG("");
-
-	return ofono_modem_driver_register(&telit_driver);
-}
-
-static void telit_exit(void)
-{
-	ofono_modem_driver_unregister(&telit_driver);
-}
-
-OFONO_PLUGIN_DEFINE(telit, "Telit driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, telit_init, telit_exit)
+OFONO_MODEM_DRIVER(&telit_driver)
-- =

2.17.1


--===============3694028677891101234==--

