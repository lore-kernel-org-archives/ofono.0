Content-Type: multipart/mixed; boundary="===============7574276833247477614=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: [PATCH] nokia-gpio: do not create links to gpios in /dev/cmt
Date: Tue, 26 Sep 2017 19:56:07 -0700
Message-ID: <20170927025607.21224-1-clayton@craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7574276833247477614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The nokia-gpio plugin should not try to create symlinks to relevant gpio
pins under /dev/cmt, since the location it is looking is no longer
correct on newer kernels and it might change again in the future. This
patch removes code from nokia-gpio that tries to create a symlink.

Users will now need to symlink the modem gpios to /dev/cmt themselves.
On the 4.13 kernel, this can be done by, for example, adding a udev rule
to:
 # ln -sf /sys/bus/hsi/devices/n900-modem /dev/cmt
---
 plugins/nokia-gpio.c | 67 ++++--------------------------------------------=
----
 1 file changed, 4 insertions(+), 63 deletions(-)

diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index 7a93106c..1d014337 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -632,74 +632,15 @@ static void phonet_status_cb(GIsiModem *idx, enum GIs=
iPhonetLinkState state,
 =

 static int gpio_probe_links(void)
 {
-	char const *gpiodir =3D "/sys/class/gpio";
 	char const *cmtdir =3D "/dev/cmt";
-	DIR *gpio;
-	struct dirent *d;
 =

-	if (file_exists(cmtdir)) {
-		DBG("Using %s", cmtdir);
-		return 0;
-	}
-
-	DBG("Using %s: trying to make links to %s", gpiodir, cmtdir);
-
-	if (!dir_exists(cmtdir)) {
-		if (mkdir(cmtdir, 0755) =3D=3D -1) {
-			DBG("%s: %s", cmtdir, strerror(errno));
-			return -(errno =3D ENODEV);
-		}
-	}
-
-	gpio =3D opendir(gpiodir);
-	if (gpio =3D=3D NULL) {
-		DBG("%s: %s", "gpiodir", strerror(errno));
+	if (!file_exists(cmtdir)) {
+		DBG("%s: %s", cmtdir, strerror(errno));
 		return -(errno =3D ENODEV);
 	}
 =

-	while ((d =3D readdir(gpio)) !=3D NULL) {
-		char nn[PATH_MAX], name[PATH_MAX], from[PATH_MAX], to[PATH_MAX];
-		FILE *nf;
-		size_t len;
-
-		snprintf(nn, sizeof nn, "%s/%s/name", gpiodir, d->d_name);
-
-		nf =3D fopen(nn, "rb");
-		if (nf =3D=3D NULL) {
-			DBG("%s: %s", nn, strerror(errno));
-			continue;
-		}
-
-		len =3D fread(name, sizeof name, 1, nf);
-
-		if (ferror(nf)) {
-			DBG("read from %s: %s", nn, strerror(errno));
-			fclose(nf);
-			continue;
-		}
-
-		fclose(nf);
-
-		if (len < 4)
-			continue;
-
-		name[--len] =3D '\0';
-
-		if (strncmp(name, "cmt_", 4))
-			continue;
-
-		snprintf(from, sizeof from, "%s/%s", gpiodir, d->d_name);
-		snprintf(to, sizeof to, "%s/%s", cmtdir, name);
-
-		if (symlink(from, to) =3D=3D -1)
-			DBG("%s: %s", to, strerror(errno));
-	}
-
-	DBG("%s: %s", "/sys/class/gpio", strerror(errno));
-
-	(void) closedir(gpio);
-
-	return -(errno =3D ENODEV);
+	DBG("Using %s", cmtdir);
+	return 0;
 }
 =

 =

-- =

2.14.1


--===============7574276833247477614==--

