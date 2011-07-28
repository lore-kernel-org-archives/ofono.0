Content-Type: multipart/mixed; boundary="===============6774952187576228459=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v3 4/4] speedupcdma: register to CDMA network registration
 atom.
Date: Thu, 28 Jul 2011 13:37:56 +0200
Message-ID: <1311853076-15878-5-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311853076-15878-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6774952187576228459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedupcdma.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index 2194a80..8a89f1a 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -35,6 +35,7 @@
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
 #include <ofono/cdma-connman.h>
+#include <ofono/cdma-netreg.h>
 #include <ofono/log.h>
 =

 struct speedupcdma_data {
@@ -207,6 +208,8 @@ static void speedupcdma_post_online(struct ofono_modem =
*modem)
 =

 	DBG("%p", modem);
 =

+	ofono_cdma_netreg_create(modem, 0, "cdmamodem", data->aux);
+
 	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
 }
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6774952187576228459==--

