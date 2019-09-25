Content-Type: multipart/mixed; boundary="===============5728340369671919419=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Wed, 25 Sep 2019 09:41:43 +0200
Message-ID: <390a5f2a-f1da-8373-3bbf-7e020441ab03@norrbonn.se>
In-Reply-To: <9a124ace-7284-be81-1d5e-f5c73110d492@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5728340369671919419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 25/09/2019 09:27, Martin Hundeb=C3=B8ll wrote:
> Hi Jonas,
> =

> On 9/25/19 5:44 AM, Jonas Bonn wrote:
>> On 24/09/2019 21:20, Martin Hundeb=C3=B8ll wrote:
>>> On 24/09/2019 20.09, Martin Hundeb=C3=B8ll wrote:
>>>> On 24/09/2019 19.23, Denis Kenzior wrote:
>>>>>> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The =

>>>>>> command gets requeued after 500ms, but it doesn't actually go out =

>>>>>> until the modem responds to the first one... not quite sure why =

>>>>>> this works, to be honest.
>>>>>>
>>>>>
>>>>> Funny.=C2=A0 But not real confidence inspiring :)
>>>>>
>>>>> Martin, any ideas what could be going wrong here?
>>>>
>>>> The code looks quite familiar :)
>>
>> For good reason! :)
>>
>>>>
>>>> Jonas, do you have a log with OFONO_AT_DEBUG=3D1 set?
>>>
>>
>> ofonod[31545]: Aux: > AT\r
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: Aux: > AT\r
>> ofonod[31545]: Aux: < AT\r
>> ofonod[31545]: Aux: < AT\r
>> ofonod[31545]: Aux: < \r\nOK\r\n
>> ofonod[31545]: plugins/ublox.c:init_cmd_cb() 0x563f7c2cebc0
>> ofonod[31545]: Aux: < \r\nOK\r\n
>> ofonod[31545]: Aux: < \r\n+AT: READY\r\n
>> ofonod[31545]: plugins/ublox.c:init_timeout_cb() 0x563f7c2cebc0
>> ofonod[31545]: Aux: > ATE0\r
>> ofonod[31545]: Aux: < ATE0
>> ofonod[31545]: Aux: < \r\r\nOK\r\n
>>
>>
>>> For the record, here one from my setup:
>>>
>>> UART: > AT\r
>>> UART: < \371\013s\001\222\371
>>> ../git/plugins/quectel.c:init_timeout_cb() 0x610000000d40
>>> UART: > AT\r
>>> UART: < \r\nOK\r\n
>>> ../git/plugins/quectel.c:init_cmd_cb() 0x610000000d40
>>> ../git/src/modem.c:get_modem_property() modem 0x610000000d40 property =

>>> RtsCts
>>> UART: > ATE0\r
>>> UART: < \r\nOK\r\n
>>>
>>
>> So yours looks a bit different... you really do lose the first AT =

>> command into a black hole.=C2=A0 The uBlox modem seems to not lose anyth=
ing =

>> sent over the USB bus but rather buffers it up and responds later.  =

>> That said, according to the documentation it _could_ lose the AT =

>> command so one cannot rely on the response just turning up eventually.
> =

> Could it be safe to assume that it will lose only a single AT command? =

> In that case, it should be enough to send just two AT's. Once the first =

> OK is received, you could wait 500 ms for the second OK, or retry the =

> second AT in case of a timeout?
> =

> No lost AT:
>  =C2=A0> AT=C2=A0=C2=A0 // Send first
>  =C2=A0> AT=C2=A0=C2=A0 // Send second and wait
>  =C2=A0< OK=C2=A0=C2=A0 // Wait 500 ms
>  =C2=A0< OK=C2=A0=C2=A0 // Start initialization
> =

> One lost AT
>  =C2=A0> AT=C2=A0=C2=A0 // Send first
>  =C2=A0> AT=C2=A0=C2=A0 // Send second and wait
>  =C2=A0< OK=C2=A0=C2=A0 // Wait 500 ms
>  =C2=A0> AT=C2=A0=C2=A0 // Retry second
>  =C2=A0< OK=C2=A0=C2=A0 // Start initialization

That's pretty much what we've got, isn't it?


> =

>> The thing that wasn't clear to me, though, was why every invocation of =

>> init_timeout_cb doesn't result in a new AT command being sent?=C2=A0 It'=
s =

>> like the command is set to be retried in the first invocation, but it =

>> never gets sent so the subsequent retries amount to no-ops.=C2=A0 This =

>> behaviour is agreeable in this case, but I don't quite understand why =

>> it works this way...
> =

> Can the usb-to-serial driver block further writes until the modem is read=
y?

Not the driver but the modem.  If the USB bulk endpoint on the modem =

side decides it is busy (for example, because it's buffers are full), it =

can NAK subsequent packets until it's ready to receive again.  It's not =

out of the question that Linux is smart enough to return EAGAIN for a =

write in that case... but I would suspect that the OS would normally =

buffer the write() for more than one AT command before this happened. =

For that reason, I can't see why ofono would be able to detect this... =

from ofono's point of view it should just look like there's a series of =

AT commands going out and no responses coming back.  There must be some =

magic in g_io_...???

/Jonas

> =

> // Martin

--===============5728340369671919419==--

