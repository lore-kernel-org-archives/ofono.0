Content-Type: multipart/mixed; boundary="===============6300765084396244029=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] devinfo: Add support of IMEISV
Date: Thu, 31 Mar 2016 13:16:19 +0530
Message-ID: <1459410379-2039-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6300765084396244029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 9fd23ba..c0a575f 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -90,6 +90,11 @@ Properties	boolean Powered [readwrite]
 			"hfp") this corresponds to the Bluetooth Device
 			Address of the remote device.
 =

+		string SoftwareVersionNumber [readonly, optional]
+
+			String representing the software version number of the
+			modem device.
+
 		array{string} Features [readonly]
 =

 			List of currently enabled features. It uses simple
-- =

1.9.1


--===============6300765084396244029==--

