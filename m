Content-Type: multipart/mixed; boundary="===============3509315960507790610=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 11/14] huaweicdma: register to ^RSSILVL to update signal
 strength.
Date: Fri, 05 Aug 2011 15:21:12 +0200
Message-ID: <1312550475-8537-12-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3509315960507790610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweicdmamodem/network-registration.c |   23 ++++++++++++++++++++=
+++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
index db91882..b82919a 100644
--- a/drivers/huaweicdmamodem/network-registration.c
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -115,6 +115,26 @@ static void mode_notify(GAtResult *result, gpointer us=
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
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	if (strength =3D=3D 99)
+		strength =3D 100;
+
+	ofono_cdma_netreg_strength_notify(netreg, strength);
+}
+
 static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
@@ -142,6 +162,9 @@ static int huaweicdma_netreg_probe(struct ofono_cdma_ne=
treg *netreg,
 	g_at_chat_register(nd->chat, "^MODE:",
 				mode_notify, FALSE, netreg, NULL);
 =

+	g_at_chat_register(nd->chat, "^RSSILVL:",
+				rssilvl_notify, FALSE, netreg, NULL);
+
 	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
 				probe_cb, netreg, NULL);
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

--===============3509315960507790610==--

