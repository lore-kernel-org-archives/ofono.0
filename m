Content-Type: multipart/mixed; boundary="===============1785014522191910483=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 3/6] SIMCOM: add a quirk for signal strength reporting.
Date: Fri, 19 Jul 2013 15:35:37 +0200
Message-ID: <1374240940-30892-3-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1374240940-30892-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1785014522191910483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We must tell we want the signal strength reporting using
AT+AUTOCSQ command (ref. "SIM5215_SIM5216_ATC_V1.18.pdf - =C2=A710.7").
---
 drivers/atmodem/network-registration.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 24b71a3..8cc04b7 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1753,6 +1753,14 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	}
 =

 	switch (nd->vendor) {
+	case OFONO_VENDOR_SIMCOM:
+		/* Register for CSQ changes */
+		g_at_chat_send(nd->chat, "AT+AUTOCSQ=3D1,1", none_prefix,
+				NULL, NULL, NULL);
+
+		g_at_chat_register(nd->chat, "+CSQ:",
+				   csq_notify, FALSE, netreg, NULL);
+		break;
 	case OFONO_VENDOR_PHONESIM:
 		g_at_chat_register(nd->chat, "+CSQ:",
 					csq_notify, FALSE, netreg, NULL);
@@ -1898,7 +1906,6 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
-	case OFONO_VENDOR_SIMCOM:
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	default:
-- =

1.8.3.1


--===============1785014522191910483==--

