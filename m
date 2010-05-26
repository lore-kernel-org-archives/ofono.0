Content-Type: multipart/mixed; boundary="===============5534363533571483610=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 1/8] stk: Make parse_dataobj not consume extra data
Date: Wed, 26 May 2010 22:39:07 +0800
Message-ID: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5534363533571483610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 016bde9..fd5b7c6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2023,6 +2023,7 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 	GSList *l;
 	va_list args;
 	gboolean minimum_set =3D TRUE;
+	struct comprehension_tlv_iter iter_old;
 =

 	va_start(args, type);
 =

@@ -2056,11 +2057,14 @@ static gboolean parse_dataobj(struct comprehension_=
tlv_iter *iter,
 			if (handler(iter, entry->data))
 				entry->parsed =3D TRUE;
 =

+			comprehension_tlv_iter_copy(iter, &iter_old);
+
 			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
 				break;
 		}
 	}
 =

+	comprehension_tlv_iter_copy(&iter_old, iter);
 out:
 	for (l =3D entries; l; l =3D l->next) {
 		struct dataobj_handler_entry *entry =3D l->data;
@@ -2293,6 +2297,9 @@ static GSList *parse_item_list(struct comprehension_t=
lv_iter *iter)
 	struct stk_item item;
 	GSList *list =3D NULL;
 =

+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		return NULL;
+
 	if (comprehension_tlv_iter_get_tag(iter) !=3D tag)
 		return NULL;
 =

-- =

1.7.0.4


--===============5534363533571483610==--

