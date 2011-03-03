Content-Type: multipart/mixed; boundary="===============7990120161946129516=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/3] atmodem: add SSN handling
Date: Thu, 03 Mar 2011 18:48:25 +0200
Message-ID: <5eedcd6a86f2d40004964358e6db24aec77644a1.1299168583.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1299168583.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7990120161946129516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |   61 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index ee055da..7d70c85 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -967,6 +967,63 @@ static void busy_notify(GAtResult *result, gpointer us=
er_data)
 			clcc_poll_cb, vc, NULL);
 }
 =

+static void cssi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	GAtResultIter iter;
+	int code, index;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &code))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		index =3D 0;
+
+	ofono_voicecall_ssn_mo_notify(vc, 0, code, index);
+}
+
+static void cssu_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	GAtResultIter iter;
+	int code;
+	int index =3D -1;
+	const char *num;
+	struct ofono_phone_number ph;
+
+	ph.number[0] =3D '\0';
+	ph.type =3D 129;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSSU:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &code))
+		return;
+
+	/* This field is optional, if we can't read it, try to skip it */
+	if (!g_at_result_iter_next_number(&iter, &index) &&
+			!g_at_result_iter_skip_next(&iter))
+		goto out;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		goto out;
+
+	strncpy(ph.number, num, OFONO_MAX_PHONE_NUMBER_LENGTH);
+
+	if (!g_at_result_iter_next_number(&iter, &ph.type))
+		return;
+
+out:
+	ofono_voicecall_ssn_mt_notify(vc, 0, code, index, &ph);
+}
+
 static void vtd_query_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -1015,6 +1072,9 @@ static void at_voicecall_initialized(gboolean ok, GAt=
Result *result,
 =

 	/* Populate the call list */
 	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
+
+	g_at_chat_register(vd->chat, "+CSSI:", cssi_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CSSU:", cssu_notify, FALSE, vc, NULL);
 }
 =

 static int at_voicecall_probe(struct ofono_voicecall *vc, unsigned int ven=
dor,
@@ -1038,6 +1098,7 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 	g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+VTD?", NULL,
 				vtd_query_cb, vc, NULL);
 	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL,
-- =

1.7.0.4


--===============7990120161946129516==--

