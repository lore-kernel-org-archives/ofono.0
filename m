Content-Type: multipart/mixed; boundary="===============1059754076010403533=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/4] gprs: added two authentication methods: NONE and ANY
Date: Thu, 20 Sep 2018 06:23:47 +0200
Message-ID: <1537417430-10904-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1059754076010403533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OFONO_GPRS_AUTH_METHOD_NONE disables the authentication
OFONO_GPRS_AUTH_METHOD_ANY tries first CHAP then PAP,
but only applies to supporting drivers and modules
---
 include/gprs-context.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 20ca9ef..7e1dfcc 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -55,7 +55,9 @@ enum ofono_gprs_context_type {
 };
 =

 enum ofono_gprs_auth_method {
-	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
+	OFONO_GPRS_AUTH_METHOD_ANY =3D 0,
+	OFONO_GPRS_AUTH_METHOD_NONE,
+	OFONO_GPRS_AUTH_METHOD_CHAP,
 	OFONO_GPRS_AUTH_METHOD_PAP,
 };
 =

-- =

1.9.1


--===============1059754076010403533==--

