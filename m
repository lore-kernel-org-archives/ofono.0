Content-Type: multipart/mixed; boundary="===============0327232300475257980=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/5] atmodem/netreg: change vendor cinterion to gemalto
Date: Fri, 26 Oct 2018 07:11:03 +0200
Message-ID: <20181026051106.16828-2-gciofono@gmail.com>
In-Reply-To: <20181026051106.16828-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0327232300475257980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 55960c03..e493984e 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1559,7 +1559,7 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 					option_query_tech_cb, tq, g_free) > 0)
 			return;
 		break;
-    case OFONO_VENDOR_CINTERION:
+    case OFONO_VENDOR_GEMALTO:
               if (g_at_chat_send(nd->chat, "AT^SMONI",
                                       smoni_prefix,
                                       cinterion_query_tech_cb, tq, g_free)=
 > 0)
@@ -2031,7 +2031,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT*TLTS=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
-	case OFONO_VENDOR_CINTERION:
+	case OFONO_VENDOR_GEMALTO:
 		/*
 		 * We can't set rssi bounds from Cinterion responses
 		 * so set them up to specified values here
-- =

2.17.1


--===============0327232300475257980==--

