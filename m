Content-Type: multipart/mixed; boundary="===============5594711816213054109=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] isi: Fix issue in call forwarding erase response
Date: Wed, 24 Nov 2010 16:55:28 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C07F0A@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTing8i6CrbykTxR9JHKOE3vt=BBiqfbmkU6qJ+YN@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5594711816213054109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Aki,

> =

> I think the problem is that we try to decode the alpha tag =

> even when it is not present, i.e., when _numlen is zero.
> =

> In fact, this has already been fixed in my current working =

> tree in a bit different way. Mostly due to the fact that I added a new
> g_isi_sb_iter_get_struct() method, which allows a little =

> easier access to sub-blocks like the one above.
> =

> If you're curious, here's the tree with the fix:
> http://meego.gitorious.org/~akiniemi/meego-cellular/ofono-aki/
commits/gisi

Went through your fix and it looks good.

Regards,
Jeevaka


--===============5594711816213054109==--

