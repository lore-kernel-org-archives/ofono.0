Content-Type: multipart/mixed; boundary="===============4032491016278045911=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 07/24] sap: add support to open the channel for SAP data
Date: Tue, 13 Sep 2011 15:58:15 -0300
Message-ID: <1315940312-1238-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-6-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4032491016278045911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 1658b75..20df890 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -46,6 +46,7 @@ struct bluetooth_profile {
 struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem);
+	int (*open) (struct ofono_modem *modem);
 };
 =

 struct server;
diff --git a/plugins/telit.c b/plugins/telit.c
index 1f950aa..69f9eed 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -27,6 +27,9 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -134,7 +137,31 @@ static void rsen_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
+}
+
+static int telit_sap_open(struct ofono_modem *modem)
+{
+	const char *device =3D "/dev/ttyUSB4";
+	struct termios ti;
+	int fd;
+
+	DBG("%s", device);
+
+	fd =3D open(device, O_RDWR | O_NOCTTY | O_NONBLOCK);
+	if (fd < 0)
+		return -1;
+
+	/* Switch TTY to raw mode */
+	memset(&ti, 0, sizeof(ti));
+	cfmakeraw(&ti);
+
+	tcflush(fd, TCIOFLUSH);
+	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+		close(fd);
+		return -EBADF;
+	}
 =

+	return fd;
 }
 =

 static int telit_sap_enable(struct ofono_modem *modem)
@@ -162,6 +189,7 @@ static int telit_sap_enable(struct ofono_modem *modem)
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
+	.open =3D telit_sap_open,
 };
 =

 static int telit_probe(struct ofono_modem *modem)
-- =

1.7.6.2


--===============4032491016278045911==--

