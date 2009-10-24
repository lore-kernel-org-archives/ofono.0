Content-Type: multipart/mixed; boundary="===============5990794137195927505=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sat, 24 Oct 2009 10:18:12 +0200
Message-ID: <fb249edb0910240118h21bb3464ya8b655ae4db9aba0@mail.gmail.com>
In-Reply-To: <fb249edb0910240104x3d994b16u39d8277a0c9a997e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5990794137195927505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/10/24 andrzej zaborowski <balrogg@gmail.com>:
> 2009/10/24 Denis Kenzior <denkenz@gmail.com>:
>> Ok, so I took the patch and hacked on it for a while. =C2=A0I disagreed =
with how
>> you split up responsibilities, so much of the logic got moved into the c=
ore
>> and the driver was simplified.

By the way I notice that in most atoms' _create functions, when we
loop over the drivers
and call drv->probe() until we succeed, we still return success even if none
of the drivers succeeded, should we return a NULL?

Regards

--===============5990794137195927505==--

