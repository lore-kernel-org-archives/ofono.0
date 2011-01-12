Content-Type: multipart/mixed; boundary="===============6055244965864296415=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 11/21] gprs: Make gprs_proto_to/from_string non-static
Date: Wed, 12 Jan 2011 18:15:54 +0100
Message-ID: <1294852564-1258-12-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6055244965864296415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

So DUN server could share gprs_proto_to_string and
gprs_proto_from_string.
---
 include/gprs-context.h |    4 ++++
 src/gprs.c             |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..19c1b98 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -95,6 +95,10 @@ struct ofono_modem *ofono_gprs_context_get_modem(struct =
ofono_gprs_context *gc);
 void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
 					enum ofono_gprs_context_type type);
 =

+gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto);
+
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index c7793ea..9e8fae3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -184,7 +184,7 @@ static gboolean gprs_context_string_to_type(const char =
*str,
 	return FALSE;
 }
 =

-static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
 {
 	switch (proto) {
 	case OFONO_GPRS_PROTO_IP:
@@ -196,7 +196,7 @@ static const char *gprs_proto_to_string(enum ofono_gprs=
_proto proto)
 	return NULL;
 }
 =

-static gboolean gprs_proto_from_string(const char *str,
+gboolean gprs_proto_from_string(const char *str,
 					enum ofono_gprs_proto *proto)
 {
 	if (g_str_equal(str, "ip")) {
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6055244965864296415==--

