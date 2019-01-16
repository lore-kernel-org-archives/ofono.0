Content-Type: multipart/mixed; boundary="===============3497000088510391760=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] modem: add support to clear cached pins.
Date: Wed, 16 Jan 2019 12:15:31 +0530
Message-ID: <1547621131-7600-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3497000088510391760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support to clear cached pins when modem is powered off.
---
 src/modem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index bc46275..baacdc8 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1130,6 +1130,9 @@ static DBusMessage *modem_set_property(DBusConnection=
 *conn,
 		if (modem->lockdown)
 			return __ofono_error_access_denied(msg);
 =

+		if (!powered)
+			ofono_sim_clear_cached_pins(modem->sim);
+
 		err =3D set_powered(modem, powered);
 		if (err < 0) {
 			if (err !=3D -EINPROGRESS)
-- =

2.7.4


--===============3497000088510391760==--

