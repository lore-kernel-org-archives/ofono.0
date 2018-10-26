Content-Type: multipart/mixed; boundary="===============1263449443423394953=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 5/6] telitmodem: simplify driver registration
Date: Fri, 26 Oct 2018 11:54:18 +0200
Message-ID: <20181026095419.26260-6-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1263449443423394953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using the driver registration macros saves us having to declare a plugin
just to have the drivers registered.
---
 Makefile.am                             |  3 --
 drivers/telitmodem/gprs-context-ncm.c   | 15 +-------
 drivers/telitmodem/location-reporting.c | 16 ++------
 drivers/telitmodem/telitmodem.c         | 51 -------------------------
 drivers/telitmodem/telitmodem.h         | 27 -------------
 5 files changed, 5 insertions(+), 107 deletions(-)
 delete mode 100644 drivers/telitmodem/telitmodem.c
 delete mode 100644 drivers/telitmodem/telitmodem.h

diff --git a/Makefile.am b/Makefile.am
index f7bcb4cd..49b6cbb7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -320,10 +320,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/stk.c \
 			drivers/mbmmodem/location-reporting.c
 =

-builtin_modules +=3D telitmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/telitmodem/telitmodem.h \
-			drivers/telitmodem/telitmodem.c \
 			drivers/telitmodem/location-reporting.c \
 			drivers/telitmodem/gprs-context-ncm.c
 =

diff --git a/drivers/telitmodem/gprs-context-ncm.c b/drivers/telitmodem/gpr=
s-context-ncm.c
index c4e60e21..63146605 100644
--- a/drivers/telitmodem/gprs-context-ncm.c
+++ b/drivers/telitmodem/gprs-context-ncm.c
@@ -31,10 +31,7 @@
 #include <ofono/modem.h>
 #include <ofono/gprs-context.h>
 =

-#include "gatchat.h"
-#include "gatresult.h"
-
-#include "telitmodem.h"
+#include <drivers/atmodem/atutil.h>
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
@@ -476,12 +473,4 @@ static const struct ofono_gprs_context_driver driver =
=3D {
 	.deactivate_primary	=3D telitncm_gprs_deactivate_primary,
 };
 =

-void telitncm_gprs_context_init(void)
-{
-	ofono_gprs_context_driver_register(&driver);
-}
-
-void telitncm_gprs_context_exit(void)
-{
-	ofono_gprs_context_driver_unregister(&driver);
-}
+OFONO_GPRS_CONTEXT_DRIVER(&driver)
diff --git a/drivers/telitmodem/location-reporting.c b/drivers/telitmodem/l=
ocation-reporting.c
index 245c29c2..638a8760 100644
--- a/drivers/telitmodem/location-reporting.c
+++ b/drivers/telitmodem/location-reporting.c
@@ -35,11 +35,9 @@
 #include <ofono/modem.h>
 #include <ofono/location-reporting.h>
 =

-#include "gatchat.h"
-#include "gatresult.h"
-#include "gattty.h"
+#include <drivers/atmodem/atutil.h>
 =

-#include "telitmodem.h"
+#include "gattty.h"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *portcfg_prefix[] =3D { "#PORTCFG:", NULL };
@@ -303,12 +301,4 @@ static const struct ofono_location_reporting_driver dr=
iver =3D {
 	.disable		=3D telit_location_reporting_disable,
 };
 =

-void telit_location_reporting_init()
-{
-	ofono_location_reporting_driver_register(&driver);
-}
-
-void telit_location_reporting_exit()
-{
-	ofono_location_reporting_driver_unregister(&driver);
-}
+OFONO_LOCATION_REPORTING_DRIVER(&driver)
diff --git a/drivers/telitmodem/telitmodem.c b/drivers/telitmodem/telitmode=
m.c
deleted file mode 100644
index 4aa2c444..00000000
--- a/drivers/telitmodem/telitmodem.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <glib.h>
-#include <gatchat.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/types.h>
-
-#include "telitmodem.h"
-
-static int telitmodem_init(void)
-{
-	telit_location_reporting_init();
-	telitncm_gprs_context_init();
-
-	return 0;
-}
-
-static void telitmodem_exit(void)
-{
-	telit_location_reporting_exit();
-	telitncm_gprs_context_exit();
-}
-
-OFONO_PLUGIN_DEFINE(telitmodem, "Telit modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT,
-			telitmodem_init, telitmodem_exit)
diff --git a/drivers/telitmodem/telitmodem.h b/drivers/telitmodem/telitmode=
m.h
deleted file mode 100644
index 8a14595a..00000000
--- a/drivers/telitmodem/telitmodem.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#include <drivers/atmodem/atutil.h>
-
-extern void telit_location_reporting_init();
-extern void telit_location_reporting_exit();
-extern void telitncm_gprs_context_init();
-extern void telitncm_gprs_context_exit();
-- =

2.17.1


--===============1263449443423394953==--

