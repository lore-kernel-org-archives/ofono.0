Content-Type: multipart/mixed; boundary="===============3987619766251173085=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 2/2] huawei: Use AlwaysOnline for CDMA modems
Date: Thu, 28 Mar 2013 17:00:40 -0400
Message-ID: <20130328210040.GB31496@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3987619766251173085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 plugins/huawei.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..59995b3 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -447,6 +447,13 @@ static void sysinfo_enable_cb(gboolean ok, GAtResult *=
result,
 	g_at_chat_send(data->pcui, "AT^CVOICE=3D?", cvoice_prefix,
 					cvoice_support_cb, modem, NULL);
 =

+	/* For CDMA we use AlwaysOnline so we leave the modem online. */
+	if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE) {
+		ofono_modem_set_boolean(modem, "AlwaysOnline", TRUE);
+		ofono_modem_set_powered(modem, TRUE);
+		return;
+	}
+
 	if (g_at_chat_send(data->pcui, data->offline_command, none_prefix,
 					cfun_offline, modem, NULL) > 0)
 		return;
-- =

1.7.0.4

--===============3987619766251173085==--

