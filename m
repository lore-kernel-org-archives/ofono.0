Content-Type: multipart/mixed; boundary="===============5068028051731271496=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Return network's USSD reponses from the Respond method
 instead of signalling
Date: Wed, 31 Mar 2010 06:57:07 +0200
Message-ID: <1270011427-6744-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5068028051731271496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/supplementaryservices-api.txt |    2 +-
 src/ussd.c                        |   31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/doc/supplementaryservices-api.txt b/doc/supplementaryservices-=
api.txt
index 23796c1..115e2ff 100644
--- a/doc/supplementaryservices-api.txt
+++ b/doc/supplementaryservices-api.txt
@@ -16,7 +16,7 @@ Methods		string, variant Initiate(string command)
 			new command can be initiated until this one is
 			cancelled or ended.
 =

-		void Respond(string reply)
+		string Respond(string reply)
 =

 			Send a response to the network either when
 			it is awaiting further input after Initiate()
diff --git a/src/ussd.c b/src/ussd.c
index a2a4f5d..9ec7600 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -360,8 +360,20 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, const char *str)
 		else
 			ussd_change_state(ussd, USSD_STATE_IDLE);
 =

-	} else if (ussd->state =3D=3D USSD_STATE_IDLE ||
-			ussd->state =3D=3D USSD_STATE_RESPONSE_SENT) {
+	} else if (ussd->state =3D=3D USSD_STATE_RESPONSE_SENT) {
+		reply =3D dbus_message_new_method_return(ussd->pending);
+
+		if (!str)
+			str =3D "";
+
+		dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
+						DBUS_TYPE_INVALID);
+
+		if (status =3D=3D OFONO_USSD_STATUS_ACTION_REQUIRED)
+			ussd_change_state(ussd, USSD_STATE_USER_ACTION);
+		else
+			ussd_change_state(ussd, USSD_STATE_IDLE);
+	} else if (ussd->state =3D=3D USSD_STATE_IDLE) {
 		const char *signal_name;
 		const char *path =3D __ofono_atom_get_path(ussd->atom);
 		int new_state;
@@ -462,14 +474,19 @@ static void ussd_response_callback(const struct ofono=
_error *error, void *data)
 	struct ofono_ussd *ussd =3D data;
 	DBusMessage *reply;
 =

+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		DBG("ussd response failed with error: %s",
+				telephony_error_to_str(error));
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ussd_change_state(ussd, USSD_STATE_RESPONSE_SENT);
-		reply =3D dbus_message_new_method_return(ussd->pending);
-	} else {
-		ussd_change_state(ussd, USSD_STATE_IDLE);
-		reply =3D __ofono_error_failed(ussd->pending);
+		return;
 	}
 =

+	if (!ussd->pending)
+		return;
+
+	reply =3D __ofono_error_failed(ussd->pending);
 	__ofono_dbus_pending_reply(&ussd->pending, reply);
 }
 =

@@ -575,7 +592,7 @@ static DBusMessage *ussd_get_properties(DBusConnection =
*conn,
 static GDBusMethodTable ussd_methods[] =3D {
 	{ "Initiate",		"s",	"sv",		ussd_initiate,
 					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Respond",		"s",	"",		ussd_respond,
+	{ "Respond",		"s",	"s",		ussd_respond,
 					G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Cancel",		"",	"",		ussd_cancel,
 					G_DBUS_METHOD_FLAG_ASYNC },
-- =

1.6.1


--===============5068028051731271496==--

