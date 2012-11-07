Content-Type: multipart/mixed; boundary="===============5064852226138310617=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Wed, 07 Nov 2012 08:17:05 -0600
Message-ID: <509A6D61.4020200@gmail.com>
In-Reply-To: <op.wnd4wrs4yxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5064852226138310617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

>> oFono is the one establishing the GPRS context. Some other daemon
>> makes the control decisions on what context should be established and
>> when. e.g. connman makes this decision in the case of Type=3Dinternet
>> contexts and something like mmsd makes this decision for Type=3Dmms
>> contexts.
>
> I will check mmsd thank you for the info. Do you know if it is a mature
> project? I mean if it can be used for basic mms sending?
>

It should be complete enough to allow basic mms send and receive, yes. =

However, the project is not (yet) up to the same level of maturity / =

quality / stability as oFono.

>>> task for another daemon like connman or something similar? If yes how
>>> these daemons communicate with ofono when they are grabbing the
>>> interface for making ppp conection?
>>>
>>
>> I'm not quite sure I understand the question? The context
>> establishment is achieved using org.ofono.ConnectionContext interface,
>> e.g. by setting the 'Active' property. The PPP connection is done by
>> oFono itself.
>
> I'd like to use ofono to be able to do voice calls and sms messaging.
> Without ofono, I'm able to connect to internet over PPP using pppd
> daemon with proper script using one of the modem interfaces
> (ttyUSBx/ttyACMx). Such connection can be done directly using ofono
> (without pppd)?

oFono has its own internal ppp stack, no pppd is required.  If your =

modem supports a high-speed interface, then that should be used instead.

And yes, you can do voice calls, sms and internet at the same time with =

oFono.  Assuming of course you have at least two ttys available or your =

modem supports multiplexing.

Regards,
-Denis

--===============5064852226138310617==--

