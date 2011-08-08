Content-Type: multipart/mixed; boundary="===============4198573110381304691=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v7 3/4] huaweicdma: register to ^RSSILVL to update signal
 strength.
Date: Mon, 08 Aug 2011 13:53:28 +0200
Message-ID: <1312804409-6913-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312804409-6913-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4198573110381304691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bertrand Aygon <bertrand.aygon@intel.com>

---
 drivers/huaweicdmamodem/network-registration.c |   28 ++++++++++++++++++++=
++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
index d2f68ca..2d3a438 100644
--- a/drivers/huaweicdmamodem/network-registration.c
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -116,6 +116,31 @@ static void mode_notify(GAtResult *result, gpointer us=
er_data)
 				sysinfo_cb, netreg, NULL);
 }
 =

+static void rssilvl_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	int strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^RSSILVL:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		goto error;
+
+	if (strength =3D=3D 99)
+		strength =3D 100;
+
+	ofono_cdma_netreg_strength_notify(netreg, strength);
+
+	return;
+
+error:
+	ofono_error("Invalid RSSILVL value");
+}
+
 static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
@@ -129,6 +154,9 @@ static void probe_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	g_at_chat_register(chat, "^MODE:",
 				mode_notify, FALSE, netreg, NULL);
 =

+	g_at_chat_register(chat, "^RSSILVL:",
+				rssilvl_notify, FALSE, netreg, NULL);
+
 	ofono_cdma_netreg_register(netreg);
 }
 =

-- =

1.7.1


--===============4198573110381304691==--

