Content-Type: multipart/mixed; boundary="===============7873665201262661097=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 19 Feb 2020 12:24:51 +0100
Message-ID: <CAKSBH7Eg=4Ci+R-tB5LQ1nsiTAhdtUQ6s-ScO=W239P2tbmpmA@mail.gmail.com>
In-Reply-To: <CAHB-Pjm6HLEcobwDnS5sgvg6vL_FxemUGZb4mcp82UmbDLO-SQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7873665201262661097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>>
>> trying is quite easy. In plugins/ublox.c, there are 2 occurrencies of
>> "AT+CFUN=3D4":
>>  -> change both of them to "AT+CFUN=3D1".
>>   (I am not sure whether this will produce an error in case the modem
>> is already in CFUN:1, but it is worth trying).
>
> Yeah I have done this for a while. The question was not how to do it,
> just if there was an interest to get this kind of code upstreamed.
>

I don't have a uBlox modem at hand to test, but I expect there can be
problems similar to race conditions if the AT+CFUN=3D4 is commented out
instead of being changed to something more innocent.
Actually also an empty "AT" would do in your case.

Giacinto
--===============7873665201262661097==--

