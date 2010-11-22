Content-Type: multipart/mixed; boundary="===============2856655312509956346=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] common: add long dial string support
Date: Mon, 22 Nov 2010 18:36:28 +0200
Message-ID: <c0634297366b1e329575e33a7fe6c3bf19d93167.1290436058.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1290436058.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2856655312509956346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +-
 src/common.c    |   38 +++++++++++++++++++++++++++++++++-----
 src/common.h    |    1 +
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/types.h b/include/types.h
index ba2481f..b3d2247 100644
--- a/include/types.h
+++ b/include/types.h
@@ -76,7 +76,7 @@ struct ofono_error {
 	int error;
 };
 =

-#define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_PHONE_NUMBER_LENGTH 120
 =

 struct ofono_phone_number {
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
diff --git a/src/common.c b/src/common.c
index b5b9a6f..56a6aa8 100644
--- a/src/common.c
+++ b/src/common.c
@@ -262,6 +262,34 @@ gboolean valid_phone_number_format(const char *number)
 	return TRUE;
 }
 =

+gboolean valid_dial_string(const char *number)
+{
+	int len =3D strlen(number);
+	int begin =3D 0;
+	int i;
+
+	if (!len)
+		return FALSE;
+
+	if (number[0] =3D=3D '+')
+		begin =3D 1;
+
+	if ((len - begin) > OFONO_MAX_PHONE_NUMBER_LENGTH)
+		return FALSE;
+
+	for (i =3D begin; i < len; i++) {
+		if (number[i] >=3D '0' && number[i] <=3D '9')
+			continue;
+
+		if (number[i] =3D=3D '*' || number[i] =3D=3D '#' || number[i] =3D=3D 'p')
+			continue;
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 const char *telephony_error_to_str(const struct ofono_error *error)
 {
 	struct error_entry *e;
@@ -379,18 +407,18 @@ int mmi_service_code_to_bearer_class(int code)
 =

 const char *phone_number_to_string(const struct ofono_phone_number *ph)
 {
-	static char buffer[64];
+	static char buffer[(OFONO_MAX_PHONE_NUMBER_LENGTH + 1) + 1];
 =

 	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
 			ph->number[0] !=3D '+') {
 		buffer[0] =3D '+';
-		strncpy(buffer + 1, ph->number, 62);
-		buffer[63] =3D '\0';
+		strncpy(buffer + 1, ph->number, sizeof(buffer) - 2);
 	} else {
-		strncpy(buffer, ph->number, 63);
-		buffer[63] =3D '\0';
+		strncpy(buffer, ph->number, sizeof(buffer) - 1);
 	}
 =

+	buffer[sizeof(buffer) - 1] =3D '\0';
+
 	return buffer;
 }
 =

diff --git a/src/common.h b/src/common.h
index 8b5798a..c7bfe26 100644
--- a/src/common.h
+++ b/src/common.h
@@ -125,6 +125,7 @@ enum pin_type {
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
+gboolean valid_dial_string(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
 void string_to_phone_number(const char *str, struct ofono_phone_number *ph=
);
 =

-- =

1.7.0.4


--===============2856655312509956346==--

