Content-Type: multipart/mixed; boundary="===============1165632284230109410=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 2/4] dundee: Add Serial and Type documantation
Date: Tue, 05 Jun 2012 15:48:17 +0200
Message-ID: <1338904099-13612-3-git-send-email-wagi@monom.org>
In-Reply-To: <1338904099-13612-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1165632284230109410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 doc/dundee-api.txt |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/dundee-api.txt b/doc/dundee-api.txt
index 9f4cfe6..8c79124 100644
--- a/doc/dundee-api.txt
+++ b/doc/dundee-api.txt
@@ -74,3 +74,15 @@ Properties	string Name [readonly]
 =

 				Holds the list of domain name servers for this
 				connection.
+
+		string Serial [readonly, optional]
+
+			String represeting the serial number of the modem
+			device.
+
+		string Type [readonly]
+
+			Indicates whether the device is a Bluetooth or
+			USB based one.
+
+			Possible values are "blueooth" or "usb".
-- =

1.7.10.130.g36e6c


--===============1165632284230109410==--

