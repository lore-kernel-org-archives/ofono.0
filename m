Content-Type: multipart/mixed; boundary="===============8151718009070468968=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/5] gprs-context: added OFONO_GPRS_AUTH_METHOD_NONE
Date: Sat, 06 Oct 2018 07:45:17 +0200
Message-ID: <20181006054520.26737-2-gciofono@gmail.com>
In-Reply-To: <20181006054520.26737-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8151718009070468968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This method makes explicit the lack of authentication.

When selected, the username and password are ignored, but they are not
changed in the user-defined properties for the context.
This treatment is necessary to allow setting independently auth_method,
username and password.

This method is also selected implicitly when username is set to
an empty string. Also this selection is done without changing the
user-defined auth_method for the context, so that the behavior is
consistent.
---
 include/gprs-context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 20ca9efc..8869c12e 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -57,6 +57,7 @@ enum ofono_gprs_context_type {
 enum ofono_gprs_auth_method {
 	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
 	OFONO_GPRS_AUTH_METHOD_PAP,
+	OFONO_GPRS_AUTH_METHOD_NONE,
 };
 =

 struct ofono_gprs_primary_context {
-- =

2.17.1


--===============8151718009070468968==--

