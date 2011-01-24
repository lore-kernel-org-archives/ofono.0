Content-Type: multipart/mixed; boundary="===============0393337555256574997=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 12:14:37 +0200
Message-ID: <AANLkTim6d_4eHggK7JHO3hjG-uTu-UUbL4cU11VPrtHt@mail.gmail.com>
In-Reply-To: <1295853311.26199.41.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393337555256574997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

2011/1/24 Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>:
>> Let us set aside the the merits of the use cases for these features for
>> the moment ;) =C2=A0Implementing Call control by USIM is fairly
>> straightforward to do in the core. =C2=A0However, no modem manufacturer
>> currently allows us to have full control over this feature. =C2=A0It is
>> implemented in the firmware and every vendor does this differently. =C2=
=A0So
>> for now support of this feature is in the realm of the modem driver.
>>
> okay, so assuming this is how it is going stay. Even modem handles
> these, ofono should deliver possible AlphaId SIM may give in a response
> to call control envelope. I did not see if this is implemented. Or is it
> dropped since it is not tested in GCF..

I think enabling these types of modems would require the stk driver
API be able to give a bit of context to a proactive command. For
example, indicating that a send SMS proactive command is for
information purposes only, and that the SMS has been sent by the
modem.

Also some sort of feature negotiation between core and the stk drivers
might be needed for instance for indicating whether the modem takes
care of call control or not.

The ISI modems are another variation on this topic, as there you need
to use a specific request type to create calls with SIM toolkit turned
off (=3D no call control). With the default request type and
implementation, the call service would actually send the call control
requests back towards the stk driver. This would likely cause the
voicecall driver to be different, say, between the isiusb and n900
plugins.

Cheers,
Aki

--===============0393337555256574997==--

