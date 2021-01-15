Content-Type: multipart/mixed; boundary="===============5158837541042500753=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 19:38:56 +0300
Message-ID: <20210115163856.18674-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5158837541042500753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure that IMPI is a valid UTF8 string before attempting
to report it via DBus. Otherwise ofono may crash on dbus assert.
This field may not be defined for ISIM in use. In this case the
field still can be read from ISIM, though it will not contain
a valid UTF8 string. For instance, it may contain 255 0xFF bytes.
---
 src/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 33e1245f..f60f5d1b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -423,7 +423,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 		ofono_dbus_dict_append(&dict, "ServiceProviderName",
 					DBUS_TYPE_STRING, &sim->spn);
 =

-	if (sim->impi)
+	if (sim->impi && g_utf8_validate(sim->impi, 255, NULL))
 		ofono_dbus_dict_append(&dict, "ImsPrivateIdentity",
 					DBUS_TYPE_STRING, &sim->impi);
=20
--===============5158837541042500753==--

