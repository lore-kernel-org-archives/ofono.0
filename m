Content-Type: multipart/mixed; boundary="===============4253676907806851795=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 5/5] doc: call counters API doc
Date: Mon, 22 Nov 2010 18:26:13 +0200
Message-ID: <53ed06056f4594ab30c1d562f8e35dae0d2df5e9.1290442823.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1290442823.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4253676907806851795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/callcounters-api.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 doc/callcounters-api.txt

diff --git a/doc/callcounters-api.txt b/doc/callcounters-api.txt
new file mode 100644
index 0000000..271d9f4
--- /dev/null
+++ b/doc/callcounters-api.txt
@@ -0,0 +1,18 @@
+CallCounters hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.CallCounters
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict Get()
+
+			Returns the total duration in seconds of the incoming
+			and outgoing calls. Separate counters are maintained for
+			each SIM card.
+
+		void Clear()
+			Resets the call duration counters to 0. The operation
+			succeeds only if there are no ongoing calls.
+
+			Possible Errors: [service].Error.Failed
-- =

1.7.0.4


--===============4253676907806851795==--

