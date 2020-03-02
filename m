Content-Type: multipart/mixed; boundary="===============4041292969641909401=="
MIME-Version: 1.0
From: Nicola Lunghi <nick83ola@gmail.com>
Subject: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Mon, 02 Mar 2020 16:31:37 +0000
Message-ID: <20200302163136.19369-1-nick83ola@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4041292969641909401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

if the mobile provider information database has multiple apn settings for t=
he
same operator, ofono was throwing an error and creating a default internet
context with an empty apn.

This patch will instead allow the automatic creation of multiple context
allowing the user to pick one of the default via connman.

Connman supports multiple cellular context so no issue there.

Previously proposed by Martin Hundeb=C3=B8ll here:
https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46PH5CW=
T3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D

And tested by Nicola Lunghi with connman 1.37

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
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

--===============4041292969641909401==--

