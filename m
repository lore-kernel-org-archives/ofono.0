Content-Type: multipart/mixed; boundary="===============7045753198601976339=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 08/12] call-forwarding: Toggle the cached flag on CFU changes
Date: Tue, 13 Mar 2012 15:46:29 +0200
Message-ID: <1331646393-5249-9-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7045753198601976339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set the flag on CFU activation, unset on deactivation.
---
 src/call-forwarding.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index edd1891..575d96d 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -646,6 +646,14 @@ static void set_query_cf_callback(const struct ofono_e=
rror *error, int total,
 	DBG("%s conditions:", cf_type_lut[cf->query_next]);
 	cf_cond_list_print(cf->cf_conditions[cf->query_next]);
 =

+	/*
+	 * Toggle the cached flag on CFU changes
+	 */
+	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			((cf->flags & CALL_FORWARDING_FLAG_CACHED) !=3D
+				is_cfu_enabled(cf)))
+		cf->flags ^=3D CALL_FORWARDING_FLAG_CACHED;
+
 	if (cf->query_next =3D=3D cf->query_end) {
 		__ofono_dbus_pending_reply(&cf->pending,
 				dbus_message_new_method_return(cf->pending));
-- =

1.7.5.4


--===============7045753198601976339==--

