Content-Type: multipart/mixed; boundary="===============7411713457164400327=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: disabling reporting of intermediate results for
 CGDATA
Date: Thu, 20 Jun 2019 17:37:23 +0530
Message-ID: <1561032443-22383-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7411713457164400327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting <connect_flag> in AT+XDATACHANNEL set command to 0. This will
disable intermediate result reporting of "CONNECT" and "NO CARRIER"
on control channel.

This resolves the issue of getting failure response for offline-modem
since "NO CARRIER" is received as result of AT+CFUN operation instead
of "OK".
---
 drivers/ifxmodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 2de6b4f..7bacb73 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -406,7 +406,7 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	interface =3D ofono_gprs_context_get_interface(gc);
 	datapath =3D get_datapath(modem, interface);
 =

-	snprintf(buf, sizeof(buf), "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u",
+	snprintf(buf, sizeof(buf), "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",0,%u",
 			ctrlpath, datapath, gcd->active_context);
 	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
 	snprintf(buf, sizeof(buf), "AT+CGDATA=3D\"M-RAW_IP\",%u",
-- =

1.9.1


--===============7411713457164400327==--

