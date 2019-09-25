Content-Type: multipart/mixed; boundary="===============8389337688085249762=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Wed, 25 Sep 2019 09:27:00 +0200
Message-ID: <9a124ace-7284-be81-1d5e-f5c73110d492@geanix.com>
In-Reply-To: <d48fc281-bf0c-5870-9043-042493c2254e@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8389337688085249762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 9/25/19 5:44 AM, Jonas Bonn wrote:
> On 24/09/2019 21:20, Martin Hundeb=C3=B8ll wrote:
>> On 24/09/2019 20.09, Martin Hundeb=C3=B8ll wrote:
>>> On 24/09/2019 19.23, Denis Kenzior wrote:
>>>>> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The =

>>>>> command gets requeued after 500ms, but it doesn't actually go out =

>>>>> until the modem responds to the first one... not quite sure why =

>>>>> this works, to be honest.
>>>>>
>>>>
>>>> Funny.=C2=A0 But not real confidence inspiring :)
>>>>
>>>> Martin, any ideas what could be going wrong here?
>>>
>>> The code looks quite familiar :)
> =

> For good reason! :)
> =

>>>
>>> Jonas, do you have a log with OFONO_AT_DEBUG=3D1 set?
>>
> =

> ofonod[31545]: Aux: > AT\r
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: Aux: > AT\r
> ofonod[31545]: Aux: < AT\r
> ofonod[31545]: Aux: < AT\r
> ofonod[31545]: Aux: < \r\nOK\r\n
> ofonod[31545]: plugins/ublox.c:init_cmd_cb() 0x563f7c2cebc0
> ofonod[31545]: Aux: < \r\nOK\r\n
> ofonod[31545]: Aux: < \r\n+AT: READY\r\n
> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
> ofonod[31545]: Aux: > ATE0\r
> ofonod[31545]: Aux: < ATE0
> ofonod[31545]: Aux: < \r\r\nOK\r\n
> =

> =

>> For the record, here one from my setup:
>>
>> UART: > AT\r
>> UART: < \371\013s\001\222\371
>> ../git/plugins/quectel.c:init_timeout_cb() 0x610000000d40
>> UART: > AT\r
>> UART: < \r\nOK\r\n
>> ../git/plugins/quectel.c:init_cmd_cb() 0x610000000d40
>> ../git/src/modem.c:get_modem_property() modem 0x610000000d40 property =

>> RtsCts
>> UART: > ATE0\r
>> UART: < \r\nOK\r\n
>>
> =

> So yours looks a bit different... you really do lose the first AT =

> command into a black hole.=C2=A0 The uBlox modem seems to not lose anythi=
ng =

> sent over the USB bus but rather buffers it up and responds later.=C2=A0 =
That =

> said, according to the documentation it _could_ lose the AT command so =

> one cannot rely on the response just turning up eventually.

Could it be safe to assume that it will lose only a single AT command? =

In that case, it should be enough to send just two AT's. Once the first =

OK is received, you could wait 500 ms for the second OK, or retry the =

second AT in case of a timeout?

No lost AT:
  > AT   // Send first
  > AT   // Send second and wait
  < OK   // Wait 500 ms
  < OK   // Start initialization

One lost AT
  > AT   // Send first
  > AT   // Send second and wait
  < OK   // Wait 500 ms
  > AT   // Retry second
  < OK   // Start initialization

> The thing that wasn't clear to me, though, was why every invocation of =

> init_timeout_cb doesn't result in a new AT command being sent?=C2=A0 It's =

> like the command is set to be retried in the first invocation, but it =

> never gets sent so the subsequent retries amount to no-ops.=C2=A0 This =

> behaviour is agreeable in this case, but I don't quite understand why it =

> works this way...

Can the usb-to-serial driver block further writes until the modem is ready?

// Martin

--===============8389337688085249762==--

