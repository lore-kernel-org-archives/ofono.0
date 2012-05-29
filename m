Content-Type: multipart/mixed; boundary="===============6208314879337315520=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH] drivers: add support for Wavecom Q2403/Q2686 modems
Date: Tue, 29 May 2012 04:14:26 +0200
Message-ID: <1338257667-24281-2-git-send-email-pablo@gnumonks.org>
In-Reply-To: <1338257667-24281-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6208314879337315520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@gnumonks.org>

This patch adds a couple of quirks to support Q2403/Q2686.

The existing wavecom driver in tree slightly differs from these
modems. Thus, it doesn't work work with them. We (the osmocom
team) use these Wavecom Q2403/Q2686 modems in our testbed.
---
 drivers/atmodem/sim.c    |    3 ++-
 drivers/atmodem/sms.c    |   27 ++++++++++++++++++++++-----
 drivers/atmodem/vendor.h |    1 +
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 971b0ea..79db63d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -926,7 +926,8 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM) {
+	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM ||
+	    sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX) {
 		/* +CPIN: <pin> */
 		pin_required =3D final + 7;
 	} else {
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index f2dc257..62933f8 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -985,8 +985,11 @@ static gboolean set_cpms(gpointer user_data)
 	const char *incoming =3D storages[data->incoming];
 	char buf[128];
 =

-	snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
-			store, store, incoming);
+	if (data->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)
+		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\"", store);
+	else
+		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
+				store, store, incoming);
 =

 	g_at_chat_send(data->chat, buf, cpms_prefix,
 			at_cpms_set_cb, sms, NULL);
@@ -1038,7 +1041,7 @@ static void at_cpms_query_cb(gboolean ok, GAtResult *=
result,
 	gboolean supported =3D FALSE;
 =

 	if (ok) {
-		int mem =3D 0;
+		int mem =3D 0, mem_max;
 		GAtResultIter iter;
 		const char *store;
 		gboolean me_supported[3];
@@ -1054,7 +1057,20 @@ static void at_cpms_query_cb(gboolean ok, GAtResult =
*result,
 		if (!g_at_result_iter_next(&iter, "+CPMS:"))
 			goto out;
 =

-		for (mem =3D 0; mem < 3; mem++) {
+		if (data->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX) {
+			/* skip initial `(' */
+			if (!g_at_result_iter_open_list(&iter))
+				goto out;
+
+			/*
+			 * Wavecom Q2 replies: +CPMS: (("SM","BM","SR"),("SM"))
+			 * This reply is broken according to 3GPP TS 07.05.
+			 */
+			mem_max =3D 2;
+		} else
+			mem_max =3D 3;
+
+		for (mem =3D 0; mem < mem_max; mem++) {
 			if (!g_at_result_iter_open_list(&iter))
 				goto out;
 =

@@ -1071,7 +1087,8 @@ static void at_cpms_query_cb(gboolean ok, GAtResult *=
result,
 				goto out;
 		}
 =

-		if (!sm_supported[2] && !me_supported[2] && !mt_supported[2])
+		if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q2XXX &&
+		    !sm_supported[2] && !me_supported[2] && !mt_supported[2])
 			goto out;
 =

 		if (sm_supported[0] && sm_supported[1]) {
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 25c09f6..80aed3e 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -40,4 +40,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_SAMSUNG,
 	OFONO_VENDOR_SIMCOM,
 	OFONO_VENDOR_ICERA,
+	OFONO_VENDOR_WAVECOM_Q2XXX,
 };
-- =

1.7.10


--===============6208314879337315520==--

