Content-Type: multipart/mixed; boundary="===============1461855614579138254=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Use stkutil named constants in sim.c
Date: Wed, 31 Mar 2010 06:56:57 +0200
Message-ID: <1270011417-6715-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1461855614579138254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 0ab399d..1ab8a8b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1859,11 +1859,11 @@ void __ofono_cbs_sim_download(struct ofono_sim *sim,
 =

 	tlv[0] =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
 	tlv[1] =3D 6 + pdu_len;
-	tlv[2] =3D 0x82; /* Device Identities */
+	tlv[2] =3D 0x80 | STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
 	tlv[3] =3D 0x02; /* Device Identities length */
-	tlv[4] =3D 0x83; /* Network */
-	tlv[5] =3D 0x81; /* UICC */
-	tlv[6] =3D 0x8c; /* Cell Broadcast page */
+	tlv[4] =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
+	tlv[5] =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	tlv[6] =3D 0x80 | STK_DATA_OBJECT_TYPE_CBS_PAGE;
 	tlv[7] =3D pdu_len;
 =

 	memcpy(tlv + 8, pdu, pdu_len);
-- =

1.6.1


--===============1461855614579138254==--

