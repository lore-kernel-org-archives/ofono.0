Content-Type: multipart/mixed; boundary="===============8235494902138680189=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Query on ppp0 interface for HE910 device
Date: Mon, 18 May 2015 09:01:07 -0500
Message-ID: <5559F0A3.8050509@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCBF2C9@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8235494902138680189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

On 05/18/2015 03:38 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Dear Sir,
>
> We are using CONNMAN/OFONO for wireless communication and network
> management.
>
> Whenever the connman daemon switches from cellular to wifi
> automatically, ofonod removes the ppp0 interface.
>

oFono does not do anything of its own accord.  ConnMan must be asking =

oFono to deactivate the context.  Is this the case?  Can you provide =

debug logs of what is happening on ConnMan side and oFono side?

> On the oterhway round the ofono daemon is not doing the addition of the
> ppp0 interface.

Can you elaborate?

>
> I have been manually activating the context for get it right.
>
> I am using HE910 modem with ofono version 1.16.
>

I suspect this is a question for the connman folks.

Regards,
-Denis


--===============8235494902138680189==--

