Content-Type: multipart/mixed; boundary="===============2364519599641668630=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v9 2/4] huaweicdma: register to CDMA netreg atom.
Date: Mon, 08 Aug 2011 14:13:18 +0200
Message-ID: <1312805600-20043-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312805600-20043-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2364519599641668630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bertrand Aygon <bertrand.aygon@intel.com>

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

1.7.1


--===============2364519599641668630==--

