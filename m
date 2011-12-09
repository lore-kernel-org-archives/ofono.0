Content-Type: multipart/mixed; boundary="===============1259584646648608678=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] cdmamodem: Disable dormant mode at initialization
Date: Fri, 09 Dec 2011 12:04:38 +0100
Message-ID: <1323428678-10373-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1259584646648608678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index c03841e..61573ff 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -276,6 +276,20 @@ static void at_c0_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	ofono_cdma_connman_register(cm);
 }
 =

+static void at_cta0_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+
+	DBG("ok %d", ok);
+
+	if (ok =3D=3D FALSE) {
+		ofono_info("Unable to configure Dormant mode");
+		return;
+	}
+
+	ofono_cdma_connman_dormant_notify(cm, FALSE);
+}
+
 static int cdma_connman_probe(struct ofono_cdma_connman *cm,
 					unsigned int vendor, void *data)
 {
@@ -300,6 +314,7 @@ static int cdma_connman_probe(struct ofono_cdma_connman=
 *cm,
 	ofono_cdma_connman_set_data(cm, cd);
 =

 	g_at_chat_send(cd->chat, "AT&C0", none_prefix, at_c0_cb, cm, NULL);
+	g_at_chat_send(cd->chat, "AT+CTA=3D0", none_prefix, at_cta0_cb, cm, NULL);
 =

 	return 0;
 }
-- =

1.7.1


--===============1259584646648608678==--

