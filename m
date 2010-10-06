Content-Type: multipart/mixed; boundary="===============0320013236518201952=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ussd-mmi PATCH 1/4] Fix valid_ussd_string()
Date: Wed, 06 Oct 2010 17:52:16 +0300
Message-ID: <1286376739-20677-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286376739-20677-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0320013236518201952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The valid_ussd_string() returns now true if MMI input is to be sent as
USSD.

The comment about USSD routing is removed, it is out of scope of oFono.
The cellular network routes the USSD requests based on the rules laid
out in the 22.090, however, any string that can be encoded according to
the rules of 23.038 is valid USSD.
---
 src/common.c |   44 +++++++++++++++++++-------------------------
 src/common.h |    2 +-
 src/ussd.c   |   13 ++++++++++++-
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/src/common.c b/src/common.c
index 55c4b40..13acd53 100644
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

@@ -401,37 +401,31 @@ int valid_ussd_string(const char *str)
 		return FALSE;
 =

 	/*
-	 * It is hard to understand exactly what constitutes a valid USSD string
-	 * According to 22.090:
-	 * Case a - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
-	 * where X=3Dany number 0=EF=BF=BD=EF=BF=BD=EF=BF=BD4, Y=3Dany number 0=
=EF=BF=BD=EF=BF=BD=EF=BF=BD9, then, optionally "*
-	 * followed by any number of any characters", and concluding with #SEND
+	 * Return true if an MMI input string is to be sent as USSD.
 	 *
-	 * Case b - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
-	 * where X=3Dany number 5=EF=BF=BD=EF=BF=BD=EF=BF=BD9, Y=3Dany number 0=
=EF=BF=BD=EF=BF=BD=EF=BF=BD9, then, optionally "*
-	 * followed by any number of any characters", and concluding with #SEND
+	 * According to 3GPP TS 22.030, after checking the well-known
+	 * supplementary service control, SIM control and manufacturer
+	 * defined control codes, the terminal should check if the input
+	 * should be sent as USSD according to the following rules:
 	 *
-	 * Case c - 7(Y) SEND, where Y=3Dany number 0=EF=BF=BD=EF=BF=BD=EF=BF=BD9
+	 * 1) Terminated by '#'
+	 * 2) A short string of 1 or 2 digits
 	 *
-	 * Case d - All other formats
-	 *
-	 * According to 22.030 Figure 3.5.3.2 USSD strings can be:
-	 *
-	 * Supplementary service control
-	 * SIM control
-	 * Manufacturer defined
-	 * Terminated by '#'
-	 * Short String - This can be any 2 digit short string.  If the string
-	 *                starts with a '1' and no calls are in progress then
-	 *                this string is treated as a call setup request
-	 *
-	 * Everything else is not a valid USSD string
+	 * As an exception, if a 2 digit string starts with a '1' and
+	 * there are no calls in progress then this string is treated as
+	 * a call setup request instead.
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
index aad7d32..90df632 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -545,6 +545,9 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 					void *data)
 {
 	struct ofono_ussd *ussd =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ussd->atom);
+	struct ofono_atom *vca;
+	gboolean call_in_progress;
 	const char *str;
 	int dcs =3D 0x0f;
 	unsigned char buf[160];
@@ -564,8 +567,16 @@ static DBusMessage *ussd_initiate(DBusConnection *conn=
, DBusMessage *msg,
 	if (recognized_control_string(ussd, str, msg))
 		return NULL;
 =

+	vca =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL);
+	if (vca)
+		call_in_progress =3D __ofono_voicecall_is_busy(
+			__ofono_atom_get_data(vca),
+			OFONO_VOICECALL_INTERACTION_NONE);
+	else
+		call_in_progress =3D FALSE;
+
 	DBG("No.., checking if this is a USSD string");
-	if (!valid_ussd_string(str))
+	if (!valid_ussd_string(str, call_in_progress))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!ussd_encode(str, &num_packed, buf))
-- =

1.7.0.4


--===============0320013236518201952==--

