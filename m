Content-Type: multipart/mixed; boundary="===============3591754340534440062=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Set session state to RESPONSE_SENT after sending response.
Date: Mon, 01 Mar 2010 05:29:28 +0100
Message-ID: <1267417768-16937-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3591754340534440062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
I am not entirely sure this new state is needed though.  As the commit says
the network may continue the dialog but it is not obliged to send any kind
of response to our reponse, at least this is not in the specs.  So if it
doesn't send anything (neither a notification nor request) we will remain
in this state and user will not be able to Initiate a new session for that
time.  The other option, if I misunderstood the spec, would be to make the
Respond method return the string.

Regards
---
 src/ussd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index 4f5a131..a2a4f5d 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -463,7 +463,7 @@ static void ussd_response_callback(const struct ofono_e=
rror *error, void *data)
 	DBusMessage *reply;
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ussd_change_state(ussd, USSD_STATE_ACTIVE);
+		ussd_change_state(ussd, USSD_STATE_RESPONSE_SENT);
 		reply =3D dbus_message_new_method_return(ussd->pending);
 	} else {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
-- =

1.6.1


--===============3591754340534440062==--

