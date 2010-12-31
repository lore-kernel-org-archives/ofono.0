Content-Type: multipart/mixed; boundary="===============8445575001215422323=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/3] stkutil: Allocate for empty string in text dataobj
Date: Fri, 31 Dec 2010 14:30:45 +0200
Message-ID: <1293798647-4256-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1293798647-4256-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8445575001215422323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ab33c7d..8aee8f7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -565,7 +565,7 @@ static gboolean parse_dataobj_text(struct comprehension=
_tlv_iter *iter,
 	const unsigned char *data;
 	char *utf8;
 =

-	if (len =3D=3D 0) {
+	if (len <=3D 1) {
 		*text =3D g_try_malloc0(1);
 		return TRUE;
 	}
-- =

1.7.0.4


--===============8445575001215422323==--

