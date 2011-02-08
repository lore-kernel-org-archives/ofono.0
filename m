Content-Type: multipart/mixed; boundary="===============1150327080950004553=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFCv2] doc: Proposal for LTE/IMS API
Date: Tue, 08 Feb 2011 15:29:17 +0100
Message-ID: <1297175357-28145-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1150327080950004553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Thanks for lots of useful feedback from last RFC,
here is my next revision on the LTE/IMS API.
Comments are still very much welcome!

Changes from RFC-V1:
	- Renamed IMS to IpMultimediaSubsystem (some places)
	- Changed registration of IMS application.
	- Moved IMS Identities to a separate interface
	- Dropped the entire TFT/QoS info.
	  Instead oFono checks the QoS SIP Preconditions.
	  IMS application is notified about changes in QoS,
	  and asks oFono if the QoS SIP preconditions are
	  satisfied.
---
 doc/ims-api.txt |  162 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 doc/ims-api.txt

diff --git a/doc/ims-api.txt b/doc/ims-api.txt
new file mode 100644
index 0000000..5404e61
--- /dev/null
+++ b/doc/ims-api.txt
@@ -0,0 +1,162 @@
+Ip Multimedia Subsystem hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.IpMultimediaSubsystem
+Object path	[variable prefix]
+
+Methods		dict GetProperties()
+
+			Returns all IMS properties. See the
+			properties section for available properties.
+
+		void Register(string type)
+
+			Register a IMS Application. It must register
+			with one of the types:
+			"voice", "messaging", "voice_messaging".
+
+			This registration will inform modem's radio
+			stack that the IMS application has registered
+			for Voice and/or Messaging over IMS.
+			This registration may impact "UE Mode of operation"
+			and the ISR feature in the radio stack.
+
+			The registered application is tracked, if the
+			application exits the registration will be
+			automatically released.
+
+			Related AT command: AT+EISR.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void UnRegister(object path)
+
+			Un-register a IpMultimediaSubsystemAgent.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		boolean PreConditionCheck(string Type, string PeerAddress,
+					uint16 PeerPort,  uint16 LocalPort)
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
+			PeerAddress can be IPv4 or IPv6 address. PeerPort and
+			LocalPort is the RTP port used for the media stream.
+
+			This method returns true if the Traffic Flow Template
+			read from the modem matches the address information
+			provided, and the QCI and Bit Rates fulfills the
+			requirements for the specified type.
+
+			Related AT commands: AT+CGEQOSRDP, AT+CGTFTRDP
+
+			NOTE:	Should the "Type" parameter be removed?
+				Maybe IMS-video still is a bit futuristic.
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
+			Array of IP Multimedia Identities objects and
+			properties.
+			NOTE:	It is assumed that Identities will not change.
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
+		array{string} PcscfAddresses [readonly]
+
+			Domain Name or IP Address of the SIP Proxy.
+			The P-CSCF address returned in EPS signaling as
+			as part of the Default Bearer setup will be used.
+			The addresses may be of type IPv4 and/or IPv6.
+			If no P-CSCF data is available the information from
+			EFp-cscf will be used.
+
+			Related AT command: AT+CGCONTRDP
+
+			NOTE:	If an operator can have more than one
+				IMS-APN with different set of pcscf servers,
+				this property must be moved to the
+				ConnectionContext object.
+
+IP Multimedia Identities hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.IpMultimediaIdentities
+Object path	[variable prefix]
+
+
+Methods		dict GetProperties()
+
+			Returns all IMS identitiy properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+			NOTE:	No PropertyChanged signal is supported.
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
-- =

1.6.3.3


--===============1150327080950004553==--

