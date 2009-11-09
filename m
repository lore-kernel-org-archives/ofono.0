Content-Type: multipart/mixed; boundary="===============2215087586219804946=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Mon, 09 Nov 2009 19:27:04 +0200
Message-ID: <200911091927.04309.remi@remlab.net>
In-Reply-To: <fb249edb0911090745mde77804k923afa48efcd98f8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2215087586219804946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le lundi 9 novembre 2009 17:45:25 andrzej zaborowski, vous avez =C3=A9crit :
> Hi,
> resurrecting this thread because I think there's no reason ofono
> should not build on cpus with strict alignment rules, the netlink code
> is actually aligned correctly.  These warnings are a result of
> -Wcast-align, the compiler can't know that the casts in the macros are
> safe, but they obviously are if you look at the arithmetics there.  In
> the case of the netlink warnings they can be turned off for all users
> of <linux/netlink.h> using a pragma or only for this cast by casting
> to void * first (the only way according to gcc people), the first
> attached file adds them (against linux), I'll send it to linux if
> there's no better idea.  There are also similar warnings when casting
> struct sockaddr_pn * to struct sockaddr * and these can be worked
> around in ofono, see second patch, but probably should also be in
> linux's include/linux/phonet.h instead.

Why do you change the sockaddr_pn type name?!

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============2215087586219804946==--

