Content-Type: multipart/mixed; boundary="===============8695073174819657752=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 6/9] doc: add lte atom documentation
Date: Wed, 09 Nov 2016 18:43:19 +0100
Message-ID: <1478713402-30780-7-git-send-email-dragos@endocode.com>
In-Reply-To: <1478713402-30780-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8695073174819657752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/lte-api.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 doc/lte-api.txt

diff --git a/doc/lte-api.txt b/doc/lte-api.txt
new file mode 100644
index 0000000..dfefaf4
--- /dev/null
+++ b/doc/lte-api.txt
@@ -0,0 +1,35 @@
+LTE Hierarchy
+
+Service		org.ofono
+Interface	org.ofono.LTE
+Object path	[variable prefix]/{modem0,modem1,...}
+
+
+Methods		dict GetProperties()
+
+			Returns all LTE configuration properties.
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
+					 [service].Error.Failed
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string DefaultAPN [readwrite]
+
+			On LTE, contexts activate automatically. This property
+			allows selection of an APN to be used on next
+			automatic activation.
+
+			Setting this property to an empty string clears the
+			default APN from the modem.
-- =

2.7.4


--===============8695073174819657752==--

