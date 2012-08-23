Content-Type: multipart/mixed; boundary="===============1841885345445537319=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2] ussd: Recover idle state in case of response sending
 failure
Date: Thu, 23 Aug 2012 18:27:45 +0200
Message-ID: <1345739265-3080-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345739265-3080-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1841885345445537319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCF test case 31.8.1.2.3 is rejecting the user response.
Any subsequent USSD notification are not handled because USSD is always in
state user-action.
---
 src/ussd.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/ussd.c b/src/ussd.c
index 74888b2..21e0164 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -414,6 +414,18 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 		return;
 	}
 =

+	if (status =3D=3D OFONO_USSD_STATUS_TERMINATED &&
+			(ussd->state =3D=3D USSD_STATE_IDLE ||
+			ussd->state =3D=3D USSD_STATE_USER_ACTION)) {
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+
+		if (ussd->pending =3D=3D NULL)
+			return;
+
+		reply =3D __ofono_error_not_supported(ussd->pending);
+		goto out;
+	}
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

-- =

1.7.9.5


--===============1841885345445537319==--

