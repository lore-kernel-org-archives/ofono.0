Content-Type: multipart/mixed; boundary="===============1644372291458669806=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 13/18] isimodem: SS_GSM_BARRING_INFO added
Date: Tue, 15 Feb 2011 13:31:07 +0100
Message-ID: <5ab76fe688af9f0041ba98139ee25a718552218c.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644372291458669806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

SS_GSM_BSC_INFO added.
---
 drivers/isimodem/call-barring.c |   99 ++++++++++++++++++++++++++++++++++-=
---
 1 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index a78b762..a1d9a13 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -190,6 +190,40 @@ static void update_status_mask(unsigned int *mask, int=
 bsc)
 	}
 }
 =

+static gboolean decode_gsm_barring_info(const void *restrict data, size_t =
len,
+					guint32 *mask)
+{
+	GIsiSubBlockIter iter;
+
+	for (g_isi_sb_iter_init(&iter, data, 0);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_GSM_BARRING_FEATURE: {
+			uint8_t status;
+			uint8_t bsc;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &bsc, 2) ||
+					!g_isi_sb_iter_get_byte(&iter, &status,
+							3))
+				return FALSE;
+
+			if (status & SS_GSM_ACTIVE)
+				update_status_mask(mask, bsc);
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	return TRUE;
+}
+
 static void query_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
@@ -197,9 +231,6 @@ static void query_resp_cb(const GIsiMessage *msg, void =
*data)
 	GIsiSubBlockIter iter;
 	uint32_t mask =3D 0;
 	uint8_t type;
-	uint8_t count =3D 0;
-	uint8_t bsc =3D 0;
-	uint8_t i;
 =

 	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
 		goto error;
@@ -214,18 +245,65 @@ static void query_resp_cb(const GIsiMessage *msg, voi=
d *data)
 			g_isi_sb_iter_is_valid(&iter);
 			g_isi_sb_iter_next(&iter)) {
 =

-		if (g_isi_sb_iter_get_id(&iter) !=3D SS_GSM_BSC_INFO)
-			continue;
+		switch (g_isi_sb_iter_get_id(&iter)) {
 =

-		if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
-			goto error;
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
 =

-		for (i =3D 0; i < count; i++) {
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
 =

-			if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+			if (ss_status & SS_GSM_ACTIVE)
+				mask =3D 1;
+
+			break;
+		}
+
+		case SS_GSM_BARRING_INFO: {
+			void *info =3D NULL;
+			size_t infolen;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			infolen =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+			if (!decode_gsm_barring_info(info, infolen, &mask))
+				goto error;
+
+			break;
+		}
+
+		case SS_GSM_BSC_INFO: {
+
+			guint8 count =3D 0;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
 				goto error;
 =

-			update_status_mask(&mask, bsc);
+			for (i =3D 0; i < count; i++) {
+
+				guint8 bsc =3D 0;
+
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+			break;
+		}
+
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
 		}
 	}
 =

@@ -342,7 +420,6 @@ static void reachable_cb(const GIsiMessage *msg, void *=
data)
 	ofono_call_barring_register(barr);
 }
 =

-
 static int isi_call_barring_probe(struct ofono_call_barring *barr,
 					unsigned int vendor, void *user)
 {
-- =

1.7.3.5


--===============1644372291458669806==--

