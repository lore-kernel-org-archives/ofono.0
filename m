Content-Type: multipart/mixed; boundary="===============3329649806700202017=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 04/19] test-stkutil: Use enum for icon_id
Date: Mon, 10 May 2010 18:38:47 +0800
Message-ID: <1273487942-27213-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3329649806700202017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 6d57109..e1f6a3e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -270,7 +270,7 @@ static struct display_text_test display_text_data_511 =
=3D {
 	.qualifier =3D 0x80,
 	.text =3D "Basic Icon",
 	.icon_id =3D {
-		.qualifier =3D 0x00,
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
 		.id =3D 0x01
 	}
 };
@@ -281,7 +281,7 @@ static struct display_text_test display_text_data_521 =
=3D {
 	.qualifier =3D 0x80,
 	.text =3D "Colour Icon",
 	.icon_id =3D {
-		.qualifier =3D 0x00,
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
 		.id =3D 0x02
 	}
 };
@@ -292,7 +292,7 @@ static struct display_text_test display_text_data_531 =
=3D {
 	.qualifier =3D 0x80,
 	.text =3D "Basic Icon",
 	.icon_id =3D {
-		.qualifier =3D 0x01,
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
 		.id =3D 0x01
 	}
 };
-- =

1.7.0.4


--===============3329649806700202017==--

