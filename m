Content-Type: multipart/mixed; boundary="===============6421936030555281478=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 3/3] doc: Add SystemPath to Modem interface
Date: Mon, 19 Feb 2018 15:57:14 +0100
Message-ID: <1519052234-13973-4-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1519052234-13973-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6421936030555281478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 89e6191..e03c64a 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -95,6 +95,14 @@ Properties	boolean Powered [readwrite]
 			String representing the software version number of the
 			modem device.
 =

+		string SystemPath [readonly, optional]
+
+			String giving a consistent hardware path for the modem
+			device. It will not change in case of reboot of modem
+			or ofono.
+			For modems detected by udev events, gives modem sysfs
+			path.
+
 		array{string} Features [readonly]
 =

 			List of currently enabled features. It uses simple
-- =

2.7.4


--===============6421936030555281478==--

