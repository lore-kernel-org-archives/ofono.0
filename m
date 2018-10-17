Content-Type: multipart/mixed; boundary="===============2689053923121732745=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 19:10:36 +0200
Message-ID: <20181017171037.14324-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2689053923121732745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added voicecall atom specific for Gemalto modems.
This atom uses the URC ^SLCC to monitor the call status, as well as
incoming calls.
Note the use in the atom of the variable GemaltoVtsQuotes: this is
needed to support future modules, as of today not yet available in the
plugin.
---
 Makefile.am                         | 3 ++-
 drivers/gemaltomodem/gemaltomodem.c | 3 +++
 drivers/gemaltomodem/gemaltomodem.h | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 6667524f..e8e4ed95 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,7 +397,8 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
-			drivers/gemaltomodem/location-reporting.c
+			drivers/gemaltomodem/location-reporting.c \
+			drivers/gemaltomodem/voicecall.c
 =

 builtin_modules +=3D xmm7modem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 91cf238a..4818ac66 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -35,12 +36,14 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
+	gemalto_voicecall_init();
 =

 	return 0;
 }
 =

 static void gemaltomodem_exit(void)
 {
+	gemalto_voicecall_exit();
 	gemalto_location_reporting_exit();
 }
 =

diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 7ea1e8fb..b08ab438 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -23,3 +24,7 @@
 =

 extern void gemalto_location_reporting_init();
 extern void gemalto_location_reporting_exit();
+
+extern void gemalto_voicecall_init();
+extern void gemalto_voicecall_exit();
+
-- =

2.17.1


--===============2689053923121732745==--

