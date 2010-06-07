Content-Type: multipart/mixed; boundary="===============8082251111581605130=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH] huawei: show used tty devices in the debug log
Date: Mon, 07 Jun 2010 14:26:29 +0300
Message-ID: <20100607112629.10045.27642.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8082251111581605130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handy when debugging udev problems.
---
 plugins/huawei.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 9e50288..63dd06a 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -201,11 +201,11 @@ static int huawei_enable(struct ofono_modem *modem)
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	const char *modem_device, *event_device;
 =

-	DBG("%p", modem);
-
 	modem_device =3D ofono_modem_get_string(modem, "Device");
 	event_device =3D ofono_modem_get_string(modem, "SecondaryDevice");
 =

+	DBG("%p modem %s event %s", modem, modem_device, event_device);
+
 	if (modem_device =3D=3D NULL || event_device =3D=3D NULL)
 		return -EINVAL;
 =



--===============8082251111581605130==--

