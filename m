Content-Type: multipart/mixed; boundary="===============5122983042283865033=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] provision: allow duplicate apn's from mbpi
Date: Wed, 02 Jan 2019 12:50:53 +0100
Message-ID: <20190102115053.79191-2-martin@geanix.com>
In-Reply-To: <20190102115053.79191-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5122983042283865033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let the user/connection-manager decide what to do with duplicate apn
entries instead of bailing out with an error.
---
 plugins/provision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/provision.c b/plugins/provision.c
index 99c299eb..aa0b05e4 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -50,7 +50,7 @@ static int provision_get_settings(const char *mcc, const =
char *mnc,
 =

 	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
 =

-	apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
+	apns =3D mbpi_lookup_apn(mcc, mnc, TRUE, &error);
 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
 			ofono_error("%s", error->message);
-- =

2.20.1


--===============5122983042283865033==--

