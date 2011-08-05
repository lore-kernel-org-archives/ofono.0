Content-Type: multipart/mixed; boundary="===============7950560187670134991=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 08/14] huaweicdma: register to CDMA netreg atom.
Date: Fri, 05 Aug 2011 15:21:09 +0200
Message-ID: <1312550475-8537-9-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7950560187670134991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 75aacb2..4c83114 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -34,6 +34,7 @@
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
+#include <ofono/cdma-netreg.h>
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

@@ -210,6 +211,8 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	DBG("%p", modem);
 =

+	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->modem);
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

--===============7950560187670134991==--

