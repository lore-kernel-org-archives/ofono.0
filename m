Content-Type: multipart/mixed; boundary="===============6733121060457900238=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Thu, 08 Jul 2010 09:30:35 -0500
Message-ID: <4C35E10B.7080200@gmail.com>
In-Reply-To: <10180baccc529013508c7e6c4a8a0f27@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6733121060457900238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On 07/08/2010 09:23 AM, R=C3=A9mi Denis-Courmont wrote:
> =

> On Thu, 08 Jul 2010 10:26:04 -0300, Marcel Holtmann <marcel@holtmann.or=
g>
> wrote:
>>>> Marcel is right. Here I fake most AT commands like +CFUN to make DUN
>>>> client happy. We don't need to power on/off real modem at all. See
>>>> gatchat/test-server.c for similar implementation.
>>>
>>> That depends much what you're trying to achieve. If you only care about
>>> Dial-Up Networking, that might work. But if you care about passing
>> various
>>> some kinds of certification testing, AT commands _must_ work
>> _correctly_.
>>>
>>> So I doubt oFono will get away with this in the medium term.
>>
>> we are clearly and on purpose splitting Bluetooth Dialup support from
>> generic Serial Port Profile support.
>>
>> For the serial port for certification testing you will NOT be able to
>> use dialup channel.
> =

> I think it's quite the opposite. In my understanding, some tests do requi=
re
> DUN. Obviously you loose the ability to send AT commands while PPP is
> active.
> =


Our first goal here is to make the mandatory DUN aspects work.  This
means covering the mandatory AT commands specified by the Bluetooth DUN
profile, PPP server aspects and ConnMan integration.  If we have to fake
some commands to keep the clients happy, so be it.

Once we have this, we can start talking about more advanced features
you're talking about here.  Since you seem to have some experience in
this area, we'd certainly appreciate you getting involved and helping out.

Regards,
-Denis

--===============6733121060457900238==--

