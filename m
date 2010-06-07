Content-Type: multipart/mixed; boundary="===============3829940392542828536=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/20] stk: Use envelope encoding utility from stkutil.c
Date: Mon, 07 Jun 2010 12:08:27 +0200
Message-ID: <1275905322-14768-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3829940392542828536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c   |    2 +-
 src/ofono.h |    4 ++--
 src/stk.c   |   27 ++++++++++++++-------------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index 56607a8..27185ba 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -197,7 +197,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 =

 	if (cbs_topic_in_range(c.message_identifier, cbs->efcbmid_contents)) {
 		if (cbs->stk)
-			__ofono_cbs_sim_download(cbs->stk, pdu, pdu_len);
+			__ofono_cbs_sim_download(cbs->stk, &c);
 		return;
 	}
 =

diff --git a/src/ofono.h b/src/ofono.h
index a1e4911..e2271e6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -177,8 +177,8 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 =

-void __ofono_cbs_sim_download(struct ofono_stk *stk,
-				const guint8 *pdu, int pdu_len);
+struct cbs;
+void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg=
);
 =

 #include <ofono/ssn.h>
 =

diff --git a/src/stk.c b/src/stk.c
index 8573d2c..14d1a0c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -49,32 +49,33 @@ static void stk_cbs_download_cb(const struct ofono_erro=
r *error,
 {
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("CellBroadcast download to UICC failed");
+		/* "The ME may retry to deliver the same Cell Broadcast
+		 * page." */
 		return;
 	}
 =

 	DBG("CellBroadcast download to UICC reported no error");
 }
 =

-void __ofono_cbs_sim_download(struct ofono_stk *stk,
-				const guint8 *pdu, int pdu_len)
+void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg)
 {
-	guint8 tlv[pdu_len + 8];
+	const guint8 *tlv;
+	unsigned int tlv_len;
+	struct stk_envelope e;
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
+	memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
 =

-	memcpy(tlv + 8, pdu, pdu_len);
+	tlv =3D stk_pdu_from_envelope(&e, &tlv_len);
+	if (!tlv)
+		return;
 =

-	stk->driver->envelope(stk, pdu_len + 8, tlv, stk_cbs_download_cb, stk);
+	stk->driver->envelope(stk, tlv_len, tlv, stk_cbs_download_cb, stk);
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
-- =

1.7.1.86.g0e460.dirty


--===============3829940392542828536==--

