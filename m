Content-Type: multipart/mixed; boundary="===============2182722112648640849=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH] dundee: disconnect bluetooth link in case dial fails
Date: Mon, 13 Aug 2012 18:52:06 -0300
Message-ID: <1344894726-19836-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2182722112648640849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If the ATD*99# dial fails for some reason, NO CARRIER, for example, we
need to disconnect the bluetooth link and do further clean up on
disconnect_callback().
---
 dundee/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dundee/device.c b/dundee/device.c
index 709919a..5126071 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -357,6 +357,8 @@ err:
 	__ofono_dbus_pending_reply(&device->pending,
 				__dundee_error_failed(device->pending));
 	device->pending =3D NULL;
+
+	device->driver->disconnect(device, disconnect_callback, device);
 }
 =

 static int device_dial_setup(struct dundee_device *device, int fd)
-- =

1.7.11.2


--===============2182722112648640849==--

