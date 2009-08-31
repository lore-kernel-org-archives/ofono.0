Content-Type: multipart/mixed; boundary="===============7473320381489239154=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: driver callback naming
Date: Mon, 31 Aug 2009 11:54:54 +0300
Message-ID: <a32762a20908310154j4ef8d95dub68496238049b38f@mail.gmail.com>
In-Reply-To: <200908301520.56202.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7473320381489239154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2009/8/30 Denis Kenzior <denkenz@gmail.com>:
>> On a somewhat related note, I don't quite see what to do with
>> deregister in the netreg driver. Is the intended end state of the
>> device, in fact, similar to airplane mode?
>
> This maps directly to AT+COPS=3D2, which means completely deregister from
> network, but still be in full-capability mode.

You mean the device ends up in limited service mode, where only
emergency calls are possible? AFAIK, that can only be triggered with
the Nokia modem API as a side effect of deliberately making a manual
registration to a forbidden network. Yuk. :)

> The usefulness of this is of
> course questionable, like many other areas of the spec. =C2=A0I'm actuall=
y willing
> to drop this from the driver, however there might be some use for this
> functionality when using manual operator selection.

I'd vote for dropping it. Unless we want to have real poweron/poweroff
in the modem interface, then the netreg driver could handle RF on/off.

Cheers,
Aki

--===============7473320381489239154==--

