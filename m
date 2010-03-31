Content-Type: multipart/mixed; boundary="===============6153532641291163016=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/11] Handle the comprehension tlv with bad format in
 parse_dataobj()
Date: Wed, 31 Mar 2010 17:17:03 +0800
Message-ID: <1270027023-21468-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-10-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6153532641291163016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b830291..937ef1a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -910,7 +910,6 @@ static gboolean parse_dataobj(struct comprehension_tlv_=
iter *iter,
 	entries =3D g_slist_reverse(entries);
 =

 	for (l =3D entries; l; l =3D l->next) {
-		gboolean ret;
 		dataobj_handler handler;
 		struct dataobj_handler_entry *entry =3D l->data;
 =

@@ -918,15 +917,12 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 		if (handler =3D=3D NULL)
 			continue;
 =

-		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type)
-			ret =3D handler(iter, entry->data);
-		else
-			ret =3D FALSE;
-
-		entry->parsed =3D ret;
-
-		if (ret && comprehension_tlv_iter_next(iter) =3D=3D FALSE)
-			break;
+		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
+			if (handler(iter, entry->data))
+				entry->parsed =3D TRUE;
+			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
+				break;
+		}
 	}
 =

 	for (l =3D entries; l; l =3D l->next) {
-- =

1.6.3.3


--===============6153532641291163016==--

