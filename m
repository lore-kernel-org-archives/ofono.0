Content-Type: multipart/mixed; boundary="===============4366425412427284562=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] Enable USSD_STATE_USER_ACTION
Date: Tue, 09 Feb 2010 22:20:08 +0200
Message-ID: <1265746808-26098-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4366425412427284562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the network requests user action in the response to an MO USSD, we
cannot immediately return to USSD_STATE_USER_IDLE. Instead,
USSD_STATE_USER_ACTION is entered.

Note that it is left up to the driver to notify() when the USSD
transaction is closed by the network due to inactivity. Another way to
return to USSD_STATE_IDLE is for the user to cancel() the transaction.
---
 src/ussd.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index 464664c..c8937d6 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -294,22 +294,26 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
 =

 	if (status =3D=3D USSD_STATUS_NOT_SUPPORTED) {
 		ussd->state =3D USSD_STATE_IDLE;
+
+		if (!ussd->pending)
+			return;
+
 		reply =3D __ofono_error_not_supported(ussd->pending);
 		goto out;
 	}
 =

 	if (status =3D=3D USSD_STATUS_TIMED_OUT) {
 		ussd->state =3D USSD_STATE_IDLE;
+
+		if (!ussd->pending)
+			return;
+
 		reply =3D __ofono_error_timed_out(ussd->pending);
 		goto out;
 	}
 =

 	/* TODO: Rework this in the Agent framework */
 	if (ussd->state =3D=3D USSD_STATE_ACTIVE) {
-		if (status =3D=3D USSD_STATUS_ACTION_REQUIRED) {
-			ofono_error("Unable to handle action required ussd");
-			return;
-		}
 =

 		reply =3D dbus_message_new_method_return(ussd->pending);
 =

@@ -329,7 +333,11 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, const char *str)
 =

 		dbus_message_iter_close_container(&iter, &variant);
 =

-		ussd->state =3D USSD_STATE_IDLE;
+		if (status =3D=3D USSD_STATUS_ACTION_REQUIRED)
+			ussd->state =3D USSD_STATE_USER_ACTION;
+		else
+			ussd->state =3D USSD_STATE_IDLE;
+
 	} else {
 		ofono_error("Received an unsolicited USSD, ignoring for now...");
 		ofono_debug("USSD is: status: %d, %s", status, str);
-- =

1.6.3.3


--===============4366425412427284562==--

