Content-Type: multipart/mixed; boundary="===============0788833503409785894=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 3/6] src/gprs: support for NONE auth
Date: Tue, 02 Oct 2018 08:26:26 +0200
Message-ID: <20181002062628.17466-4-gciofono@gmail.com>
In-Reply-To: <20181002062628.17466-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0788833503409785894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 79fafdbc..235c8884 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -261,6 +261,10 @@ static const char *gprs_auth_method_to_string(enum ofo=
no_gprs_auth_method auth)
 		return "chap";
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return "pap";
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return "none";
+	default:
+		return NULL;
 	};
 =

 	return NULL;
@@ -275,6 +279,9 @@ static gboolean gprs_auth_method_from_string(const char=
 *str,
 	} else if (g_str_equal(str, "pap")) {
 		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
 		return TRUE;
+	} else if (g_str_equal(str, "none")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

2.17.1


--===============0788833503409785894==--

