Content-Type: multipart/mixed; boundary="===============7987003408020691941=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 05/14] include: add CNAP fields and defines
Date: Mon, 06 Dec 2010 18:12:33 -0200
Message-ID: <1291666362-19128-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7987003408020691941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    3 +++
 src/common.h    |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index ba2481f..de15437 100644
--- a/include/types.h
+++ b/include/types.h
@@ -77,6 +77,7 @@ struct ofono_error {
 };
 =

 #define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_CALLER_NAME_LENGTH 80
 =

 struct ofono_phone_number {
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
@@ -90,7 +91,9 @@ struct ofono_call {
 	int status;
 	ofono_bool_t mpty;
 	struct ofono_phone_number phone_number;
+	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
 	int clip_validity;
+	int cnap_validity;
 };
 =

 struct ofono_network_time {
diff --git a/src/common.h b/src/common.h
index 8b5798a..c8e7070 100644
--- a/src/common.h
+++ b/src/common.h
@@ -48,6 +48,13 @@ enum clip_validity {
 	CLIP_VALIDITY_NOT_AVAILABLE =3D 2
 };
 =

+/* 27.007 Section 7.30 */
+enum cnap_validity {
+	CNAP_VALIDITY_VALID =3D 0,
+	CNAP_VALIDITY_WITHHELD =3D 1,
+	CNAP_VALIDITY_NOT_AVAILABLE =3D 2
+};
+
 /* 27.007 Section 7.18 */
 enum call_status {
 	CALL_STATUS_ACTIVE =3D 0,
-- =

1.7.3.2


--===============7987003408020691941==--

