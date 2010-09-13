Content-Type: multipart/mixed; boundary="===============1817696944907450881=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 8/8] stkutil: Add handling of error case scenario in build
 USSD data object
Date: Mon, 13 Sep 2010 16:00:17 -0700
Message-ID: <1284418817-28575-9-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-8-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1817696944907450881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3cfe06a..95d2f9b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4177,6 +4177,9 @@ static gboolean build_dataobj_ussd_text(struct stk_tl=
v_builder *tlv,
 	const struct stk_ussd_text *text =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TEXT;
 =

+	if (text->dcs =3D=3D -1)
+		return TRUE;
+
 	stk_tlv_builder_open_container(tlv, cr, tag, TRUE);
 =

 	if (text->len > 0) {
-- =

1.7.0.4


--===============1817696944907450881==--

