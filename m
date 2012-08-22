Content-Type: multipart/mixed; boundary="===============9088540766920542626=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/8] ussd: Recover idle state in case of response sending
 failure
Date: Wed, 22 Aug 2012 18:18:16 +0200
Message-ID: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9088540766920542626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCF test case 31.8.1.2.3 is rejecting the user response.
Any subsequent USSD notification are not handled because USSD is always in
state user-action.
---
 src/ussd.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/ussd.c b/src/ussd.c
index 74888b2..0ad4f61 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -414,6 +414,10 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 		return;
 	}
 =

+	if (status =3D=3D OFONO_USSD_STATUS_TERMINATED &&
+			ussd->state =3D=3D USSD_STATE_IDLE)
+		return;
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

@@ -595,9 +599,11 @@ static void ussd_response_callback(const struct ofono_=
error *error, void *data)
 	struct ofono_ussd *ussd =3D data;
 	DBusMessage *reply;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("ussd response failed with error: %s",
 				telephony_error_to_str(error));
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+	}
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ussd_change_state(ussd, USSD_STATE_RESPONSE_SENT);
-- =

1.7.9.5


--===============9088540766920542626==--

