Content-Type: multipart/mixed; boundary="===============2256450475040981536=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Fix a memory leak,
 all dir opened with opendir must be closed with closedir
Date: Wed, 11 May 2011 17:27:43 +0200
Message-ID: <1305127663-6173-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2256450475040981536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/nokia-gpio.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index 3ddf6e1..57aad8d 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -645,7 +645,6 @@ static int gpio_probe_links(void)
 	DBG("Using %s: trying to make links to %s", gpiodir, cmtdir);
 =

 	if (!dir_exists(cmtdir)) {
-
 		if (mkdir(cmtdir, 0755) =3D=3D -1) {
 			DBG("%s: %s", cmtdir, strerror(errno));
 			return -(errno =3D ENODEV);
@@ -663,8 +662,10 @@ static int gpio_probe_links(void)
 		FILE *nf;
 		size_t len;
 =

-		if (d =3D=3D NULL)
+		if (d =3D=3D NULL) {
+			(void) closedir(gpio);
 			return 0;
+		}
 =

 		snprintf(nn, sizeof nn, "%s/%s/name", gpiodir, d->d_name);
 =

@@ -701,6 +702,8 @@ static int gpio_probe_links(void)
 =

 	DBG("%s: %s", "/sys/class/gpio", strerror(errno));
 =

+	(void) closedir(gpio);
+
 	return -(errno =3D ENODEV);
 }
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2256450475040981536==--

