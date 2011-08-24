Content-Type: multipart/mixed; boundary="===============8254728914693707608=="
MIME-Version: 1.0
From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: Bluetooth HF role
Date: Wed, 24 Aug 2011 13:56:44 -0300
Message-ID: <20110824165643.GA2662@joana>
In-Reply-To: <4E5518A3.6070402@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8254728914693707608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

* Mikel Astiz <mikel.astiz@bmw-carit.de> [2011-08-24 17:28:35 +0200]:

> Hi all,
> =

> I'm trying to understand the features currently supported by oFono
> regarding the handsfree role in Bluetooth/HFP. My first impression
> looking at the source code is that some HFP functionality might be
> missing, but I would rather have your confirmation.
> =

> Some examples I've found so far are the following:
> 1. Response and hold (AT+BTRH=3D0)
> 2. Redial last number (AT+BLDN)

Yeah, these are missing.

> 3. Retrieval of supported Bluetooth features for a certain
> modem/device (AT+BRSF)

This is done by hfp_slc_establish() in hfp_hf.c plugin.
> =

> Could you clarify which (if any) of these features are currently
> supported by oFono?
> =

> In general, is there any documented list of unsupported features?

No, I think you need to confront the code against the spec.

	Gustavo

--===============8254728914693707608==--

