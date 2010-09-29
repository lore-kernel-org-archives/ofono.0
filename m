Content-Type: multipart/mixed; boundary="===============3351078943514601721=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/21] gprs: Make gprs_proto_to/from_string non-static
Date: Wed, 29 Sep 2010 17:44:51 +0800
Message-ID: <1285753501-7668-12-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3351078943514601721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So DUN server could share gprs_proto_to_string and
gprs_proto_from_string.
---
 include/gprs-context.h |    3 +++
 src/gprs.c             |    5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index f4c7321..de170b8 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -84,6 +84,9 @@ void *ofono_gprs_context_get_data(struct ofono_gprs_conte=
xt *gc);
 =

 struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc);
 =

+gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto);
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index 8d7fefc..f3f86ec 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -145,7 +145,7 @@ static enum gprs_context_type gprs_context_string_to_ty=
pe(const char *str)
 	return GPRS_CONTEXT_TYPE_INVALID;
 }
 =

-static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
 {
 	switch (proto) {
 	case OFONO_GPRS_PROTO_IP:
@@ -157,8 +157,7 @@ static const char *gprs_proto_to_string(enum ofono_gprs=
_proto proto)
 	return NULL;
 }
 =

-static gboolean gprs_proto_from_string(const char *str,
-					enum ofono_gprs_proto *proto)
+gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto)
 {
 	if (g_str_equal(str, "ip")) {
 		*proto =3D OFONO_GPRS_PROTO_IP;
-- =

1.7.0.4


--===============3351078943514601721==--

