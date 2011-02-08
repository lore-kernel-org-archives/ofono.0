Content-Type: multipart/mixed; boundary="===============8800424761188362730=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFCv2] doc: Proposal for LTE/IMS API
Date: Tue, 08 Feb 2011 15:20:23 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9CB41FD5@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1297175357-28145-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8800424761188362730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,


> +		void Register(string type)
> +
> +			Register a IMS Application. It must register
> +			with one of the types:
> +			"voice", "messaging", "voice_messaging".
> +
> +			This registration will inform modem's radio
> +			stack that the IMS application has registered
> +			for Voice and/or Messaging over IMS.
> +			This registration may impact "UE Mode of operation"
> +			and the ISR feature in the radio stack.
> +
> +			The registered application is tracked, if the
> +			application exits the registration will be
> +			automatically released.
> +
> +			Related AT command: AT+EISR.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +
> +		void UnRegister(object path)
> +
> +			Un-register a IpMultimediaSubsystemAgent.

Register and UnRegister functions are not really symmetric here ...
How object path is used by UnRegister function ??

Maybe we should have :

void UnRegister(string type)

> +
> +			Possible Errors: [service].Error.InvalidArguments
> +
> +		boolean PreConditionCheck(string Type, string PeerAddress,
> +					uint16 PeerPort,  uint16 LocalPort)
> +
> +			This method is used by the IMS application to check
> +			if the QoS SIP precondition is fulfilled.
> +
> +			The IMS application should call this method when
> +			receiving a PreConditionChanged() signal.
> +			The IMS Application is not allowed to start alerting
> +			before it has confirmed that it has a voice-ready
> +			Dedicated Bearer and QoS set up in the network.
> +
> +			The legal parameter for Type currently is currently
> +			"voice" only. In future "video" (Conversational Video,
> +			Live Streaming) will be added.
> +
> +			PeerAddress can be IPv4 or IPv6 address. PeerPort and
> +			LocalPort is the RTP port used for the media stream.
> +
> +			This method returns true if the Traffic Flow Template
> +			read from the modem matches the address information
> +			provided, and the QCI and Bit Rates fulfills the
> +			requirements for the specified type.
> +
> +			Related AT commands: AT+CGEQOSRDP, AT+CGTFTRDP
> +
> +			NOTE:	Should the "Type" parameter be removed?
> +				Maybe IMS-video still is a bit futuristic.
> +

How to make the link between the primary context (or default bearer) activa=
ted by the IMS client , =

and the TFT and QOS.

We can imagine that we have a good QOS / TFT but it doesn't belong to the p=
rimary context (or default bearer) activated by the IMS client.


> +Signals		PropertyChanged(string property, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +		void PreConditionChanged()
> +
> +			This signal is sent when the network has changed
> +			the QoS or Packet Filters for a Bearer.
> +			The IMS application can then check the QoS SIP
> +			preconditions by calling PreConditionCheck().
> +
> +			Only QoS information relevant for IMS will be
> +			signaled, i.e. QCI=3D1 for voice and QCI=3D2 for video.
> +
> +			Related AT commands: AT+CGEREP,
> +			+CGEV: NW ACT, +CGEV: NW MODIFY
> +

Same here , IMS client will be notified for all dedicated bearer ?

I agree with R=C3=A9mi, it 'll be better if we can put QOS/TFT somewhere un=
der primary context.



Regards,
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8800424761188362730==--

