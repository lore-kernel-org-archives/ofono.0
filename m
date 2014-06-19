Content-Type: multipart/mixed; boundary="===============1801901337035224006=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 2/5] include: add auth method to the gprs context API
Date: Thu, 19 Jun 2014 12:07:06 +0200
Message-ID: <1403172429-26289-3-git-send-email-philip@paeps.cx>
In-Reply-To: <1403172429-26289-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1801901337035224006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 27d4b49..ed27e66 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -48,6 +48,11 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

+enum ofono_gprs_auth_method {
+	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
+	OFONO_GPRS_AUTH_METHOD_PAP,
+};
+
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
@@ -55,6 +60,7 @@ struct ofono_gprs_primary_context {
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	enum ofono_gprs_proto proto;
+	enum ofono_gprs_auth_method auth_method;
 };
 =

 typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
-- =

1.7.10.4


--===============1801901337035224006==--

