Content-Type: multipart/mixed; boundary="===============8433127436059527838=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] gprs-context: add IMS connection type
Date: Wed, 27 Oct 2010 17:38:01 +0300
Message-ID: <1288190281-11881-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8433127436059527838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 include/gprs-context.h |    1 +
 src/gprs.c             |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 19abf33..f796e2d 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -44,6 +44,7 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
 	OFONO_GPRS_CONTEXT_TYPE_MMS,
 	OFONO_GPRS_CONTEXT_TYPE_WAP,
+	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

 struct ofono_gprs_primary_context {
diff --git a/src/gprs.c b/src/gprs.c
index 1c8ab50..222a52d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -128,6 +128,8 @@ static const char *gprs_context_type_to_default_name(en=
um ofono_gprs_context_typ
 		return "MMS";
 	case OFONO_GPRS_CONTEXT_TYPE_WAP:
 		return "WAP";
+	case OFONO_GPRS_CONTEXT_TYPE_IMS:
+		return "IMS";
 	}
 =

 	return NULL;
@@ -144,6 +146,8 @@ static const char *gprs_context_type_to_string(enum ofo=
no_gprs_context_type type
 		return "mms";
 	case OFONO_GPRS_CONTEXT_TYPE_WAP:
 		return "wap";
+	case OFONO_GPRS_CONTEXT_TYPE_IMS:
+		return "ims";
 	}
 =

 	return NULL;
@@ -157,6 +161,8 @@ static enum ofono_gprs_context_type gprs_context_string=
_to_type(const char *str)
 		return OFONO_GPRS_CONTEXT_TYPE_WAP;
 	else if (g_str_equal(str, "mms"))
 		return OFONO_GPRS_CONTEXT_TYPE_MMS;
+	else if (g_str_equal(str, "ims"))
+		return OFONO_GPRS_CONTEXT_TYPE_IMS;
 =

 	return OFONO_GPRS_CONTEXT_TYPE_INVALID;
 }
-- =

1.7.1


--===============8433127436059527838==--

