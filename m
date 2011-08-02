Content-Type: multipart/mixed; boundary="===============5195795587026765604=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v4 6/6] cdmamodem: register for network status notification.
Date: Tue, 02 Aug 2011 14:45:22 +0200
Message-ID: <1312289122-22845-7-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312289122-22845-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5195795587026765604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/network-registration.c |   75 ++++++++++++++++++++++++++=
++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
index 92dad56..665f940 100644
--- a/drivers/cdmamodem/network-registration.c
+++ b/drivers/cdmamodem/network-registration.c
@@ -34,10 +34,79 @@
 =

 #include "cdmamodem.h"
 =

+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
 struct netreg_data {
 	GAtChat *chat;
 };
 =

+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	gint srv_status;
+	gint srv_domain;
+	gint roaming_status;
+	int status;
+	GAtResultIter iter;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &roaming_status))
+		return;
+
+	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
+
+	switch (srv_status) {
+	case 0:	/* No service */
+	case 4:	/* Not registered */
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	case 1:	/* Restricted service */
+	case 2:	/* Service valid */
+	case 3:	/* Restricted region service */
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
+		break;
+	default:
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_UNKNOWN;
+		break;
+	}
+
+	switch (srv_domain) {
+	case 0: /* No service */
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	case 1: /* Only CS */
+	case 2: /* Only PS */
+	case 3: /* CS + PS */
+	case 4: /* CS registered, PS in searching state */
+		break;
+	}
+
+	ofono_cdma_netreg_status_notify(netreg, status);
+}
+
+
+static void mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
+				netreg, NULL);
+}
+
 static int cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
 				unsigned int vendor, void *data)
 {
@@ -49,8 +118,14 @@ static int cdma_netreg_probe(struct ofono_cdma_netreg *=
netreg,
 	nd->chat =3D g_at_chat_clone(chat);
 	ofono_cdma_netreg_set_data(netreg, nd);
 =

+	g_at_chat_register(nd->chat, "^MODE:",
+				mode_notify, FALSE, netreg, NULL);
+
 	ofono_cdma_netreg_register(netreg);
 =

+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
+				netreg, NULL);
+
 	return 0;
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

--===============5195795587026765604==--

