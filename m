Content-Type: multipart/mixed; boundary="===============8405913862022463515=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simutil: fix bug when parsing AID type
Date: Thu, 03 May 2018 15:30:29 -0700
Message-ID: <20180503223029.7531-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8405913862022463515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/simutil.c b/src/simutil.c
index 7a23c977..9287df17 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1576,7 +1576,7 @@ GSList *sim_parse_app_template_entries(const unsigned=
 char *buffer, int len)
 =

 		memcpy(app.aid, aid, app.aid_len);
 =

-		app.type =3D (app.aid[5] << 8) & app.aid[6];
+		app.type =3D (app.aid[5] << 8) | app.aid[6];
 =

 		/* Find the label (optional) */
 		label =3D ber_tlv_find_by_tag(dataobj, 0x50, dataobj_len,
-- =

2.17.0


--===============8405913862022463515==--

