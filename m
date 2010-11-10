Content-Type: multipart/mixed; boundary="===============1209494577781966336=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [RFC v2 1/3] doc: addidng documentation for basic assisted gps
Date: Wed, 10 Nov 2010 11:43:12 -0800
Message-ID: <1289418194-2905-3-git-send-email-robertino.benis@intel.com>
In-Reply-To: <1289418194-2905-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1209494577781966336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/assistedgps-manager-api.txt |  107 +++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 doc/assistedgps-manager-api.txt

diff --git a/doc/assistedgps-manager-api.txt b/doc/assistedgps-manager-api.=
txt
new file mode 100644
index 0000000..da0696c
--- /dev/null
+++ b/doc/assistedgps-manager-api.txt
@@ -0,0 +1,107 @@
+AssistedPositioning Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+	The purpose of this interface is to support Control Plane Assisted GPS by=
 transparently
+	relaying positioning related information between the mobile network and a=
 positioning engine.
+	The positioning information is relayed in the form of raw RRLP or RRC PDU=
s as defined by
+	3GPP TS 04.31 and 3GPP TS 25.331.
+
+Service		org.ofono
+Interface	org.ofono.ModemIFX.AssistedPositioning
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
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
+		void SendFrame(string frametype, array{byte} framedata)
+
+			Send a position protocol frame to the Mobile
+			Network. The frame typically represents a
+			Position Response.
+
+			Valid frametypes are:
+				rrlp_measure_position_response
+				rrc_measurement_report
+
+		dict RequestFineTimeInjection(string rat, uint16 pulselength)
+
+			Request modem to generate a fine time injection
+			pulse. pulselength is the duration of the pulse
+			expressed in radio frames.
+
+			rat specifies the access technology used to derive
+			the pulse from and can be "gsm" or "umts".
+			If the requested access technology is not currently
+			in use an error is returned.
+
+			The radioframenumber dict is defined as follow:
+
+			string AccessTechnology
+				"gsm" or "umts"
+
+			uint32 TdmaFrameNumber (gsm only)
+				range 0 - 2715647 (2048*26*51)
+
+			uint16 TdmaTimeslot (gsm only)
+				range 0 - 7
+
+			uint16 TimeslotBit (gsm only)
+				range 0 - 156
+
+			uint16 TimingAdvance (gsm only)
+				range 0 - 63
+
+			uint16 BcchArfcn (gsm only)
+				range 0 - 1023
+
+			uint16 Bsic (gsm only)
+				range 0 - 64
+
+			uint16 Sfn (umts only)
+				range 0 - 4095
+
+			string RrcState (umts only)
+				"cell_dch", "cell_fach", "cell_pch" or
+				"ura_pch"
+
+			uint16 RoundTripTime (umts only)
+				range 0 - 32766
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		IncomingFrame(string frametypes, string framedata)
+
+			Positioning protocol frame received from the
+			Mobile Network.
+
+			Valid frametypes for the positioning frame are:
+				rrlp_assistance_data
+				rrlp_measure_position_request
+				rrc_assistance_data_delivery
+				rrc_measurement_control
+
+			Note that position/measurement requests can include
+			assistance data as well.
+
+Properties	boolean Enabled [readwrite]
+
+			The AssistedPositioning service is disabled by default.
+			After a client registers to listen for the IncomingFrame signal it
+			must enable the service to receive positioning information.
-- =

1.7.0.4


--===============1209494577781966336==--

