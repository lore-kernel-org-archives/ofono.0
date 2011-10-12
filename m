Content-Type: multipart/mixed; boundary="===============3978866535537432468=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 04/19] doc: Add initial Handsfree API documentation
Date: Wed, 12 Oct 2011 14:35:25 +0200
Message-ID: <1318422940-14955-5-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3978866535537432468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These basic features have already been implemented.
---
 doc/handsfree-api.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 doc/handsfree-api.txt

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
new file mode 100644
index 0000000..4b2b156
--- /dev/null
+++ b/doc/handsfree-api.txt
@@ -0,0 +1,30 @@
+Handsfree hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Handsfree
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the Handsfree Interface. See the
+			properties section for available properties.
+
+		void SetProperty(string property, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as readwrite are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+
+Signals		PropertyChanged(string property, variant value)
+
+			Signal is emitted whenever a property has changed.
+			The new value is passed as the signal argument.
+
+Properties	boolean InbandRinging [readonly]
+
+			Boolean representing whether inband ringing is enabled.
-- =

1.7.6.4


--===============3978866535537432468==--

