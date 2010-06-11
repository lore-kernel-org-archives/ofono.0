Content-Type: multipart/mixed; boundary="===============8624084904072600428=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/15] stkutil: Refactor struct stk_frames_info
Date: Fri, 11 Jun 2010 12:39:49 +0200
Message-ID: <1276252800-27515-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8624084904072600428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   11 +++++++++--
 src/stkutil.h |    4 +++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9012234..56c57b1 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1628,6 +1628,7 @@ static gboolean parse_dataobj_frames_info(struct comp=
rehension_tlv_iter *iter,
 	struct stk_frames_info *fi =3D user;
 	const unsigned char *data;
 	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+	unsigned int i;
 =

 	if (len < 1)
 		return FALSE;
@@ -1640,12 +1641,18 @@ static gboolean parse_dataobj_frames_info(struct co=
mprehension_tlv_iter *iter,
 	if ((len =3D=3D 1 && data[0] !=3D 0) || (len > 1 && data[0] =3D=3D 0))
 		return FALSE;
 =

+	if (len % 2 =3D=3D 0)
+		return FALSE;
+
 	if (len =3D=3D 1)
 		return TRUE;
 =

 	fi->id =3D data[0];
-	fi->len =3D len - 1;
-	memcpy(fi->list, data + 1, fi->len);
+	fi->len =3D (len - 1) / 2;
+	for (i =3D 0; i < len; i++) {
+		fi->list[i].height =3D data[i * 2 + 1] & 0x1f;
+		fi->list[i].width =3D data[i * 2 + 2] & 0x7f;
+	}
 =

 	return TRUE;
 }
diff --git a/src/stkutil.h b/src/stkutil.h
index d5b3c02..d349cca 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -813,7 +813,9 @@ struct stk_frame_layout {
  */
 struct stk_frames_info {
 	unsigned char id;
-	unsigned char list[126];
+	struct {
+		unsigned char width, height;
+	} list[63];
 	unsigned int len;
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============8624084904072600428==--

