Content-Type: multipart/mixed; boundary="===============8700001599430105570=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] radio-settings: Show all available technologies
Date: Fri, 12 Dec 2014 12:25:35 +0100
Message-ID: <1418383535-3458-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8700001599430105570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all possible futures technologies were being showed on the DBus
interface.
---
 src/radio-settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 0a49305..1a511dc 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -225,12 +225,12 @@ static DBusMessage *radio_get_properties_reply(DBusMe=
ssage *msg,
 	}
 =

 	if (rs->available_rats) {
-		const char *rats[sizeof(uint32_t) + 1];
+		const char *rats[sizeof(uint32_t) * CHAR_BIT + 1];
 		const char **dbus_rats =3D rats;
 		int n =3D 0;
 		unsigned int i;
 =

-		for (i =3D 0; i < sizeof(uint32_t); i++) {
+		for (i =3D 0; i < sizeof(uint32_t) * CHAR_BIT; i++) {
 			int tech =3D 1 << i;
 =

 			if (!(rs->available_rats & tech))
-- =

2.1.0


--===============8700001599430105570==--

