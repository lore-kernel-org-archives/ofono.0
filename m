Content-Type: multipart/mixed; boundary="===============2843797405280128665=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] drivers: Add data strength notification support
Date: Tue, 06 Dec 2011 10:33:43 +0100
Message-ID: <1323164023-919-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2843797405280128665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweicdmamodem/network-registration.c |   28 ++++++++++++++++++++=
++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
index 25c6291..fc054d5 100644
--- a/drivers/huaweicdmamodem/network-registration.c
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -141,6 +141,31 @@ error:
 	ofono_error("Invalid RSSILVL value");
 }
 =

+static void hrssilvl_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	int strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^HRSSILVL:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		goto error;
+
+	if (strength =3D=3D 99)
+		strength =3D 100;
+
+	ofono_cdma_netreg_data_strength_notify(netreg, strength);
+
+	return;
+
+error:
+	ofono_error("Invalid HRSSILVL value");
+}
+
 static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
@@ -157,6 +182,9 @@ static void probe_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	g_at_chat_register(chat, "^RSSILVL:",
 				rssilvl_notify, FALSE, netreg, NULL);
 =

+	g_at_chat_register(chat, "^HRSSILVL:",
+				hrssilvl_notify, FALSE, netreg, NULL);
+
 	ofono_cdma_netreg_register(netreg);
 }
 =

-- =

1.7.1


--===============2843797405280128665==--

