Content-Type: multipart/mixed; boundary="===============4649287965681593269=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/3] Speedup: Use speedup specific driver for ussd
Date: Mon, 16 Apr 2012 17:10:22 +0200
Message-ID: <1334589023-3633-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1334589023-3633-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4649287965681593269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index ca6ed13..8b95286 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -282,8 +282,8 @@ static void speedup_post_online(struct ofono_modem *mod=
em)
 =

 	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->aux);
-	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-						"atmodem", data->aux);
+	ofono_ussd_create(modem, OFONO_VENDOR_SPEEDUP,
+						"speedupmodem", data->aux);
 }
 =

 static struct ofono_modem_driver speedup_driver =3D {
-- =

1.7.5.4


--===============4649287965681593269==--

