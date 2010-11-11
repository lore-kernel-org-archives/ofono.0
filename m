Content-Type: multipart/mixed; boundary="===============1205950789181438386=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] doc: Add Location Services API
Date: Thu, 11 Nov 2010 20:44:45 +0100
Message-ID: <1289504685-9134-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1205950789181438386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

As requested, this is our initial proposal for a minimal API
in order to support E911, based on the 27.007 defined AT
commands.

We've discussed internally different names for this API:
AGNSSManager or AssistedGlobalNavigationSatelliteSystem,
but ended up with the simpler LocationServicesManager.

Looking forward to your comments on this API.

Regards,
Simon Lethbridge and
Sjur Br=C3=A6ndeland
---
 doc/location-services-api.txt |   56 +++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 doc/location-services-api.txt

diff --git a/doc/location-services-api.txt b/doc/location-services-api.txt
new file mode 100644
index 0000000..18ef230
--- /dev/null
+++ b/doc/location-services-api.txt
@@ -0,0 +1,56 @@
+LocationServicesManager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service	org.ofono
+Interface	org.ofono.LocationServicesManager
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods	dict GetProperties()
+
+			Returns properties for the modem object. See
+			the properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+
+		void SendPositioningControl(string xml_element)
+
+			Send an XML element conforming to the XML DTD for <pos>
+			as defined in 3GPP 27.007 Table 8.55-2.  This xml is
+			used for transferring data associated with positioning
+			requests received via control plane from the network.
+			This includes assistance data requests and the results
+			of positioning procedures. This method maps directly to
+			the 3GPP 27.007 AT+CPOS command.
+
+
+Signals	PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		PositioningRequest(string xml_element)
+
+			Receive an XML element conforming to the XML DTD for
+			<pos> in 3GPP 27.007. This xml is used for transferring
+			data associated with positioning requests received, via
+			control plane, from the network. This includes
+			measurement requests and assistance data. This signal
+			maps directly to the 3GPP defined +CPOSR unsolicited
+			result code.
+
+Properties	boolean NetworkInitiatedProceduresEnabled [readwrite]
+
+			If NetworkInitiatedProceduresEnabled is False, then
+			no Position Requests from the network are accepted.
+			The modem is not enabled for positioning requests
+			from the networks view point.
-- =

1.6.3.3


--===============1205950789181438386==--

