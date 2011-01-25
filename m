Content-Type: multipart/mixed; boundary="===============4153100362844227098=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 2/2] common: add function to validate long numbers
Date: Tue, 25 Jan 2011 11:02:38 -0300
Message-ID: <1295964158-19223-3-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1295964158-19223-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4153100362844227098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also, adapt voicecall to use the new function for outgoing calls.

---
 src/common.c    |   20 ++++++++++++++++++--
 src/common.h    |    2 ++
 src/voicecall.c |    2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/common.c b/src/common.c
index 4d93488..8bf9dbb 100644
--- a/src/common.c
+++ b/src/common.c
@@ -234,7 +234,7 @@ struct error_entry ceer_errors[] =3D {
 	{ 127,	"Interworking, unspecified" },
 };
 =

-gboolean valid_phone_number_format(const char *number)
+gboolean valid_number_format(const char *number, int length)
 {
 	int len =3D strlen(number);
 	int begin =3D 0;
@@ -246,7 +246,7 @@ gboolean valid_phone_number_format(const char *number)
 	if (number[0] =3D=3D '+')
 		begin =3D 1;
 =

-	if ((len - begin) > OFONO_MAX_PHONE_NUMBER_LENGTH)
+	if ((len - begin) > length)
 		return FALSE;
 =

 	for (i =3D begin; i < len; i++) {
@@ -262,6 +262,22 @@ gboolean valid_phone_number_format(const char *number)
 	return TRUE;
 }
 =

+/*
+ * According to 3GPP TS 24.011 or 3GPP TS 31.102, some
+ * addresses (or numbers), like Service Centre address,
+ * Destination address, or EFADN (Abbreviated dialling numbers),
+ * are up 20 digits.
+ */
+gboolean valid_phone_number_format(const char *number)
+{
+	return valid_number_format(number, 20);
+}
+
+gboolean valid_long_phone_number_format(const char *number)
+{
+	return valid_number_format(number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+}
+
 gboolean valid_cdma_phone_number_format(const char *number)
 {
 	int len =3D strlen(number);
diff --git a/src/common.h b/src/common.h
index 5edff49..09f2deb 100644
--- a/src/common.h
+++ b/src/common.h
@@ -137,7 +137,9 @@ enum context_status {
 =

 const char *telephony_error_to_str(const struct ofono_error *error);
 =

+gboolean valid_number_format(const char *number, int length);
 gboolean valid_phone_number_format(const char *number);
+gboolean valid_long_phone_number_format(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
 void string_to_phone_number(const char *str, struct ofono_phone_number *ph=
);
 =

diff --git a/src/voicecall.c b/src/voicecall.c
index 7e2b3f0..e6bfe04 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1304,7 +1304,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!valid_phone_number_format(number))
+	if (!valid_long_phone_number_format(number))
 		return __ofono_error_invalid_format(msg);
 =

 	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
-- =

1.7.2.3


--===============4153100362844227098==--

