Content-Type: multipart/mixed; boundary="===============3842978371148819869=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 1/7] src: Introduced enum called_number_type
Date: Sun, 23 Jan 2011 11:16:30 +0100
Message-ID: <1295777796-19978-2-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3842978371148819869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on 24.008 section 10.5.4.7 enum called_number_type
is to be used when phone number type is required.
---
 src/call-forwarding.c |    2 +-
 src/common.c          |    8 ++++----
 src/common.h          |   10 ++++++++++
 src/phonebook.c       |    3 +--
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 512f223..b9e6633 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -791,7 +791,7 @@ static DBusMessage *cf_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		int timeout;
 =

 		ph.number[0] =3D '\0';
-		ph.type =3D 129;
+		ph.type =3D CALLED_NUMBER_TYPE_UNKNOWN;
 =

 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
 			return __ofono_error_invalid_args(msg);
diff --git a/src/common.c b/src/common.c
index 4d93488..44bc925 100644
--- a/src/common.c
+++ b/src/common.c
@@ -405,8 +405,8 @@ const char *phone_number_to_string(const struct ofono_p=
hone_number *ph)
 {
 	static char buffer[64];
 =

-	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
-			ph->number[0] !=3D '+') {
+	if (ph->type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL &&
+		(strlen(ph->number) > 0) && ph->number[0] !=3D '+') {
 		buffer[0] =3D '+';
 		strncpy(buffer + 1, ph->number, 62);
 		buffer[63] =3D '\0';
@@ -422,10 +422,10 @@ void string_to_phone_number(const char *str, struct o=
fono_phone_number *ph)
 {
 	if (str[0] =3D=3D '+') {
 		strcpy(ph->number, str+1);
-		ph->type =3D 145;	/* International */
+		ph->type =3D CALLED_NUMBER_TYPE_INTERNATIONAL;
 	} else {
 		strcpy(ph->number, str);
-		ph->type =3D 129;	/* Local */
+		ph->type =3D CALLED_NUMBER_TYPE_UNKNOWN;
 	}
 }
 =

diff --git a/src/common.h b/src/common.h
index 5edff49..a019231 100644
--- a/src/common.h
+++ b/src/common.h
@@ -135,6 +135,16 @@ enum context_status {
 	CONTEXT_STATUS_ACTIVATED =3D 1,
 };
 =

+/* 24.008 Section 10.5.4.7 Called party BCD number */
+enum called_number_type {
+	CALLED_NUMBER_TYPE_UNKNOWN =3D 0,
+	CALLED_NUMBER_TYPE_INTERNATIONAL =3D 1,
+	CALLED_NUMBER_TYPE_NATIONAL =3D 2,
+	CALLED_NUMBER_TYPE_NETWORK_SPECIFIC =3D 3,
+	CALLED_NUMBER_TYPE_DEDICATED_ACCESS =3D 4,
+	CALLED_NUMBER_TYPE_RESERVED =3D 7
+};
+
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
diff --git a/src/phonebook.c b/src/phonebook.c
index e388ac1..cf33e00 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -38,7 +38,6 @@
 #include "common.h"
 =

 #define LEN_MAX 128
-#define TYPE_INTERNATIONAL 145
 =

 #define PHONEBOOK_FLAG_CACHED 0x1
 =

@@ -176,7 +175,7 @@ static void vcard_printf_number(GString *vcards, const =
char *number, int type,
 		break;
 	}
 =

-	if ((type =3D=3D TYPE_INTERNATIONAL) && (number[0] !=3D '+'))
+	if ((type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL) && (number[0] !=3D '+'=
))
 		intl =3D "+";
 =

 	snprintf(buf, sizeof(buf), "TEL;TYPE=3D\%s%s:\%s\%s", pref,
-- =

1.5.6.5


--===============3842978371148819869==--

