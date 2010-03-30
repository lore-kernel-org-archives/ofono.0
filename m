Content-Type: multipart/mixed; boundary="===============5522942626349120062=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 08/10] Add enum for icon qualifier
Date: Tue, 30 Mar 2010 15:57:35 +0800
Message-ID: <1269935857-4234-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-7-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5522942626349120062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 1eae1cd..0820dda 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -296,6 +296,11 @@ enum stk_service_state {
 	STK_NO_SERVICE =3D 	0x02
 };
 =

+enum stk_icon_qualifier {
+	STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY =3D 	0x00,
+	STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY =3D	0x01
+};
+
 /* Defined in TS 102.223 Section 8.1 */
 struct stk_address {
 	unsigned char ton_npi;
-- =

1.6.3.3


--===============5522942626349120062==--

