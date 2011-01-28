Content-Type: multipart/mixed; boundary="===============6866818678265831576=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ss-notify FYI 2/6] ssn: add ssn code argument to ssn notify callbacks
Date: Fri, 28 Jan 2011 19:38:15 +0200
Message-ID: <1296236300-19189-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296236300-19189-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6866818678265831576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Including the ssn code as an argument in notify callbacks allows
handling of multiple notifications in single function.
---
 src/ofono.h |    4 ++--
 src/ssn.c   |    8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index df20103..e8c24a9 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -313,8 +313,8 @@ int __ofono_sms_sim_download(struct ofono_stk *stk, con=
st struct sms *msg,
 =

 #include <ofono/ssn.h>
 =

-typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
-typedef void (*ofono_ssn_mt_notify_cb)(int index,
+typedef void (*ofono_ssn_mo_notify_cb)(int index, int mo_code, void *user);
+typedef void (*ofono_ssn_mt_notify_cb)(int index, int mt_code,
 					const struct ofono_phone_number *ph,
 					void *user);
 =

diff --git a/src/ssn.c b/src/ssn.c
index 64c94b7..00da3a6 100644
--- a/src/ssn.c
+++ b/src/ssn.c
@@ -118,12 +118,14 @@ void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int=
 code1, int index)
 	GSList *l;
 	ofono_ssn_mo_notify_cb notify;
 =

+	DBG("ssn %p, code %u, index %u", (void *)ssn, code1, index);
+
 	for (l =3D ssn->mo_handler_list->items; l; l =3D l->next) {
 		h =3D l->data;
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code1)
-			notify(index, h->item.notify_data);
+			notify(index, code1, h->item.notify_data);
 	}
 }
 =

@@ -134,12 +136,14 @@ void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int=
 code2, int index,
 	GSList *l;
 	ofono_ssn_mt_notify_cb notify;
 =

+	DBG("ssn %p, code %u, index %u", (void *)ssn, code2, index);
+
 	for (l =3D ssn->mt_handler_list->items; l; l =3D l->next) {
 		h =3D l->data;
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code2)
-			notify(index, ph, h->item.notify_data);
+			notify(index, code2, ph, h->item.notify_data);
 	}
 }
 =

-- =

1.7.1


--===============6866818678265831576==--

