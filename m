Content-Type: multipart/mixed; boundary="===============3226456257298633929=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Mon, 09 Nov 2009 20:03:48 +0200
Message-ID: <200911092003.48173.remi@remlab.net>
In-Reply-To: <fb249edb0911090957y79b2e29q584db4a849b812b1@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3226456257298633929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le lundi 9 novembre 2009 19:57:07 andrzej zaborowski, vous avez =C3=A9crit :
> 2009/11/9 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> > As far as I know NO extra alignement is needed. The kernel will anyway
> > memory copy from/to the sockaddr_pn buffer as part of the socket calls,
> > so it couldn't care less about alignment.
> =

> Practically I'm sure you're right and maybe we should stick a (void *)
> cast in between the casts or disable the warning.  Formally that
> memcpy is an implementation detail and could be true in one kernel
> version and false in the next version, so when you pass a struct
> sockaddr * to a function it should, in theory be aligned as such.

Well no. The only thing you're allowed to read from someone else's sockaddr=
 is =

the family field, which does have the same alignment in sockaddr_pn as in =

sockaddr (practically, two bytes). After that, the reader is responsible fo=
r =

casting back to the correct type.

So this warning is _bogus_.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============3226456257298633929==--

