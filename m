Content-Type: multipart/mixed; boundary="===============2115940414438566788=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/16] gprs: Make gprs_proto_to/from_string non-static
Date: Wed, 11 Aug 2010 10:26:31 +0800
Message-ID: <1281493601-14351-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2115940414438566788==
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
index 8002cf4..677ce81 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -142,7 +142,7 @@ static enum gprs_context_type gprs_context_string_to_ty=
pe(const char *str)
 	return GPRS_CONTEXT_TYPE_INVALID;
 }
 =

-static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
 {
 	switch (proto) {
 	case OFONO_GPRS_PROTO_IP:
@@ -154,8 +154,7 @@ static const char *gprs_proto_to_string(enum ofono_gprs=
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


--===============2115940414438566788==--

