Content-Type: multipart/mixed; boundary="===============7487042279402006163=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Wed, 31 Oct 2018 20:07:50 +0100
Message-ID: <2AF4E178-B7C9-4C46-B223-4B102E2EF49B@holtmann.org>
In-Reply-To: <ffd39808-f201-a06f-3bd3-fed05b16110b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7487042279402006163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>> So you might need to expand on this some more.  What is QMI+AT or
>>> MBIM+AT actually doing?  Is there a single AT port? Multiple? What is
>>> the AT port being used for, just vendor specific APIs or something more?
>> MBIM and QMI are actually used only for the gprs-context atom.
>> The modems can work with the mbim or gobi plugin if they support the
>> respective protocols (I have tested them with changes in udevng), but
>> then we only get the bare minimum: no configuration options, hardware
>> monitor, low-power mode, gnss and its options, and the rest.
>> So, given that we need the AT interface anyway, everything is done
>> through it. It is also easier to debug than the big binary blog
>> (admittedly, wireshark helps a lot for mbim, but not sure for qmi).
> =

> You really need to decide what you want to do here.  If your modem is MBI=
M, then MBIM driver needs to be used.  I really don't want to get into situ=
ations where we build some Frankenstein driver with gprs-context being driv=
en via MBIM and netreg being driven via AT commands.
> =

> I can understand if you have MBIM + a GPS/GNSS port and want to expose lo=
cation-reporting on that.  Ok, fine, I get that.  I can also understand if =
you want to use the AT command port for some vendor specific extensions not=
 available via MBIM.  But I would need serious convincing of anything beyon=
d this.

I think that MBIM (and even QMI) have AT passthrough options. So by all mea=
ns, the main transport suppose to be MBIM here. I always prefer if only one=
 hardware port is opened and there is no need to open more.

Regards

Marcel


--===============7487042279402006163==--

