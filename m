Content-Type: multipart/mixed; boundary="===============7751698233970950657=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Mon, 09 Nov 2009 18:57:07 +0100
Message-ID: <fb249edb0911090957y79b2e29q584db4a849b812b1@mail.gmail.com>
In-Reply-To: <200911091945.53723.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7751698233970950657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/11/9 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> As far as I know NO extra alignement is needed. The kernel will anyway me=
mory
> copy from/to the sockaddr_pn buffer as part of the socket calls, so it
> couldn't care less about alignment.

Practically I'm sure you're right and maybe we should stick a (void *)
cast in between the casts or disable the warning.  Formally that
memcpy is an implementation detail and could be true in one kernel
version and false in the next version, so when you pass a struct
sockaddr * to a function it should, in theory be aligned as such.

Regards

--===============7751698233970950657==--

