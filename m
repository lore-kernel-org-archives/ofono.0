Content-Type: multipart/mixed; boundary="===============5980314320767119941=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Mon, 09 Nov 2009 19:45:53 +0200
Message-ID: <200911091945.53723.remi@remlab.net>
In-Reply-To: <fb249edb0911090934p7c1f693ag62abda1d84999430@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5980314320767119941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le lundi 9 novembre 2009 19:34:36 andrzej zaborowski, vous avez =C3=A9crit :
> 2009/11/9 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> > Le lundi 9 novembre 2009 17:45:25 andrzej zaborowski, vous avez =C3=A9c=
rit :
> >> Hi,
> >> resurrecting this thread because I think there's no reason ofono
> >> should not build on cpus with strict alignment rules, the netlink code
> >> is actually aligned correctly.  These warnings are a result of
> >> -Wcast-align, the compiler can't know that the casts in the macros are
> >> safe, but they obviously are if you look at the arithmetics there.  In
> >> the case of the netlink warnings they can be turned off for all users
> >> of <linux/netlink.h> using a pragma or only for this cast by casting
> >> to void * first (the only way according to gcc people), the first
> >> attached file adds them (against linux), I'll send it to linux if
> >> there's no better idea.  There are also similar warnings when casting
> >> struct sockaddr_pn * to struct sockaddr * and these can be worked
> >> around in ofono, see second patch, but probably should also be in
> >> linux's include/linux/phonet.h instead.
> >
> > Why do you change the sockaddr_pn type name?!
> =

> Because it's been defined without explicit alignment and I don't think
> you can redefine it with the same name?

As far as I know NO extra alignement is needed. The kernel will anyway memo=
ry =

copy from/to the sockaddr_pn buffer as part of the socket calls, so it =

couldn't care less about alignment.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============5980314320767119941==--

