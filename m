Content-Type: multipart/mixed; boundary="===============4400333532909443799=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 6/9] stkutil: remove test for impossible condition
Date: Fri, 26 Oct 2018 12:13:16 +0200
Message-ID: <20181026101319.27709-7-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4400333532909443799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonas Bonn <jonas@southpole.se>

'string' is an array and therefore never NULL so this test always fails.
---
 src/stkutil.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ec3f825d..9992f6c5 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4405,9 +4405,6 @@ static gboolean build_dataobj_ussd_string(struct stk_=
tlv_builder *tlv,
 	const struct stk_ussd_string *ussd =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_USSD_STRING;
 =

-	if (ussd->string =3D=3D NULL)
-		return TRUE;
-
 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
 		stk_tlv_builder_append_byte(tlv, ussd->dcs) &&
 		stk_tlv_builder_append_bytes(tlv, ussd->string, ussd->len) &&
-- =

2.17.1


--===============4400333532909443799==--

