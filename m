Content-Type: multipart/mixed; boundary="===============4139870636425815900=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/6] radio settings: document FastDormancy property
Date: Mon, 25 Oct 2010 16:28:06 +0300
Message-ID: <1288013290-6124-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288013290-6124-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4139870636425815900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/radio-settings-api.txt |   59 ++++++++++++++++++++++++++++++----------=
---
 1 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index f1b91ad..00eca54 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -44,22 +44,45 @@ Properties	string TechnologyPreference [read-write]
 =

 		boolean	FastDormancy [read-write, optional]
 =

-			This property will enable or disable fast
-			dormancy. Fast dormancy refers to UE initiated
-			release of radio resources quickly after a
-			burst of data transfer has ended. Normally,
+			This property will enable or disable the fast
+			dormancy feature in the modem. Fast dormancy
+			refers to a modem feature that allows the
+			modem to quickly release radio resources after
+			a burst of data transfer has ended. Normally,
 			radio resources are released by the network
-			after a timeout configured by the network
-			operator. Fast dormancy allows the modem to
-			release radio resources more quickly.
-			Typically, fast dormancy would be enabled if
-			no data transfer is predicted to occur in the
-			near future, for instance, when the end user
-			is not actively using the device. This is a
-			major power-saving feature for mobile devices,
-			but can be ignored for USB sticks or PCI
-			devices.
-
-			If the modem does not support such a feature
-			the property should never be exposed to the
-			user.
+			after a timeout configured by the network.
+			Fast dormancy allows the modem to release the
+			radio resources more quickly.
+
+			Fast dormancy is a major power-saving feature
+			for mobile devices. Typically, fast dormancy
+			would be enabled when the device is not being
+			interactively used by a human user and only
+			networking applications with keep-alive
+			traffic are active (e.g. mail client or a
+			presence application). In this case it is
+			desirable to release radio resources quickly
+			after a keep-alive transaction has ended,
+			since typically no network traffic will occur
+			until the next keep-alive transaction. Fast
+			dormancy should not be enabled during
+			interactive use because the release and setup
+			of radio resources introduces perceivable
+			delay for the end user.
+
+			The fast dormancy implementation in the modem
+			is vendor specific. The implementation should
+			try to release radio resources more quickly,
+			when the situation allows it, but should also
+			take care not to increase the signalling load
+			on the cellular network by releasing and
+			re-establishing radio resources too often. The
+			modem should adjust its behaviour to the 3GPP
+			release supported by the network and the
+			parameters set by the operator.
+
+			Fast dormancy can be ignored for externally
+			powered modems such as USB sticks or PCI
+			devices. If the modem does not support such a
+			feature the property should never be exposed
+			to the user.
-- =

1.7.0.4


--===============4139870636425815900==--

