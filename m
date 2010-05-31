Content-Type: multipart/mixed; boundary="===============7233803371575051271=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/11] stk: Use envelope encoding utility from stkutil.c
Date: Mon, 31 May 2010 14:47:17 +0200
Message-ID: <1275310044-27469-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7233803371575051271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8573d2c..143d9f3 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -49,6 +49,8 @@ static void stk_cbs_download_cb(const struct ofono_error =
*error,
 {
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("CellBroadcast download to UICC failed");
+		/* "The ME may retry to deliver the same Cell Broadcast
+		 * page." */
 		return;
 	}
 =

@@ -58,23 +60,27 @@ static void stk_cbs_download_cb(const struct ofono_erro=
r *error,
 void __ofono_cbs_sim_download(struct ofono_stk *stk,
 				const guint8 *pdu, int pdu_len)
 {
-	guint8 tlv[pdu_len + 8];
+	guint8 buf[512], *tlv;
+	struct stk_envelope e;
+	unsigned int tlv_len;
+
+	if (pdu_len !=3D 88) {
+		ofono_error("Bad CellBroadcast page length");
+		return;
+	}
 =

 	if (stk->driver->envelope =3D=3D NULL)
 		return;
 =

-	tlv[0] =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
-	tlv[1] =3D 6 + pdu_len;
-	tlv[2] =3D 0x80 | STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
-	tlv[3] =3D 0x02; /* Device Identities length */
-	tlv[4] =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
-	tlv[5] =3D STK_DEVICE_IDENTITY_TYPE_UICC;
-	tlv[6] =3D 0x80 | STK_DATA_OBJECT_TYPE_CBS_PAGE;
-	tlv[7] =3D pdu_len;
+	e.type =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
+	e.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	memcpy(e.cbs_pp_download.page, pdu, pdu_len);
 =

-	memcpy(tlv + 8, pdu, pdu_len);
+	if (stk_pdu_from_envelope(&e, buf, sizeof(buf), &tlv, &tlv_len) !=3D TRUE)
+		return;
 =

-	stk->driver->envelope(stk, pdu_len + 8, tlv, stk_cbs_download_cb, stk);
+	stk->driver->envelope(stk, tlv_len, tlv, stk_cbs_download_cb, stk);
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
-- =

1.7.1.86.g0e460.dirty


--===============7233803371575051271==--

