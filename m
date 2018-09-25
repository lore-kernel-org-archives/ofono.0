Content-Type: multipart/mixed; boundary="===============3979571897186368265=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/4] gprs-context: added OFONO_GPRS_AUTH_METHOD_NONE
Date: Tue, 25 Sep 2018 15:20:32 +0200
Message-ID: <20180925132035.19417-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3979571897186368265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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


--===============3979571897186368265==--

