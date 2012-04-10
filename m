Content-Type: multipart/mixed; boundary="===============6248941565305604161=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 11/13] call-forwarding: Re-run ss path queries on CFU unset
Date: Tue, 10 Apr 2012 15:17:32 +0300
Message-ID: <1334060254-29547-12-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6248941565305604161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index aa1ece7..204ecc7 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1004,6 +1004,16 @@ static void ss_set_query_cf_callback(const struct of=
ono_error *error, int total,
 =

 	set_new_cond_list(cf, cf->query_next, l);
 =

+	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			cf->query_next =3D=3D cf->query_end) {
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
+		/*
+		 * CFU has been disabled, conditionals need to be updated
+		 */
+		if (is_cfu_enabled(cf) =3D=3D FALSE)
+			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
+	}
+
 	if (cf->query_next !=3D cf->query_end) {
 		cf->query_next++;
 		ss_set_query_next_cf_cond(cf);
-- =

1.7.5.4


--===============6248941565305604161==--

