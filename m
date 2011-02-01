Content-Type: multipart/mixed; boundary="===============7399376908326638658=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH] ste: Add support for CBS interface
Date: Tue, 01 Feb 2011 16:49:47 +0200
Message-ID: <1296571787-21852-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7399376908326638658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

STE modems support standard AT commands in CBS
---
 plugins/ste.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 0b02a0d..cf8aed8 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -48,6 +48,7 @@
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
+#include <ofono/cbs.h>
 #include <ofono/sms.h>
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
@@ -373,6 +374,7 @@ static void ste_post_online(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
+	ofono_cbs_create(modem, 0, "atmodem", data->chat);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->chat);
-- =

1.7.0.4


--===============7399376908326638658==--

