Content-Type: multipart/mixed; boundary="===============1762005759782075360=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: fix for +CMER parser of AT driver (fixes registration)
Date: Sat, 19 Jan 2013 13:05:11 -0600
Message-ID: <50FAEE67.1090206@gmail.com>
In-Reply-To: <20130119182830.GT3604@emdete.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1762005759782075360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

>> So far you are the first to report a modem that behaves in this manner w=
hen
>> it comes to parameter lists.
>
> yes, because i am probably the first that investigated the problem in dep=
th. i
> saw alot of complains that the registration state is not reached from many
> ofono users. cause for that is exactly the +CMER answer of those modems.
>

Please understand, I'm not denying there's a problem, just that it is =

the first I've heard of it.  Please mention these reports on IRC or the =

Mailing List to me in the future so we can get them addressed quicker.

> as the modem in question is used in many thinkpads and other notebooks i =
assume
> that the many people can't use ofono out of this reason.

Can you actually tell me what this modem is?  Maybe I can test it on my end?

>
> so what do you suggest to support this modem? how would a quirk as you
> suggested look like?
>

The CMER parser was introduced in commit b87619.  It was essentially a =

straight forward port from the SMS driver and meant to fix the =

particular behaviors of the Telit devices.  This was early September, =

surprising that no one complained in 4 months...

The way I suggest to fix it would be to skip probing CMER if a quirk is =

enabled for your particular device and simply send the appropriate CMER =

command.  Prior to September oFono simply used to send 'AT+CMER=3D3,0,0,1'

Regards,
-Denis

--===============1762005759782075360==--

