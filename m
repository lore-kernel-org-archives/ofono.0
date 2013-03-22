Content-Type: multipart/mixed; boundary="===============5517366584862354131=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 4/4] SIMCOM signal strength reporting quirk
Date: Fri, 22 Mar 2013 11:36:18 +0100
Message-ID: <1363948578-24128-4-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1363948578-24128-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5517366584862354131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a quirk for signal strength reporting.

We must tell we want the signal strength reporting using
AT+AUTOCSQ command (ref. SIM5215_SIM5216_ATC_V1.18.pdf - =EF=BF=BD=EF=BF=BD=
10.7).

diff -purN ofono-1.12/drivers/atmodem/network-registration.c ofono-patched/=
drivers/atmodem/network-registration.c
--- ofono-1.12/drivers/atmodem/network-registration.c	2013-01-18 15:04:03.5=
98659165 +0100
+++ ofono-patched/drivers/atmodem/network-registration.c	2013-01-18 14:54:0=
3.256659236 +0100
@@ -1411,6 +1411,14 @@ static void at_creg_set_cb(gboolean ok,
 	}
 =

 	switch (nd->vendor) {
+	case OFONO_VENDOR_SIMCOM:
+		/* Register for CSQ changes */
+		g_at_chat_send(nd->chat, "AT+AUTOCSQ=3D1,1", none_prefix,
+				NULL, NULL, NULL);
+
+		g_at_chat_register(nd->chat, "+CSQ:",
+ 				   csq_notify, FALSE, netreg, NULL);
+ 		break;
 	case OFONO_VENDOR_PHONESIM:
 		g_at_chat_register(nd->chat, "+CSQ:",
 					csq_notify, FALSE, netreg, NULL);
@@ -1534,7 +1537,6 @@ static void at_creg_set_cb(gboolean ok,
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
-	case OFONO_VENDOR_SIMCOM:
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	default:


--===============5517366584862354131==--

