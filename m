Content-Type: multipart/mixed; boundary="===============1376786435518631323=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] stkutil: fix issue with null data object
Date: Mon, 07 Mar 2011 07:35:50 -0800
Message-ID: <1299512150-19314-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1299512150-19314-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1376786435518631323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index abd1c99..66b2924 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -308,7 +308,7 @@ static gboolean parse_dataobj_alpha_id(struct comprehen=
sion_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len =3D=3D 0) {
+	if (len <=3D 1) {
 		*alpha_id =3D g_try_malloc0(1);
 		return TRUE;
 	}
-- =

1.7.0.4


--===============1376786435518631323==--

