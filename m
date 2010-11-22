Content-Type: multipart/mixed; boundary="===============3602700243731428705=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Mon, 22 Nov 2010 16:11:47 +0100
Message-ID: <1290438707-10896-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289504685-9134-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3602700243731428705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Simon Lethbridge <simon.lethbridge@stericsson.com>

This is our second proposal for the Assisted Satellite Navigation API,
this time including an Agent API. Hopefully most of the review comments
on our last proposal are included here.

As you can see we have changed the name again, this time to
"Assisted Satellite Navigation".

Feedback is appreciated.
---
 doc/assisted-sattelite-navigation.txt |   56 +++++++++++++++++++++++++++++=
++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 doc/assisted-sattelite-navigation.txt

diff --git a/doc/assisted-sattelite-navigation.txt b/doc/assisted-sattelite=
-navigation.txt
new file mode 100755
index 0000000..6c85a7f
--- /dev/null
+++ b/doc/assisted-sattelite-navigation.txt
@@ -0,0 +1,56 @@
+AssistedSatelliteNavigation hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.AssistedSatelliteNavigation
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		void SendPositioningControl(string xml_element)
+
+			Send an XML element conforming to the XML DTD for <pos>
+			as defined in 3GPP 27.007 Table 8.55-2. This xml is
+			used for transferring data associated with positioning
+			requests received via control plane from the network.
+			This includes assistance data requests and the results
+			of positioning procedures. This method maps directly to
+			the 3GPP 27.007 AT+CPOS command.
+
+		void RegisterPositioningRequestAgent(object path)
+
+			Registers an agent which will be called whenever a
+			CPOSR AT response is received. The Agent must respond
+			to requests using SendPositioningControl.
+
+		void UnregisterPositioningRequestAgent(object path)
+
+			Unregisters the agent.
+
+PositioningRequestAgent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.PositioningRequestAgent
+Object path	freely definable
+
+Methods	void PositioningRequest(string xml_element)
+
+			Receive an XML element conforming to the XML DTD for
+			<pos> in 3GPP 27.007. This xml is used for transferring
+			data associated with positioning requests received, via
+			control plane, from the network. This includes
+			measurement requests and assistance data. This method
+			maps directly to the 3GPP defined +CPOSR unsolicited
+			result code.
+
+		void AssistanceDataReset()
+
+			A request has been received from the network that all
+			assistance data should be reset.  This is used for 3gpp
+			performance tests.
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, AssistedSatelliteNavigation interface
+			is being torn down or modem off.
+			No UnregisterAgent call is needed.
-- =

1.6.3.3


--===============3602700243731428705==--

