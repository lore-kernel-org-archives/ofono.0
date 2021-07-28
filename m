Content-Type: multipart/mixed; boundary="===============3500940168577611237=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Documentation on when to free structures in/after callbacks
Date: Wed, 28 Jul 2021 12:31:35 -0500
Message-ID: <29743791-1526-f181-d024-eb3f747f9f74@gmail.com>
In-Reply-To: <20210728163224.2797.88718@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3500940168577611237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 7/28/21 11:32 AM, ajlennon(a)dynamicdevices.co.uk wrote:
> Hi all,
> =

> I'm trying to write a driver for Quectel modems as I need some specific b=
its and bobs - mainly signal strengths for the serving cell and neighbourho=
od cells
> =

> I can't quite get my head around when I am supposed to provide free() fun=
ctions to to calls and when to free in callbacks on success or error condit=
ions.

I'm not sure what you mean?  What exactly do you think needs freeing?

Everything from the driver going to the core are const * or passed by value=
. =

There should be no instances of the core taking ownership of any memory fro=
m the =

driver.  To put another way, if the driver mallocs something, then the driv=
er is =

responsible for freeing it.

Similarly, everything being passed in from the core to the driver is a cons=
t * =

or passed by value.

Fundamentally, there should never be any resource ownership change between =

driver and core...

> =

> Is there a bit of a document somewhere somebody could direct me to that e=
xplains this?
> =

> Or maybe I am overthinking and somebody could just explain the logic behi=
nd it?
> =

> Thanks!
> =

> Alex
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
> =


Regards,
-Denis
--===============3500940168577611237==--

