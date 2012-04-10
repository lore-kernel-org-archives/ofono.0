Content-Type: multipart/mixed; boundary="===============7074194368013976258=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 01/13] call-forwarding: Refactor cf_condition_compare()
Date: Tue, 10 Apr 2012 15:17:22 +0300
Message-ID: <1334060254-29547-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7074194368013976258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 8b6659a..2b91250 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -86,18 +86,12 @@ static void get_query_next_cf_cond(struct ofono_call_fo=
rwarding *cf);
 static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
 =

-static gint cf_condition_compare(gconstpointer a, gconstpointer b)
+static gint cf_cond_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call_forwarding_condition *ca =3D a;
 	const struct ofono_call_forwarding_condition *cb =3D b;
 =

-	if (ca->cls < cb->cls)
-		return -1;
-
-	if (ca->cls > cb->cls)
-		return 1;
-
-	return 0;
+	return ca->cls - cb->cls;
 }
 =

 static gint cf_condition_find_with_cls(gconstpointer a, gconstpointer b)
@@ -175,8 +169,7 @@ static GSList *cf_cond_list_create(int total,
 				sizeof(struct ofono_call_forwarding_condition));
 			cond->cls =3D j;
 =

-			l =3D g_slist_insert_sorted(l, cond,
-							cf_condition_compare);
+			l =3D g_slist_insert_sorted(l, cond, cf_cond_compare);
 		}
 	}
 =

-- =

1.7.5.4


--===============7074194368013976258==--

