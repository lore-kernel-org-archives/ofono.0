Content-Type: multipart/mixed; boundary="===============6366879763154929717=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 21:20:15 +0200
Message-ID: <80d85787-2bf2-afb9-aefa-1cf68b0fafd4@geanix.com>
In-Reply-To: <547d8842-d534-0406-448c-d490d9d17f11@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6366879763154929717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/09/2019 20.09, Martin Hundeb=C3=B8ll wrote:
> On 24/09/2019 19.23, Denis Kenzior wrote:
>>> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The =

>>> command gets requeued after 500ms, but it doesn't actually go out =

>>> until the modem responds to the first one... not quite sure why this =

>>> works, to be honest.
>>>
>>
>> Funny.=C2=A0 But not real confidence inspiring :)
>>
>> Martin, any ideas what could be going wrong here?
> =

> The code looks quite familiar :)
> =

> Jonas, do you have a log with OFONO_AT_DEBUG=3D1 set?

For the record, here one from my setup:

UART: > AT\r
UART: < \371\013s\001\222\371
../git/plugins/quectel.c:init_timeout_cb() 0x610000000d40
UART: > AT\r
UART: < \r\nOK\r\n
../git/plugins/quectel.c:init_cmd_cb() 0x610000000d40
../git/src/modem.c:get_modem_property() modem 0x610000000d40 property RtsCts
UART: > ATE0\r
UART: < \r\nOK\r\n

// Martin

--===============6366879763154929717==--

