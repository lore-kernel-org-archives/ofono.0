Content-Type: multipart/mixed; boundary="===============6045293905191770397=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFCv3] doc: Proposal for LTE/IMS API
Date: Thu, 10 Feb 2011 23:33:54 +0100
Message-ID: <1297377234-5056-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6045293905191770397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

With latest changes the P-CSCF addresses from ISIM can be read
from the IpMultimediaIdentity objects and the P-CSCF addresses
returned as dynamic parameters for the PDN Connection are avilable
in the ConnectionContext object.

I have also added LocalAddress to the IMS QoS SIP PreCondiction check.
The Local IP address identifies the APN, so that PreCondition check
in effect can be done per IMS APN.

Changes from RFC-v2:
	- Moved P-CSCF addresses to the IpMultimediaIdentity object
	- Fixed object path descriptions
	- IMS Registration types is now an array of strings
	- Fixed bad parameters to UnRegister
	- Added LocalAddress to PreConditionCheck
	- Added P-CSCF addresses to the ConnectionContext object
---
 doc/connman-api.txt |   18 ++++++
 doc/ims-api.txt     |  148 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 doc/ims-api.txt

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22c59dc..314c018 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -249,3 +249,21 @@ Properties	boolean Active [readwrite]
 		string MessageCenter [readwrite, MMS only]
 =

 			Holds the MMSC setting.
+
+		array{string} PcscfAddresses [readonly,optional]
+
+			For ConnectionContext with Type =3D "ims" this
+			property holds the Domain Names or IP Addresses
+			of the SIP Proxy, called "Proxy Call Session Control
+			Function" (P-CSCF).
+
+			The P-CSCF addresses are returned in EPS signaling as
+			part of the Default Bearer setup for the IMS APN. The
+			addresses may be of type IPv4 and/or IPv6.
+
+			Related AT command: AT+CGCONTRDP
+
+			NOTE:	The P-CSCF addresses read from ISIM, is
+				available in the IpMultimediaIdentity
+				object. It is up to the IMS application to
+				choose the P-CSCF to use.
diff --git a/doc/ims-api.txt b/doc/ims-api.txt
new file mode 100644
index 0000000..9030457
--- /dev/null
+++ b/doc/ims-api.txt
@@ -0,0 +1,148 @@
+Ip Multimedia Subsystem hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.IpMultimediaSubsystem
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all IMS properties. See the
+			properties section for available properties.
+
+		void Register(array{string} types)
+
+			Registers an IMS Application. It must register
+			with at least one of the types: "voice" or "messaging".
+			In future "video" (Conversational Video, Live
+			Streaming) should be added. This registration will
+			inform the modem's radio stack that the IMS application
+			has registered for Voice and/or Messaging over IMS.
+			This registration may impact "UE Mode of operation"
+			and the ISR feature in the radio stack.
+
+			The registered application is tracked, if the
+			application exits the registration will be
+			automatically released.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void UnRegister()
+
+			Un-registers a previously registered IMS application.
+
+		boolean PreConditionCheck(string Type, string PeerAddress,
+					uint16 PeerPort, string LocalAddress,
+					uint16 LocalPort)
+
+			This method is used by the IMS application to check
+			if the QoS SIP precondition is fulfilled.
+
+			The IMS application should call this method when
+			receiving a PreConditionChanged() signal.
+			The IMS Application is not allowed to start alerting
+			before it has confirmed that it has a voice-ready
+			Dedicated Bearer and QoS set up in the network.
+
+			The legal parameter for Type currently is currently
+			"voice" only. In future "video" (Conversational Video,
+			Live Streaming) will be added.
+
+			PeerAddress and LocalAddress can be IPv4 or IPv6
+			address. PeerPort and LocalPort is the RTP port
+			used for the media stream.
+
+			This method returns true if the Traffic Flow Template
+			read from the modem matches the address information
+			provided, and the QCI and Bit Rates fulfills the
+			requirements for the specified Type.
+
+			Related AT commands: AT+CGEQOSRDP, AT+CGTFTRDP
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		void PreConditionChanged()
+
+			This signal is sent when the network has changed
+			the QoS or Packet Filters for a Bearer.
+			The IMS application can then check the QoS SIP
+			preconditions by calling PreConditionCheck().
+
+			Only QoS information relevant for IMS will be
+			signaled, i.e. QCI=3D1 for voice and QCI=3D2 for video.
+
+			Related AT commands: AT+CGEREP,
+			+CGEV: NW ACT, +CGEV: NW MODIFY
+
+Properties
+		array{object} Identities [readonly]
+
+			Array of IP Multimedia Services Identity Module
+			(ISIM) objects.
+
+		boolean VoiceOverPs [readonly]
+
+			IMS voice is enabled by network
+			Related AT command: AT+CIREP.
+
+		string CsHandoverProgress [readonly, optional]
+
+			Indicates the handover progress status during a CS
+			fallback procedure. The possible values are:
+				"started"  - CS Fallback procedure has started
+				"complete" - CS Fallback procedure has completed
+				"failure"  - CS Fallback has failed
+				"idle"     - No CS call or fallback is ongoing
+
+			Related AT URC: +CIREP
+
+IP Multimedia Identity hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+Service		org.ofono
+Interface	org.ofono.IpMultimediaIdentity
+Object path	[variable prefix]/{modem0,modem1,...}/{isim0, isim1, ...}
+
+Methods		dict GetProperties()
+
+			Returns ISIM properties relevant for IMS.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+			NOTE:	No PropertyChanged signal is provided.
+				Technically it is possible for provisioning
+				to update these identities, but 3gpp TS31.103
+				discourages this.
+
+Properties	string PrivateIdentity [readonly]
+
+			The Private Identity is used to allow the UE access
+			to the IMS network (registration, authorization,
+			administration and billing).
+
+		array{string} PublicIdentity [readonly]
+
+			The Public Identity is used to identify a specific
+			IMS user (there may be more than one associated
+			with one Private Identity). This information is conveyed
+			to the IMS Network during registration so that the
+			network can know what IMS users that are registered and
+			available for service (e.g. a reception of a voice
+			session).
+
+		string HomeDomainName[readonly]
+
+			Identity used for IMS registration.
+
+		array{string} PcscfAddresses [readonly]
+
+			Domain Names or IP Addresses of the SIP Proxy,
+			called "Proxy Call Session Control Function" (P-CSCF).
+			The P-CSCF addresses is read from the EFp-cscf SIM
+			record. The addresses may be of type IPv4 and/or IPv6.
+
+			NOTE:	P-CSCF addresses are also provided in the
+				ConnectionContext API. It is up to the IMS
+				application to choose the P-CSCF to use.
-- =

1.7.0.4


--===============6045293905191770397==--

