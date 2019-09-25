Content-Type: multipart/mixed; boundary="===============8424543149694337453=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Wed, 25 Sep 2019 05:44:06 +0200
Message-ID: <d48fc281-bf0c-5870-9043-042493c2254e@norrbonn.se>
In-Reply-To: <80d85787-2bf2-afb9-aefa-1cf68b0fafd4@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8424543149694337453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 24/09/2019 21:20, Martin Hundeb=C3=B8ll wrote:
> Hi,
> =

> On 24/09/2019 20.09, Martin Hundeb=C3=B8ll wrote:
>> On 24/09/2019 19.23, Denis Kenzior wrote:
>>>> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The =

>>>> command gets requeued after 500ms, but it doesn't actually go out =

>>>> until the modem responds to the first one... not quite sure why this =

>>>> works, to be honest.
>>>>
>>>
>>> Funny.=C2=A0 But not real confidence inspiring :)
>>>
>>> Martin, any ideas what could be going wrong here?
>>
>> The code looks quite familiar :)

For good reason! :)

>>
>> Jonas, do you have a log with OFONO_AT_DEBUG=3D1 set?
> =


ofonod[31545]: Aux: > AT\r
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: Aux: > AT\r
ofonod[31545]: Aux: < AT\r
ofonod[31545]: Aux: < AT\r
ofonod[31545]: Aux: < \r\nOK\r\n
ofonod[31545]: plugins/ublox.c:init_cmd_cb() 0x563f7c2cebc0
ofonod[31545]: Aux: < \r\nOK\r\n
ofonod[31545]: Aux: < \r\n+AT: READY\r\n
ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
ofonod[31545]: Aux: > ATE0\r
ofonod[31545]: Aux: < ATE0
ofonod[31545]: Aux: < \r\r\nOK\r\n


> For the record, here one from my setup:
> =

> UART: > AT\r
> UART: < \371\013s\001\222\371
> ../git/plugins/quectel.c:init_timeout_cb() 0x610000000d40
> UART: > AT\r
> UART: < \r\nOK\r\n
> ../git/plugins/quectel.c:init_cmd_cb() 0x610000000d40
> ../git/src/modem.c:get_modem_property() modem 0x610000000d40 property =

> RtsCts
> UART: > ATE0\r
> UART: < \r\nOK\r\n
> =


So yours looks a bit different... you really do lose the first AT =

command into a black hole.  The uBlox modem seems to not lose anything =

sent over the USB bus but rather buffers it up and responds later.  That =

said, according to the documentation it _could_ lose the AT command so =

one cannot rely on the response just turning up eventually.

The thing that wasn't clear to me, though, was why every invocation of =

init_timeout_cb doesn't result in a new AT command being sent?  It's =

like the command is set to be retried in the first invocation, but it =

never gets sent so the subsequent retries amount to no-ops.  This =

behaviour is agreeable in this case, but I don't quite understand why it =

works this way...

/Jonas




--===============8424543149694337453==--

