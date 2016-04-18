Content-Type: multipart/mixed; boundary="===============2588854650813956170=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 2/3] plugins/nokia-gpio: fix glibc 2.23.9+ issues
Date: Mon, 18 Apr 2016 13:45:35 +0200
Message-ID: <1460979936-18296-2-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1460979936-18296-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2588854650813956170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kuba Pawlak <kuba.t.pawlak@gmail.com>

readdir_r=E2=80=99 is deprecated [-Werror=3Ddeprecated-declarations]
---
 plugins/nokia-gpio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index 57aad8d0962a41c1e1b41579d046f3a0e4d28096..7a93106c02c2435d5a1920cbfbc=
9a862ebd192e3 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -635,7 +635,7 @@ static int gpio_probe_links(void)
 	char const *gpiodir =3D "/sys/class/gpio";
 	char const *cmtdir =3D "/dev/cmt";
 	DIR *gpio;
-	struct dirent *d, entry[1];
+	struct dirent *d;
 =

 	if (file_exists(cmtdir)) {
 		DBG("Using %s", cmtdir);
@@ -657,16 +657,11 @@ static int gpio_probe_links(void)
 		return -(errno =3D ENODEV);
 	}
 =

-	while (readdir_r(gpio, entry, &d) =3D=3D 0) {
+	while ((d =3D readdir(gpio)) !=3D NULL) {
 		char nn[PATH_MAX], name[PATH_MAX], from[PATH_MAX], to[PATH_MAX];
 		FILE *nf;
 		size_t len;
 =

-		if (d =3D=3D NULL) {
-			(void) closedir(gpio);
-			return 0;
-		}
-
 		snprintf(nn, sizeof nn, "%s/%s/name", gpiodir, d->d_name);
 =

 		nf =3D fopen(nn, "rb");
-- =

1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

--===============2588854650813956170==--

