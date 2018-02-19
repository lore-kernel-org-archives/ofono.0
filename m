Content-Type: multipart/mixed; boundary="===============2591387211058349977=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS Attach/Detach
Date: Mon, 19 Feb 2018 10:36:02 -0600
Message-ID: <8f464053-95f2-99ab-6149-5f6fb23254a7@gmail.com>
In-Reply-To: <CAKsXZz2w1NeD0KzAdattSEyj6HxG+wdOW4xCM=UzvB34jt-STg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2591387211058349977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nikolas,

On 02/19/2018 06:55 AM, Nikolas Sepos wrote:
> Hello Denis,
> =

> thank you very much for the reply.
> =

>     Doesn't seem to have anything to do with PPP actually.=C2=A0 Anyway,
>     there should be no active contexts if we're detached.=C2=A0 Otherwise
>     this will confuse ConnMan, NetworkManager, etc. =

> =

> Aren't ConnMan & NetworkManager get the info regarding modems state etc. =

> from ofono? How can this confuse them? (excuse my ignorance)

The global Attached status as well as whether a particular context is =

Active are signaled over D-Bus.  There should be no active contexts if =

we're detached.  Unfortunately the firmware on many modems does not make =

such guarantees.  So oFono core tries pretty hard to make sure that a =

consistent state is signaled, e.g. no active contexts when detached.

> =

>     The core tries to work around some of the more common issues, but
>     ultimately the driver needs to make sure the transitions are well
>     behaved.
> =

> =

> Shouldn't this behavior=C2=A0 be handled by the drivers directly instead =
of =

> the core?
> =


Ideally yes, but this is not what you were asking originally.

Regards,
-Denis

--===============2591387211058349977==--

