Content-Type: multipart/mixed; boundary="===============8203047104396222308=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 01/12] call-forwarding: Remove cf_list_clear()
Date: Tue, 13 Mar 2012 15:46:22 +0200
Message-ID: <1331646393-5249-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8203047104396222308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use g_slist_free_full() instead.
---
 src/call-forwarding.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 864be1b..0857362 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -183,22 +183,12 @@ static GSList *cf_cond_list_create(int total,
 	return l;
 }
 =

-static inline void cf_list_clear(GSList *cf_list)
-{
-	GSList *l;
-
-	for (l =3D cf_list; l; l =3D l->next)
-		g_free(l->data);
-
-	g_slist_free(cf_list);
-}
-
 static inline void cf_clear_all(struct ofono_call_forwarding *cf)
 {
 	int i;
 =

 	for (i =3D 0; i < 4; i++) {
-		cf_list_clear(cf->cf_conditions[i]);
+		g_slist_free_full(cf->cf_conditions[i], g_free);
 		cf->cf_conditions[i] =3D NULL;
 	}
 }
@@ -422,7 +412,7 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 						&timeout);
 	}
 =

-	cf_list_clear(old);
+	g_slist_free_full(old, g_free);
 	cf->cf_conditions[type] =3D list;
 =

 	if (update_sim =3D=3D TRUE)
-- =

1.7.5.4


--===============8203047104396222308==--

