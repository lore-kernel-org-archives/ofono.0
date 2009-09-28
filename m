Content-Type: multipart/mixed; boundary="===============7644940827638967269=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Mon, 28 Sep 2009 13:29:01 -0500
Message-ID: <200909281329.01488.denkenz@gmail.com>
In-Reply-To: <fb249edb0909251156jc5f3715tdab09b2ab5a359d4@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644940827638967269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi Denis,
>
> 2009/9/24 Denis Kenzior <denkenz@gmail.com>:
> > I pushed a patch to simply ignore EFli if the first
> > entry is 0xffff
>
> I moved the check a little up because at that point the raw EFli would
> have been freed already (see attached).

Good catch, I fixed it slightly differently upstream.

Regards,
-Denis

--===============7644940827638967269==--

