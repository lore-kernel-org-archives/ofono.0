Content-Type: multipart/mixed; boundary="===============8098149134987561025=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/4] src/gprs.c: added support for NONE and ANY authentication
 methods
Date: Thu, 20 Sep 2018 06:23:50 +0200
Message-ID: <1537417430-10904-4-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537417430-10904-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8098149134987561025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 377eced..f17f31b 100644
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

1.9.1


--===============8098149134987561025==--

