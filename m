Content-Type: multipart/mixed; boundary="===============5379854108049305043=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] stk: Use sim bcd version
Date: Thu, 27 May 2010 17:24:33 +0800
Message-ID: <1274952274-17712-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5379854108049305043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 016bde9..e39a77f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -276,7 +276,7 @@ static gboolean parse_dataobj_address(struct comprehens=
ion_tlv_iter *iter,
 =

 	addr->ton_npi =3D data[0];
 	addr->number =3D number;
-	extract_bcd_number(data + 1, len - 1, addr->number);
+	sim_extract_bcd_number(data + 1, len - 1, addr->number);
 =

 	return TRUE;
 }
@@ -1012,7 +1012,7 @@ static gboolean parse_dataobj_dtmf_string(struct comp=
rehension_tlv_iter *iter,
 	if (*dtmf =3D=3D NULL)
 		return FALSE;
 =

-	extract_bcd_number(data, len, *dtmf);
+	sim_extract_bcd_number(data, len, *dtmf);
 =

 	return TRUE;
 }
-- =

1.7.0.4


--===============5379854108049305043==--

