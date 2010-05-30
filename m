Content-Type: multipart/mixed; boundary="===============9124671640128644036=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: RTNL sync or async when creating GPRS Context for STE modem.
Date: Sun, 30 May 2010 22:46:22 +0300
Message-ID: <201005302246.22317.remi@remlab.net>
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579169C37B38A@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9124671640128644036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le dimanche 30 mai 2010 17:45:04 Sjur BRENDELAND, vous avez =C3=A9crit :
> I have started out by doing the RTNL handling async,
> i.e. registering the RTNL socket with g_io_add_watch etc.
> But I'm not really happy with the code as it feels
> unnecessary complex, introduces new states in gprs-context.c. etc.

Using an event loop makes sense if, and only if, the process blocks as far =
as =

poll() is concerned. If your ioctl() calls or Netlink requests do not enter =

the kernel scheduler at any point, then the glib main loop will just slows =

things down - more code, more context switches.

As an counter example, some people believe so blindly in event loops that t=
hey =

use them to read *regular* files, and then recommend it to their friends. =

Nevermind that POSIX states that regular files are always marked ready for =

POLLIN and POLLOUT events, i.e. poll()'ing a regular file will always retur=
n =

immediately. Thus the event loop is defeated, and just constitutes useless =

code complexity and wasted CPU time. (Of course, if the same code path can =

cope with non-regular files, then using poll() might make sense, don't make=
 me =

say what I did not.)

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============9124671640128644036==--

