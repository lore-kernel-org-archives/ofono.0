Content-Type: multipart/mixed; boundary="===============2002185349285939258=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ofono build error on ARM
Date: Sat, 01 Aug 2009 18:56:54 +0300
Message-ID: <200908011856.54384.remi@remlab.net>
In-Reply-To: <1249139209.3491.1.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2002185349285939258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le samedi 1 ao=C3=BBt 2009 18:06:49 Marcel Holtmann, vous avez =C3=A9crit :
> > > cc1: warnings being treated as errors
> > > netlink.c: In function =E2=80=98g_pn_nl_process=E2=80=99:
> > > netlink.c:75: error: cast increases required alignment of target type
> > > netlink.c:107: error: cast increases required alignment of target type
> > > netlink.c:109: error: cast increases required alignment of target type
> > > make[2]: *** [netlink.lo] Error 1
> >
> > I think there is no way to fix this. It comes from the Netlink packet
> > format and macros, which are confusing gcc. That's why I hate to enfore
> > -Werror.
>
> we only enforce -Werror for the developers and it is important to have
> gcc help us catch mistakes that might be easily overlooked.

If I recall correctly, `-Werror' is enforced when maintainer mode is enable=
d. =

Really, turning off maintainer mode is primilarly useful to binary package =

maintainers who *might* not want to trigger autotools updates. Then again, =

some might waht to have them anyway... I find the underlying assumption to =
be =

a bit restrictive if not flawed.

> I would have to look into these one and how we can fix them properly.

As far as I understand, those warnings come from casting receive buffers in=
to =

structure with higher-order alignment requirement  - with some of your =

competitors' CPU architectures anyway ;) Arguably, those are caused by =

kernel/libc headers, not Ofono. I will check on Monday if we can fix them b=
y =

promoting the receive buffers to larger integer types, but it might make th=
e =

code worse.

But generally, there remain a problem that some warnings might simply be =

bogus, or not under our control. For instance -outside of Ofono- I'm yet to =

find a way around dummy variable "clobber warnings" when using POSIX thread =

cancellation cleanup handlers. Sure, I could make all variables volatile, b=
ut =

I refuse to damage optimizations for the sake of bogus warnings...

The real shame is that -Werror-* is dysfunctional in GCC :(

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/


--===============2002185349285939258==--

