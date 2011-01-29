Content-Type: multipart/mixed; boundary="===============7721168837116314097=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv2] doc: Assisted Satellite Navigation API and Agent API
Date: Sun, 30 Jan 2011 00:44:43 +0100
Message-ID: <1296344683-7967-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <201101281413.06172.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7721168837116314097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Simon Lethbridge <simon.lethbridge@stericsson.com>

This patch introduces support for Global Satellite Navigation System (GNSS),
using the AT commands AT+CPOS and +CPOSR as specified 3GPP 27.007.
---

Changes from v1 (28 Jan):
s/SendPositioningControl/SendPositioningElement/

Thanks R=C3=A9mi, for spotting this one,


Changes from RFCv2 (Nov 22):
>Hi Denis,
>
>2010/11/30 Denis Kenzior <denkenz@gmail.com>:
>>> +AssistedSatelliteNavigation hierarchy
>>What do you think of naming this AssistedNavigation?  I think the
>>current name might be a bit too long.
>
>See mail previous mail on this topic, I think we'd like to keep
>it as is for now.
>
>>> +Methods              void SendPositioningControl(string xml_element)
>>What do you think of SendPositioningElement?
>
>Fixed,
>
>>> +Methods      void PositioningRequest(string xml_element)
>>I think that 'Request' will be sufficient.  Positioning is already part
>>of the agent name.
>
>Fixed,
>
>>> +             void AssistanceDataReset()
>>I suggest ResetAssistanceData here.
>Fixed,
>
>>The only other change I'd make is to mark the entire interface
>>'experimental', but I can take care of that as well.
>
>Fixed,
>
>>Otherwise the proposal looks good to me.
>
>Sorry for taking so long before responding on this.
>Let us know if you have any issues with this patch.

Regards,
Sjur and Simon.

 doc/assisted-sattelite-navigation.txt |   56 +++++++++++++++++++++++++++++=
++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 doc/assisted-sattelite-navigation.txt

diff --git a/doc/assisted-sattelite-navigation.txt b/doc/assisted-sattelite=
-navigation.txt
new file mode 100644
index 0000000..c5a8c10
--- /dev/null
+++ b/doc/assisted-sattelite-navigation.txt
@@ -0,0 +1,56 @@
+Assisted Satellite Navigation hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.AssistedSatelliteNavigation
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		void SendPositioningElement(string xml_element)
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
+			to requests using SendPositioningElement.
+
+		void UnregisterPositioningRequestAgent(object path)
+
+			Un-registers the agent.
+
+PositioningRequestAgent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.PositioningRequestAgent
+Object path	freely definable
+
+Methods		void Request(string xml_element)
+
+			Receive an XML element conforming to the XML DTD for
+			<pos> in 3GPP 27.007. This xml is used for transferring
+			data associated with positioning requests received, via
+			control plane, from the network. This includes
+			measurement requests and assistance data. This method
+			maps directly to the 3GPP defined +CPOSR unsolicited
+			result code.
+
+		void ResetAssistanceData()
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
+			No UnregisterPositioningRequestAgent call is needed.
-- =

1.7.0.4


--===============7721168837116314097==--

