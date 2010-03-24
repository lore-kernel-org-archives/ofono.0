Content-Type: multipart/mixed; boundary="===============7849357112581723467=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/6] Add macro name of comprehension tlv cdma sms tpdu
Date: Wed, 24 Mar 2010 17:35:45 +0800
Message-ID: <1269423347-15508-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269423347-15508-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7849357112581723467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 5724d29..d2cbee0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -151,6 +151,7 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_SERVICE_AVAILABILITY =3D		0x45,
 	STK_DATA_OBJECT_TYPE_ESN =3D				0x46,
 	STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME =3D		0x47,
+	STK_DATA_OBJECT_TYPE_CDMA_SMS_TPDU =3D 			0x48,
 	STK_DATA_OBJECT_TYPE_REMOTE_ENTITY_ADDRESS =3D		0x49,
 	STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE =3D			0x50,
 	STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST =3D		0x51,
-- =

1.6.3.3


--===============7849357112581723467==--

