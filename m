Content-Type: multipart/mixed; boundary="===============3241844612932414720=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] doc: Add SystemPath to Modem interface
Date: Tue, 20 Feb 2018 09:57:18 +0100
Message-ID: <1519117038-21713-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1c57e6cd-6c6c-b21e-8030-0213cbaf3d7f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3241844612932414720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 89e6191..ff9facd 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -95,6 +95,13 @@ Properties	boolean Powered [readwrite]
 			String representing the software version number of the
 			modem device.
 =

+		string SystemPath [readonly, optional]
+
+			String representing the system path for the modem
+			device.
+			For modems detected by udev events, this corresponds to
+			the modem sysfs path.
+
 		array{string} Features [readonly]
 =

 			List of currently enabled features. It uses simple
-- =

2.7.4


--===============3241844612932414720==--

