Content-Type: multipart/mixed; boundary="===============0515710501155240352=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Fix valid_ussd_string()
Date: Wed, 22 Sep 2010 21:32:39 +0300
Message-ID: <1285180359-12802-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0515710501155240352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The valid_ussd_string() returns true if MMI input is to be sent as USSD.
---
 src/common.c |   39 ++++++++++++++-------------------------
 src/common.h |    2 +-
 src/ussd.c   |    2 +-
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/src/common.c b/src/common.c
index 55c4b40..e0a8387 100644
--- a/src/common.c
+++ b/src/common.c
@@ -393,7 +393,7 @@ void string_to_phone_number(const char *str, struct ofo=
no_phone_number *ph)
 	}
 }
 =

-int valid_ussd_string(const char *str)
+gboolean valid_ussd_string(const char *str, gboolean call_in_progress)
 {
 	int len =3D strlen(str);
 =

@@ -401,37 +401,26 @@ int valid_ussd_string(const char *str)
 		return FALSE;
 =

 	/*
-	 * It is hard to understand exactly what constitutes a valid USSD string
-	 * According to 22.090:
-	 * Case a - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
-	 * where X=3Dany number 0=E2=80=914, Y=3Dany number 0=E2=80=919, then, op=
tionally "*
-	 * followed by any number of any characters", and concluding with #SEND
-	 *
-	 * Case b - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
-	 * where X=3Dany number 5=E2=80=919, Y=3Dany number 0=E2=80=919, then, op=
tionally "*
-	 * followed by any number of any characters", and concluding with #SEND
-	 *
-	 * Case c - 7(Y) SEND, where Y=3Dany number 0=E2=80=919
-	 *
-	 * Case d - All other formats
-	 *
 	 * According to 22.030 Figure 3.5.3.2 USSD strings can be:
 	 *
-	 * Supplementary service control
-	 * SIM control
-	 * Manufacturer defined
-	 * Terminated by '#'
-	 * Short String - This can be any 2 digit short string.  If the string
-	 *                starts with a '1' and no calls are in progress then
-	 *                this string is treated as a call setup request
+	 * 1) Terminated by '#'
+	 * 2) A short string of 1 or 2 digits.
 	 *
-	 * Everything else is not a valid USSD string
+	 * If a 2 digit string starts with a '1' and no calls are in
+	 * progress then this string is treated as a call setup request
+	 * instead.
 	 */
 =

-	if (len !=3D 2 && str[len-1] !=3D '#')
+	if (str[len-1] =3D=3D '#')
+		return TRUE;
+
+	if (!call_in_progress && len =3D=3D 2 && str[0] !=3D '1')
 		return FALSE;
 =

-	return TRUE;
+	if (len <=3D 2)
+		return TRUE;
+
+	return FALSE;
 }
 =

 const char *ss_control_type_to_string(enum ss_control_type type)
diff --git a/src/common.h b/src/common.h
index c43e46d..8b5798a 100644
--- a/src/common.h
+++ b/src/common.h
@@ -130,7 +130,7 @@ void string_to_phone_number(const char *str, struct ofo=
no_phone_number *ph);
 =

 int mmi_service_code_to_bearer_class(int code);
 =

-gboolean valid_ussd_string(const char *str);
+gboolean valid_ussd_string(const char *str, gboolean call_in_progress);
 =

 gboolean parse_ss_control_string(char *str, int *ss_type,
 					char **sc, char **sia,
diff --git a/src/ussd.c b/src/ussd.c
index aad7d32..24950ac 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -565,7 +565,7 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 		return NULL;
 =

 	DBG("No.., checking if this is a USSD string");
-	if (!valid_ussd_string(str))
+	if (!valid_ussd_string(str, ussd->call_in_progress))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!ussd_encode(str, &num_packed, buf))
-- =

1.7.0.4


--===============0515710501155240352==--

