Content-Type: multipart/mixed; boundary="===============1331764047063477940=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 7/8] call-forwarding: Clear the conditional cache flag
Date: Mon, 06 Feb 2012 14:34:00 +0200
Message-ID: <1328531641-10612-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328531641-10612-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1331764047063477940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If there is an successful attempt to deactivate conditional cf
while cfu is active, the conditional cache flag is cleared.
---
 src/call-forwarding.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 2813005..a38a743 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -722,6 +722,14 @@ static void set_query_cf_callback(const struct ofono_e=
rror *error, int total,
 	DBG("%s conditions:", cf_type_lut[cf->query_next]);
 	cf_cond_list_print(l);
 =

+	/*
+	 * If there is an successful attempt to deactivate conditional cf
+	 * while cfu is active, the conditional cache flag is cleared.
+	 */
+	if (cf->query_next !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf))
+		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
+
 	if (cf->query_next !=3D cf->query_end) {
 		cf->query_next++;
 		set_query_next_cf_cond(cf);
-- =

1.7.5.4


--===============1331764047063477940==--

