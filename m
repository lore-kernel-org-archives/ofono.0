Content-Type: multipart/mixed; boundary="===============5224196270042615432=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 4/4] SetProperty for UseDeliveryReports. send-sms.
Date: Mon, 07 Jun 2010 12:53:29 +0300
Message-ID: <1275904409-19829-5-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275904409-19829-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5224196270042615432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-sms |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/test/send-sms b/test/send-sms
index 8024fda..4f1d658 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -15,4 +15,10 @@ path =3D properties["Modems"][0]
 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.SmsManager')
 =

-manager.SendMessage(sys.argv[1], sys.argv[2])
+if len(sys.argv) =3D=3D 4:
+	if sys.argv[3] =3D=3D "1":
+		manager.SetProperty("UseDeliveryReports", dbus.Boolean(1))
+		manager.SendMessage(sys.argv[1], sys.argv[2])
+else:
+	manager.SetProperty("UseDeliveryReports", dbus.Boolean(0))
+	manager.SendMessage(sys.argv[1], sys.argv[2])
-- =

1.6.0.4



--===============5224196270042615432==--

