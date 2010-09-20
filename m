Content-Type: multipart/mixed; boundary="===============9012258256162807004=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] doc/fixed-dialing-numbers-api.txt: add
Date: Mon, 20 Sep 2010 20:32:40 +0300
Message-ID: <1285003960-2781-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9012258256162807004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/fixed-dialing-numbers-api.txt |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 doc/fixed-dialing-numbers-api.txt

diff --git a/doc/fixed-dialing-numbers-api.txt b/doc/fixed-dialing-numbers-=
api.txt
new file mode 100644
index 0000000..a985499
--- /dev/null
+++ b/doc/fixed-dialing-numbers-api.txt
@@ -0,0 +1,29 @@
+Fixed Dialing Numbers (FDN) hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.FixedDialing
+Object path	/[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Contains the properties for this object.
+
+		void SetProperty(string property, variant value, string pin2)
+
+			Sets the given property value to that specified
+			in call parameter.  For all properties, the
+			password (SIM PIN2) must be provided.
+
+Signals		PropertyChanged(string property, variant value)
+
+			Signal is emitted whenever a property has changed.
+			The new value is passed as the signal argument.
+
+Properties	boolean Enabled [readwrite]
+
+			True if the Fixed Dialing Numbers feature is
+			enabled.
+
+			On some modems, only the emergency calls are
+			possible if FDN is enabled.
-- =

1.7.0.4


--===============9012258256162807004==--

