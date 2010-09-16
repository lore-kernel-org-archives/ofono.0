Content-Type: multipart/mixed; boundary="===============8875433798602092091=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 2/5] ussd: debug log notifys
Date: Thu, 16 Sep 2010 20:32:46 +0300
Message-ID: <1284658369-1988-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284658369-1988-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8875433798602092091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/ussd.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index 57390f1..bbb9aed 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -350,6 +350,43 @@ static int ussd_status_to_failure_code(int status)
 	return 0;
 }
 =

+static char const *ussd_status_name(int status)
+{
+	switch (status) {
+	case OFONO_USSD_STATUS_NOTIFY:
+		return "NOTIFY";
+	case OFONO_USSD_STATUS_ACTION_REQUIRED:
+		return "ACTION_REQUIRED";
+	case OFONO_USSD_STATUS_TERMINATED:
+		return "TERMINATED";
+	case OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED:
+		return "LOCAL_CLIENT_RESPONDED";
+	case OFONO_USSD_STATUS_NOT_SUPPORTED:
+		return "NOT_SUPPORTED";
+	case OFONO_USSD_STATUS_TIMED_OUT:
+		return "TIMED_OUT";
+	}
+
+	return "????";
+}
+
+static const char *ussd_state_name(enum ussd_state state)
+{
+	switch (state) {
+	case USSD_STATE_IDLE:
+		return "IDLE";
+	case USSD_STATE_ACTIVE:
+		return "ACTIVE";
+	case USSD_STATE_RESPONSE_SENT:
+		return "RESPONSE_SENT";
+	case USSD_STATE_USER_ACTION:
+		return "USER_ACTION";
+	}
+
+	return "????";
+}
+
+
 void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
 			const unsigned char *data, int data_len)
 {
@@ -362,6 +399,10 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 	DBusMessageIter iter;
 	DBusMessageIter variant;
 =

+	DBG("status: %d %s, state: %d %s",
+		status, ussd_status_name(status),
+		ussd->state, ussd_state_name(ussd->state));
+
 	if (ussd->req &&
 			(status =3D=3D OFONO_USSD_STATUS_NOTIFY ||
 			status =3D=3D OFONO_USSD_STATUS_TERMINATED ||
-- =

1.7.0.4


--===============8875433798602092091==--

