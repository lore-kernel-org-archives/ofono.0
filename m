Content-Type: multipart/mixed; boundary="===============0785955248673687695=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 09:50:18 +0200
Message-ID: <201101270950.18685.remi.denis-courmont@nokia.com>
In-Reply-To: <1296053943-18748-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0785955248673687695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Hello,

On Wednesday 26 January 2011 16:59:03 ext Sjur Br=C3=A6ndeland, you wrote:
> Features:
> - The QoS information is presented as an array of QoS settings with
>   an associated list IP Packet Filters. Only the QoS data for
>   connection context of type IMS will be reported.
> =

>   The assumption is that QoS is only going to be used by IMS applications.
>   Initially I was planning to put this in the connman-api.txt, but based
>   on feedback from Denis in the Paris workshop I have moved this to the
>   IMS API. If this assumption proves wrong QoS should be moved to
>   ConnectionContext interface.

What is this for? In my understanding, the LTE modem will do the classifica=
tion =

on outgoing packets - not the application engine. Indeed, based on the =

proposed API, there is no way for the application engine to tag packet for =
the =

benefit of the modem...

And we do not need to know anything about classification of incoming packet=
s, =

other than which primary context they belong to.

(...)
> +Properties	boolean ImsVoiceRegistered [readwrite, optional]
> +
> +			Inform modem's radio stack that the IMS application
> +			has registered for Voice over IMS. This impacts
> +			"UE Mode of operation" and the ISR feature in the
> +			radio stack. Related AT command: AT+EISR

I suppose this should be similar to Modem.Lockdown: only one D-Bus client c=
an =

set it (at a time), and it gets automatically cleared if said client dies.

> +		boolean ImsSmsRegistered [readwrite, optional]
> +
> +			Inform modem's radio stack that the IMS application
> +			has registered for SMS over IMS. This impacts
> +			"UE Mode of operation" and the ISR feature in the
> +			radio stack. Related AT command: AT+EISR

Ditto.

> +		boolean ImsVoiceOverPs [readonly, optional]
> +
> +			IMS voice is enabled by network
> +			Related AT command: AT+CIREP.

I guess the first two should not be settable if this one is false.

> +		string  PrivateImsIdentity [readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.
> +
> +		string  PublicImsIdentity [readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.
> +
> +		string  HomeDomainName[readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.
> +
> +		string  ImsToCsHandoverStatus [readonly, optional]
> +
> +			Indicate the handover progress status during a CS
> +			fallback procedure. This property will only be present
> +			when in LTE coverage. The possible values are:
> +			"none", "started","complete", "failure".
> +			Related AT URC: +CIREP
> +
> +		array{string}  PcscfAddresses[readonly]
> +
> +			Domain Name or IP Address of the P-CSCF servers.
> +			(SIP Proxy).
> +
> +		array{dict,array{dict}} QosFilters [readonly, optional]
> +
> +			Information about the QoSes and associated Packet
> +			Filters for the Default PDN and it's dedicated bearers.
> +			It is organized as a list of QoS definitions with
> +			a list of corresponding packet filters.
> +
> +				uint8 QoSClassIdentifier [readonly]
> +					The numeric parameter that specifying
> +					the class of QoS. (3GPP TS 23.203 [85])
> +					0	QCI is selected by network
> +					[1 =E2=80=93 4] guaranteed bit rate
> +					[5 =E2=80=93 9] non-guaranteed bit rate
> +
> +				uint16 UplinkRate [readonly, optional]
> +					Guaranteed Uplink Bit-rate in kb/sec.
> +
> +				uint16 DownlinkRate [readonly, optional]
> +					Guaranteed Downlink Bit-rate in kb/sec.
> +
> +			For each QoS defined there may be a list of Packet
> +			Filters. Each Packet Filter is a dictionary defining
> +			the filter. An empty Packet Filter represents the
> +			"default" filter (Default PDN connection).
> +
> +				string Direction [readonly]
> +					"uplink", "downlink", "bidirectional"
> +
> +				uint8 ProtocolNumber [readonly]
> +					IP protocol number (0-256)
> +
> +				string PeerAddress [readonly]
> +					The remote peer's IP address.
> +
> +				uint16 PeerPortMin [readonly]
> +					Remote peer's port number min. value
> +
> +				uint16 PeerPortMax [readonly]
> +					Remote peer's port number max. value
> +
> +				uint16 LocalePortMin [readonly]
> +					The local port number min. value
> +
> +				uint16 LocalPortMax [readonly]
> +					The local port number max. value


-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0785955248673687695==--

