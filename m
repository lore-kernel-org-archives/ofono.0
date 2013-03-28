Content-Type: multipart/mixed; boundary="===============4470045875694103109=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [RFC PATCH 1/3] modem: Allow setting boolean properties
Date: Thu, 28 Mar 2013 10:22:20 -0400
Message-ID: <20130328142220.GG29445@alittletooquiet.net>
In-Reply-To: <20130328142112.GF29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4470045875694103109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 src/modem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 3c7c80a..0f12f5a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1659,7 +1659,8 @@ static int set_modem_property(struct ofono_modem *mod=
em, const char *name,
 	DBG("modem %p property %s", modem, name);
 =

 	if (type !=3D PROPERTY_TYPE_STRING &&
-			type !=3D PROPERTY_TYPE_INTEGER)
+			type !=3D PROPERTY_TYPE_INTEGER &&
+			type !=3D PROPERTY_TYPE_BOOLEAN)
 		return -EINVAL;
 =

 	property =3D g_try_new0(struct modem_property, 1);
-- =

1.7.0.4

--===============4470045875694103109==--

