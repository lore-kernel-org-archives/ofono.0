Content-Type: multipart/mixed; boundary="===============2996904096001762692=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/4] radio settings: document FastDormancy property
Date: Thu, 07 Oct 2010 16:21:57 +0300
Message-ID: <1286457718-9051-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1286457718-9051-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2996904096001762692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/radio-settings-api.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index 3372abd..f1b91ad 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -41,3 +41,25 @@ Properties	string TechnologyPreference [read-write]
 				"gsm"	Only GSM used for radio access.
 				"umts"	Only UMTS used for radio access.
 				"lte"	Only LTE used for radio acccess.
+
+		boolean	FastDormancy [read-write, optional]
+
+			This property will enable or disable fast
+			dormancy. Fast dormancy refers to UE initiated
+			release of radio resources quickly after a
+			burst of data transfer has ended. Normally,
+			radio resources are released by the network
+			after a timeout configured by the network
+			operator. Fast dormancy allows the modem to
+			release radio resources more quickly.
+			Typically, fast dormancy would be enabled if
+			no data transfer is predicted to occur in the
+			near future, for instance, when the end user
+			is not actively using the device. This is a
+			major power-saving feature for mobile devices,
+			but can be ignored for USB sticks or PCI
+			devices.
+
+			If the modem does not support such a feature
+			the property should never be exposed to the
+			user.
-- =

1.7.0.4


--===============2996904096001762692==--

