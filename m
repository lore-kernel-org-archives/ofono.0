Content-Type: multipart/mixed; boundary="===============8023559155199352146=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 07/20] common: add preferred_ue_mode enum
Date: Mon, 11 Apr 2011 13:20:05 +0300
Message-ID: <1302517218-2147-8-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8023559155199352146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/common.h b/src/common.h
index 5fc3ead..cfc620c 100644
--- a/src/common.h
+++ b/src/common.h
@@ -41,6 +41,14 @@ enum network_registration_status {
 	NETWORK_REGISTRATION_STATUS_ROAMING =3D		5,
 };
 =

+/* 27.007 section 10.1.28 <mode> */
+enum preferred_ue_mode {
+	PREFERRED_UE_MODE_PS_DATA_CENTRIC =3D		0,
+	PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC =3D		1,
+	PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC =3D		2,
+	PREFERRED_UE_MODE_PS_VOICE_CENTRIC =3D		3,
+};
+
 /* 27.007 Section 7.6 */
 enum clip_validity {
 	CLIP_VALIDITY_VALID =3D		0,
-- =

1.7.0.4


--===============8023559155199352146==--

