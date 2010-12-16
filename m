Content-Type: multipart/mixed; boundary="===============0416441403399868033=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/3] stkutil: fix issue in null text string
Date: Thu, 16 Dec 2010 13:20:16 -0800
Message-ID: <1292534418-13351-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292534418-13351-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0416441403399868033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d7493f1..8698f4f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -565,8 +565,8 @@ static gboolean parse_dataobj_text(struct comprehension=
_tlv_iter *iter,
 	const unsigned char *data;
 	char *utf8;
 =

-	if (len =3D=3D 0) {
-		*text =3D g_try_malloc0(1);
+	if (len =3D=3D 0 || len =3D=3D 1) {
+		*text =3D NULL;
 		return TRUE;
 	}
 =

-- =

1.7.0.4


--===============0416441403399868033==--

