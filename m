Content-Type: multipart/mixed; boundary="===============4886863250517984622=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/6] stemodem: add default case
Date: Wed, 27 Oct 2010 11:12:08 +0200
Message-ID: <1288170728.3613.32.camel@aeonflux>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7DBDFCDA@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4886863250517984622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > That must be a new policy then, considering that stemodem =

> > is the only one that failed compilation. Feel free to fix =

> > this one. The first two patches in the set are unrelated to =

> > fast dormancy anyway.
> > =

> > that is the whole point here. You modified the enum and the =

> > compilation
> > should fail unless you add a statement for that new item.
> > =

> > Let me make this clear, I do want the compilation to fail here and the
> > STE driver is doing the right thing.
> =

> I understand that. As I said, feel free to fix. Fast dormancy patches 3-6=
 should apply just fine without the first two courtesy patches.

I am waiting for Denis review since he was looking at them initially.
Once these are applied, we can take care of the fallout.

> > There might be other cases where this is not consistent. I =

> > would prefer
> > if that never happens, but somethings things slip through even close
> > code review. If you know other cases, please let me know and =

> > we fix them
> > as well here.
> =

> All the other drivers implementing radio settings. Here's a couple of exa=
mples:
> =

> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 134)        switch (m=
ode) {
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 135)        case OFON=
O_RADIO_ACCESS_MODE_ANY:
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 136)                v=
alue =3D 1;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 137)                b=
reak;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 138)        case OFON=
O_RADIO_ACCESS_MODE_GSM:
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 139)                v=
alue =3D 0;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 140)                b=
reak;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 141)        case OFON=
O_RADIO_ACCESS_MODE_UMTS:
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 142)                v=
alue =3D 2;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 143)                b=
reak;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 144)        default:
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 145)                C=
ALLBACK_WITH_FAILURE(cb, data);
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 146)                g=
_free(cbd);
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 147)                r=
eturn;
> ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 148)        }
> =

> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 133)        switch (m=
ode) {
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 134)        case OFON=
O_RADIO_ACCESS_MODE_ANY:
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 135)                v=
alue =3D 5;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 136)                b=
reak;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 137)        case OFON=
O_RADIO_ACCESS_MODE_GSM:
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 138)                v=
alue =3D 0;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 139)                b=
reak;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 140)        case OFON=
O_RADIO_ACCESS_MODE_UMTS:
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 141)                v=
alue =3D 1;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 142)                b=
reak;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 143)        default:
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 144)                C=
ALLBACK_WITH_FAILURE(cb, data);
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 145)                g=
_free(cbd);
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 146)                r=
eturn;
> 30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 147)        }
> =

> Sorry, couldn't resist. ;-)

I have no problem with that being pointing out. I actually encourage
people pointing this out. This is clearly myself being stupid. And good
thing is that this is open source, so I fixed it.

With a code base of 100k lines of code and more, such things happen. And
even with Denis and myself cross-reviewing each other this will still
happen. Sometimes things just slip through the cracks. Part of
development life. So once noticed this will be dealt with.

Regards

Marcel



--===============4886863250517984622==--

