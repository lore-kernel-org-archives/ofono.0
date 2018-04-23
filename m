Content-Type: multipart/mixed; boundary="===============8560967127121348387=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] ussd: Don't ignore data from TERMINATED response
Date: Mon, 23 Apr 2018 18:33:08 +0300
Message-ID: <1524497588-12079-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8560967127121348387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Typically responses to USSD requests are coming with status
zero (NOTIFY) but some are coming with status 2 (TERMINATED).
If those contain data, the data should be presented to the user.
---
 src/ussd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index 84f64c6..f5dd9d9 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -417,13 +417,18 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, int dcs,
 	}
 =

 	if (status =3D=3D OFONO_USSD_STATUS_TERMINATED) {
-		ussd_change_state(ussd, USSD_STATE_IDLE);
+		if (ussd->state =3D=3D USSD_STATE_ACTIVE && data && data_len > 0) {
+			/* Interpret that as a Notify */
+			status =3D OFONO_USSD_STATUS_NOTIFY;
+		} else {
+			ussd_change_state(ussd, USSD_STATE_IDLE);
 =

-		if (ussd->pending =3D=3D NULL)
-			return;
+			if (ussd->pending =3D=3D NULL)
+				return;
 =

-		reply =3D __ofono_error_network_terminated(ussd->pending);
-		goto out;
+			reply =3D __ofono_error_network_terminated(ussd->pending);
+			goto out;
+		}
 	}
 =

 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
-- =

1.9.1


--===============8560967127121348387==--

