Content-Type: multipart/mixed; boundary="===============6978319666260806034=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 06/13] call-forwarding: Refactor cf_find_unconditional()
Date: Tue, 10 Apr 2012 15:17:27 +0300
Message-ID: <1334060254-29547-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6978319666260806034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 424b111..49398c9 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -193,26 +193,12 @@ static void sim_cphs_cff_update_cb(int ok, void *data)
 		ofono_info("Failed to update EFcphs-cff");
 }
 =

-static struct ofono_call_forwarding_condition *cf_find_unconditional(
+static inline struct ofono_call_forwarding_condition *cf_find_unconditiona=
l(
 					struct ofono_call_forwarding *cf)
 {
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
+	return cf_cond_find(
+		cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],
+		BEARER_CLASS_VOICE);
 }
 =

 static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
-- =

1.7.5.4


--===============6978319666260806034==--

