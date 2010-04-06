Content-Type: multipart/mixed; boundary="===============7867725177533574448=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/13] Fix the logic when parsing c-apdu objects
Date: Tue, 06 Apr 2010 18:06:35 +0800
Message-ID: <1270548407-12042-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7867725177533574448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 13c2978..3fac701 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -852,7 +852,6 @@ static gboolean parse_dataobj_c_apdu(struct comprehensi=
on_tlv_iter *iter,
 	}
 	=

 	if (len - pos > 0) {
-		ca->lc =3D 0;
 		ca->le =3D data[len - 1];
 		ca->has_le =3D TRUE;
 	}
-- =

1.6.3.3


--===============7867725177533574448==--

