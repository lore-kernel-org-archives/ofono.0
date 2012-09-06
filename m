Content-Type: multipart/mixed; boundary="===============2043658553378974933=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 2/2] ussd: Recover idle state after a transaction error
Date: Thu, 06 Sep 2012 16:21:46 +0200
Message-ID: <1346941306-3168-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346941306-3168-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2043658553378974933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "USSD terminated by network" notification is handled to recover
the idle state in case of USSD transaction error.
---
 src/ussd.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/ussd.c b/src/ussd.c
index 74888b2..60b1f6b 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -414,6 +414,16 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 		return;
 	}
 =

+	if (status =3D=3D OFONO_USSD_STATUS_TERMINATED) {
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+
+		if (ussd->pending =3D=3D NULL)
+			return;
+
+		reply =3D __ofono_error_terminated_by_network(ussd->pending);
+		goto out;
+	}
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

-- =

1.7.9.5


--===============2043658553378974933==--

