Content-Type: multipart/mixed; boundary="===============5771690765578935987=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH 1/2] atmodem: move USSD quirk to probe and use it also for STE
 modems
Date: Fri, 14 Jan 2011 16:12:33 +0200
Message-ID: <1295014353-9106-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5771690765578935987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixing issues in USSD quirk:
1) MT USSD are not handled correctly if modem uses IRA character set (chang=
e character set to GSM already in probe)
2) Responses from NW to MO USSD are not hadled as internal variable is not =
updated after cscs=3D command (Query right after setting)
3) Use the same quirk for STE modems

---
 drivers/atmodem/ussd.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 651b6af..411b1de 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -219,15 +219,6 @@ static void at_ussd_request(struct ofono_ussd *ussd, i=
nt dcs,
 				converted, dcs);
 	}
 =

-	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
-		/* Ensure that the modem is using GSM character set. It
-		 * seems it defaults to IRA and then umlauts are not
-		 * properly encoded. The modem returns some weird from
-		 * of Latin-1, but it is not really Latin-1 either. */
-		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
-							NULL, NULL, NULL);
-	}
-
 	if (g_at_chat_send(data->chat, buf, cusd_prefix,
 				cusd_request_cb, cbd, g_free) > 0)
 		return;
@@ -314,6 +305,18 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsi=
gned int vendor,
 =

 	ofono_ussd_set_data(ussd, data);
 =

+	switch (data->vendor) {
+	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_STE:
+		/*
+		* Ensure that the modem is using GSM character set. It
+		* seems it defaults to IRA and then umlauts are not
+		* properly encoded. The modem returns some weird from
+		* of Latin-1, but it is not really Latin-1 either.
+		*/
+		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
+							NULL, NULL, NULL);
+		break;
+	}
+
 	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
 			NULL);
 =

-- =

1.7.0.4


--===============5771690765578935987==--

