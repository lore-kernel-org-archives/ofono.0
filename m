Content-Type: multipart/mixed; boundary="===============7841410443765857269=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 1/4] ussd: Recover idle state after a transaction error
Date: Wed, 05 Sep 2012 18:56:19 +0200
Message-ID: <1346864182-24464-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7841410443765857269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "USSD terminated by network" notification is handled to recover
the idle state in case of USSD transaction error.
---
 src/ussd.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/ussd.c b/src/ussd.c
index 74888b2..a35f172 100644
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
+		reply =3D __ofono_error_failed(ussd->pending);
+		goto out;
+	}
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

-- =

1.7.9.5


--===============7841410443765857269==--

