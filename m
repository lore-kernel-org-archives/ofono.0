Content-Type: multipart/mixed; boundary="===============7213818571560481460=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 3/4] udev: Recognize ublox serial modems
Date: Fri, 31 May 2019 14:44:20 +0300
Message-ID: <20190531114421.21092-4-philippe.deswert@digitalistgroup.com>
In-Reply-To: <20190531114421.21092-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7213818571560481460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Call the serial modem setup method for ublox modems that are
connected to a serial port instead of USB.
---
 plugins/udevng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4b420dc0..0d475da0 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1063,8 +1063,15 @@ static gboolean setup_ublox(struct modem_info *modem)
 	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
 	GSList *list;
 =

+
 	DBG("%s", modem->syspath);
 =

+	if(strstr(modem->syspath, "serial"))
+	{
+		setup_serial_modem(modem);
+		return TRUE;
+	}
+
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-- =

2.20.1


--===============7213818571560481460==--

