Content-Type: multipart/mixed; boundary="===============5111465912508566193=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 14:14:06 +0100
Message-ID: <1296134046.1520.152.camel@aeonflux>
In-Reply-To: <1296053943-18748-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5111465912508566193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  doc/ims-api.txt |  119 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 119 insertions(+), 0 deletions(-)
>  create mode 100644 doc/ims-api.txt
> =

> diff --git a/doc/ims-api.txt b/doc/ims-api.txt
> new file mode 100644
> index 0000000..865413f
> --- /dev/null
> +++ b/doc/ims-api.txt
> @@ -0,0 +1,119 @@
> +IMS hierarchy  [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.Ims
> +Object path	[variable]

we are trying to not use abbreviations for the interface names. So maybe
something like org.ofono.MultimediaSubsystem would be better.

> +Methods		dict GetProperties()
> +
> +			Returns all global system properties. See the
> +			properties section for available properties.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +
> +		void SetProperty(string property, variant value)
> +
> +			Sets the property to a desired value
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.Failed
> +
> +Signals		PropertyChanged(string property, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	boolean ImsVoiceRegistered [readwrite, optional]

Since the interface name already contains the reference to IMS, we did
avoid to have namespacing as part of the property names. So in this case
using VoiceRegistered would be more correct.

> +			Inform modem's radio stack that the IMS application
> +			has registered for Voice over IMS. This impacts
> +			"UE Mode of operation" and the ISR feature in the
> +			radio stack. Related AT command: AT+EISR
> +
> +		boolean ImsSmsRegistered [readwrite, optional]

We did try not to use SMS etc. So maybe MessagingRegistered would be
better.

> +
> +			Inform modem's radio stack that the IMS application
> +			has registered for SMS over IMS. This impacts
> +			"UE Mode of operation" and the ISR feature in the
> +			radio stack. Related AT command: AT+EISR
> +
> +		boolean ImsVoiceOverPs [readonly, optional]
> +
> +			IMS voice is enabled by network
> +			Related AT command: AT+CIREP.
> +
> +		string  PrivateImsIdentity [readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.

Same goes here, PrivateIdentify etc. I think you catch the drift.

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

We really need to understand what the IMS application will need. If this
is about codecs or other things, then maybe oFono should give codec
advise directly. Proposals are welcome. Right now this looks like going
overboard.

Regards

Marcel



--===============5111465912508566193==--

