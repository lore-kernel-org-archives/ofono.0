Content-Type: multipart/mixed; boundary="===============8853793220417063556=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/4] gprs: Add 'stk' gprs context type
Date: Wed, 04 May 2011 19:26:39 +0200
Message-ID: <1304530002-13336-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1304530002-13336-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8853793220417063556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    1 +
 src/gprs.c             |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index f82fcaa..e7976a1 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -46,6 +46,7 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_MMS,
 	OFONO_GPRS_CONTEXT_TYPE_WAP,
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
+	OFONO_GPRS_CONTEXT_TYPE_STK,
 };
 =

 struct ofono_gprs_primary_context {
diff --git a/src/gprs.c b/src/gprs.c
index deffeb8..9657a3e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -188,6 +188,8 @@ static const char *gprs_context_default_name(enum ofono=
_gprs_context_type type)
 		return "WAP";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "IMS";
+	case OFONO_GPRS_CONTEXT_TYPE_STK:
+		return "STK";
 	}
 =

 	return NULL;
@@ -207,6 +209,8 @@ static const char *gprs_context_type_to_string(
 		return "wap";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "ims";
+	case OFONO_GPRS_CONTEXT_TYPE_STK:
+		return "stk";
 	}
 =

 	return NULL;
@@ -227,6 +231,9 @@ static gboolean gprs_context_string_to_type(const char =
*str,
 	} else if (g_str_equal(str, "ims")) {
 		*out =3D OFONO_GPRS_CONTEXT_TYPE_IMS;
 		return TRUE;
+	} else if (g_str_equal(str, "stk")) {
+		*out =3D OFONO_GPRS_CONTEXT_TYPE_STK;
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

1.7.1


--===============8853793220417063556==--

