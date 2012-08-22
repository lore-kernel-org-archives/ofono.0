Content-Type: multipart/mixed; boundary="===============4148329317097092027=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/8] stkagent: '+' is considered as a digit
Date: Wed, 22 Aug 2012 18:18:17 +0200
Message-ID: <1345652303-12866-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4148329317097092027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function 'valid_phone_number_format' does not comply with GCF test cases
expectation. For STK, the character '+' should be considered as a whole dig=
it.
---
 src/stkagent.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 7c3f697..392a2b2 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -69,6 +69,27 @@ struct stk_agent {
 #define TERMINATE_ERROR ERROR_PREFIX ".EndSession"
 #define BUSY_ERROR ERROR_PREFIX ".Busy"
 =

+static gboolean check_digit(const char *digit)
+{
+	int len =3D strlen(digit);
+	int i;
+
+	if (!len)
+		return FALSE;
+
+	for (i =3D 0; i < len; i++) {
+		if (digit[i] >=3D '0' && digit[i] <=3D '9')
+			continue;
+
+		if (digit[i] =3D=3D '*' || digit[i] =3D=3D '#' || digit[i] =3D=3D '+')
+			continue;
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void stk_agent_send_noreply(struct stk_agent *agent, const char *me=
thod)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -541,7 +562,7 @@ static void get_digit_cb(DBusPendingCall *call, void *d=
ata)
 					DBUS_TYPE_STRING, &digit,
 					DBUS_TYPE_INVALID) =3D=3D FALSE ||
 			strlen(digit) !=3D 1 ||
-			!valid_phone_number_format(digit)) {
+			!check_digit(digit)) {
 		ofono_error("Can't parse the reply to GetDigit()");
 		remove_agent =3D TRUE;
 		goto error;
@@ -675,7 +696,8 @@ static void get_digits_cb(DBusPendingCall *call, void *=
data)
 =

 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_STRING, &string,
-					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+					DBUS_TYPE_INVALID) =3D=3D FALSE ||
+					!check_digit(string)) {
 		ofono_error("Can't parse the reply to GetDigits()");
 		remove_agent =3D TRUE;
 		goto error;
-- =

1.7.9.5


--===============4148329317097092027==--

