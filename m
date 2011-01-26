Content-Type: multipart/mixed; boundary="===============8955965543437428611=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFC] doc: Proposal for LTE/IMS API.
Date: Wed, 26 Jan 2011 15:59:03 +0100
Message-ID: <1296053943-18748-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8955965543437428611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>


Features:
- The QoS information is presented as an array of QoS settings with
  an associated list IP Packet Filters. Only the QoS data for
  connection context of type IMS will be reported.

  The assumption is that QoS is only going to be used by IMS applications.
  Initially I was planning to put this in the connman-api.txt, but based
  on feedback from Denis in the Paris workshop I have moved this to the
  IMS API. If this assumption proves wrong QoS should be moved to
  ConnectionContext interface.

  The UE initiates the Default Bearer. In R8, the Network may then
  initiate a number of Dedicated Bearers. Each Dedicated Bearer will
  have a defined QoS. In order to route the IP traffic into the
  different Dedicated Bearers, a set of Packet Filters can be defined
  for each Dedicated Bearer.

- The UE-Mode of operation, is primarily triggered by IMS application
  registering to the RadioStack that it has registered on Voice and/or
  SMS by setting the properties ImsVoiceRegistered or ImsSmsRegistered.

- SIM identities used for IMS registration such as: PrivateImsIdentity,
  PublicImsIdentity, HomeDomainName.

- For SRVCC (IMS to CS handover) the property ImsToCsHandoverStatus
  is added for providing handover progress information. This property
  is currently a little futuristic, but is presented for completeness.

- ImsVoiceOverPs shows if Network supports IMS voice.
---

This is the initial RFC for the LTE/IMS API. Most of this (except
the QoS parts) has been presented in a worshop in Paris.Based on
input in the workshop I have created this new IMS API.

Feedback and comments are welcome :-)
I'm particularly interested to know if anything should be
removed (or added) from the QoS information. I would like to
see if we could do this any simpler.

Regards,
Sjur

 doc/ims-api.txt |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 doc/ims-api.txt

diff --git a/doc/ims-api.txt b/doc/ims-api.txt
new file mode 100644
index 0000000..865413f
--- /dev/null
+++ b/doc/ims-api.txt
@@ -0,0 +1,119 @@
+IMS hierarchy  [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Ims
+Object path	[variable]
+
+Methods		dict GetProperties()
+
+			Returns all global system properties. See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void SetProperty(string property, variant value)
+
+			Sets the property to a desired value
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean ImsVoiceRegistered [readwrite, optional]
+
+			Inform modem's radio stack that the IMS application
+			has registered for Voice over IMS. This impacts
+			"UE Mode of operation" and the ISR feature in the
+			radio stack. Related AT command: AT+EISR
+
+		boolean ImsSmsRegistered [readwrite, optional]
+
+			Inform modem's radio stack that the IMS application
+			has registered for SMS over IMS. This impacts
+			"UE Mode of operation" and the ISR feature in the
+			radio stack. Related AT command: AT+EISR
+
+		boolean ImsVoiceOverPs [readonly, optional]
+
+			IMS voice is enabled by network
+			Related AT command: AT+CIREP.
+
+		string  PrivateImsIdentity [readonly, optional]
+
+			Identity used for IMS registration.
+			Available if present on the ISIM.
+
+		string  PublicImsIdentity [readonly, optional]
+
+			Identity used for IMS registration.
+			Available if present on the ISIM.
+
+		string  HomeDomainName[readonly, optional]
+
+			Identity used for IMS registration.
+			Available if present on the ISIM.
+
+		string  ImsToCsHandoverStatus [readonly, optional]
+
+			Indicate the handover progress status during a CS
+			fallback procedure. This property will only be present
+			when in LTE coverage. The possible values are:
+			"none", "started","complete", "failure".
+			Related AT URC: +CIREP
+
+		array{string}  PcscfAddresses[readonly]
+
+			Domain Name or IP Address of the P-CSCF servers.
+			(SIP Proxy).
+
+		array{dict,array{dict}} QosFilters [readonly, optional]
+
+			Information about the QoSes and associated Packet
+			Filters for the Default PDN and it's dedicated bearers.
+			It is organized as a list of QoS definitions with
+			a list of corresponding packet filters.
+
+				uint8 QoSClassIdentifier [readonly]
+					The numeric parameter that specifying
+					the class of QoS. (3GPP TS 23.203 [85])
+					0	QCI is selected by network
+					[1 =E2=80=93 4] guaranteed bit rate
+					[5 =E2=80=93 9] non-guaranteed bit rate
+
+				uint16 UplinkRate [readonly, optional]
+					Guaranteed Uplink Bit-rate in kb/sec.
+
+				uint16 DownlinkRate [readonly, optional]
+					Guaranteed Downlink Bit-rate in kb/sec.
+
+			For each QoS defined there may be a list of Packet
+			Filters. Each Packet Filter is a dictionary defining
+			the filter. An empty Packet Filter represents the
+			"default" filter (Default PDN connection).
+
+				string Direction [readonly]
+					"uplink", "downlink", "bidirectional"
+
+				uint8 ProtocolNumber [readonly]
+					IP protocol number (0-256)
+
+				string PeerAddress [readonly]
+					The remote peer's IP address.
+
+				uint16 PeerPortMin [readonly]
+					Remote peer's port number min. value
+
+				uint16 PeerPortMax [readonly]
+					Remote peer's port number max. value
+
+				uint16 LocalePortMin [readonly]
+					The local port number min. value
+
+				uint16 LocalPortMax [readonly]
+					The local port number max. value
-- =

1.7.1


--===============8955965543437428611==--

