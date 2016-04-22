Content-Type: multipart/mixed; boundary="===============3017775699009292562=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 1/5] modem: clean up atoms on modem_unregister
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-2-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330431-20206-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3017775699009292562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

This resolves a crash that can happen when a e.g. usb modem is removed.
---
 src/modem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index a89fa48..4968839 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -2071,6 +2071,9 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 	if (modem->powered =3D=3D TRUE)
 		set_powered(modem, FALSE);
 =

+	if (modem->atoms)
+		flush_atoms(modem, MODEM_STATE_POWER_OFF);
+
 	__ofono_watchlist_free(modem->atom_watches);
 	modem->atom_watches =3D NULL;
 =

-- =

1.9.1

--===============3017775699009292562==--

