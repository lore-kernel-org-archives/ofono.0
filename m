Content-Type: multipart/mixed; boundary="===============1519076262100493190=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/3] network: Use bit as size instead of byte
Date: Thu, 25 Nov 2010 20:29:00 +0800
Message-ID: <1290688142-14726-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1290688142-14726-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1519076262100493190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index d203bee..83014bb 100644
--- a/src/network.c
+++ b/src/network.c
@@ -129,7 +129,7 @@ static char **network_operator_technologies(struct netw=
ork_operator_data *opd)
 	char **techs;
 	unsigned int i;
 =

-	for (i =3D 0; i < sizeof(opd->techs); i++) {
+	for (i =3D 0; i < sizeof(opd->techs) * 8; i++) {
 		if (opd->techs & (1 << i))
 			ntechs +=3D 1;
 	}
@@ -137,7 +137,7 @@ static char **network_operator_technologies(struct netw=
ork_operator_data *opd)
 	techs =3D g_new0(char *, ntechs + 1);
 	ntechs =3D 0;
 =

-	for (i =3D 0; i < sizeof(opd->techs); i++) {
+	for (i =3D 0; i < sizeof(opd->techs) * 8; i++) {
 		if (!(opd->techs & (1 << i)))
 			continue;
 =

-- =

1.7.2.3


--===============1519076262100493190==--

