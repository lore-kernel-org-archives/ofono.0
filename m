Content-Type: multipart/mixed; boundary="===============2193580327269606658=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 04/12] call-forwarding: Refactor cf_find_unconditional()
Date: Tue, 13 Mar 2012 15:46:25 +0200
Message-ID: <1331646393-5249-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2193580327269606658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-use cf_find() instead.
---
 src/call-forwarding.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5a2ab28..b1a1a72 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -44,6 +44,12 @@
 =

 #define CFC(_x) ((struct ofono_call_forwarding_condition *)(_x))
 =

+#define cf_find_unconditional(_cf)					\
+({									\
+	cf_find((_cf)->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],\
+		BEARER_CLASS_VOICE);					\
+})
+
 #define is_cfu_enabled(_cf)				\
 ({							\
 	cf_find_unconditional(_cf) ? TRUE : FALSE;	\
@@ -188,28 +194,6 @@ static void sim_cphs_cff_update_cb(int ok, void *data)
 		ofono_info("Failed to update EFcphs-cff");
 }
 =

-static struct ofono_call_forwarding_condition *cf_find_unconditional(
-					struct ofono_call_forwarding *cf)
-{
-	GSList *l =3D cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL];
-	struct ofono_call_forwarding_condition *cond;
-
-	/*
-	 * For now we only support Voice, although Fax & all Data
-	 * basic services are applicable as well.
-	 */
-	for (; l; l =3D l->next) {
-		cond =3D l->data;
-
-		if (cond->cls > BEARER_CLASS_VOICE)
-			continue;
-
-		return cond;
-	}
-
-	return NULL;
-}
-
 static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
 {
 	struct ofono_call_forwarding_condition *cfu_voice =3D
-- =

1.7.5.4


--===============2193580327269606658==--

