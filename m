Content-Type: multipart/mixed; boundary="===============5047607444372730387=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Wed, 28 Apr 2010 19:08:08 +0300
Message-ID: <201004281908.08781.remi@remlab.net>
In-Reply-To: <m2q80fd4e751004280715l548126e8w46a2886ff2a92219@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5047607444372730387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mercredi 28 avril 2010 17:15:54 Pekka Pessi, vous avez =C3=A9crit :
> 2010/4/28 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> > I fail to see why we need this. usbpn is already autoconfigured by the
> > kernel. It only needs to be brought administratively up.
> =

> This is not the case with 2.6.31. Does it hurt with later kernels?

Not all kernel versions support routing. And I'd hate to duplicate existing =

kernel functionality in oFono user-space forever just for 2.6.31 (long term =

support is 2.6.32 by the way). There's probably two users in the entire wor=
ld =

who care about the 2.6.31 + USB CDC Phonet + oFono - phonet-utils combinati=
on.

Not to mention that it is done in a much cleaner and compact way in kernel =

space. Also this would prevent me or someone else from ever improving the =

Phonet (auto)configuration later, which is certainly on my roadmap.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============5047607444372730387==--

