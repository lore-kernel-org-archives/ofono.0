Content-Type: multipart/mixed; boundary="===============0771163471805350070=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 1/2] stkutil: Allocate for empty string in text dataobj
Date: Wed, 29 Dec 2010 15:16:39 +0200
Message-ID: <1293628600-8684-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1293628600-8684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0771163471805350070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d7493f1..a463a99 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -565,7 +565,7 @@ static gboolean parse_dataobj_text(struct comprehension=
_tlv_iter *iter,
 	const unsigned char *data;
 	char *utf8;
 =

-	if (len =3D=3D 0) {
+	if (len =3D=3D 0 || len =3D=3D 1) {
 		*text =3D g_try_malloc0(1);
 		return TRUE;
 	}
-- =

1.7.0.4


--===============0771163471805350070==--

