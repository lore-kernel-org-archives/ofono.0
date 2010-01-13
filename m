Content-Type: multipart/mixed; boundary="===============1175522868340056946=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 3/3] If EF-MWIS is not available use the CPHS version.
Date: Wed, 13 Jan 2010 02:24:19 +0100
Message-ID: <fb249edb1001121724t4ee0f0dm9f831afee4cbdb5@mail.gmail.com>
In-Reply-To: <201001121823.48282.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1175522868340056946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/1/13 Denis Kenzior <denkenz@gmail.com>:
> I applied this patch, but really it was completely broken and I shouldn't

You're right.  I had passed a NULL in place of user data for
ofono_sim_write due to a last-minute refactoring, sorry about that.
No recurrence was possible though because of a check that new and old
MBDNs were different.

> have. =C2=A0I ended up rewriting most of it since the =C2=A0CPHS MWIS for=
mat is
> completely different from 3GPP.

The new version works for me.  My patch had the fax indication in the
wrong byte because as you noticed there's no separate fax or data MWI
for the second ALS line.

Regards

--===============1175522868340056946==--

