Content-Type: multipart/mixed; boundary="===============0750714970936731400=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 2/6] stemodem: add default case
Date: Wed, 27 Oct 2010 09:06:01 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7DBDFCDA@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1288110295.3613.25.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0750714970936731400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > That must be a new policy then, considering that stemodem =

> is the only one that failed compilation. Feel free to fix =

> this one. The first two patches in the set are unrelated to =

> fast dormancy anyway.
> =

> that is the whole point here. You modified the enum and the =

> compilation
> should fail unless you add a statement for that new item.
> =

> Let me make this clear, I do want the compilation to fail here and the
> STE driver is doing the right thing.

I understand that. As I said, feel free to fix. Fast dormancy patches 3-6 s=
hould apply just fine without the first two courtesy patches.

> There might be other cases where this is not consistent. I =

> would prefer
> if that never happens, but somethings things slip through even close
> code review. If you know other cases, please let me know and =

> we fix them
> as well here.

All the other drivers implementing radio settings. Here's a couple of examp=
les:

ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 134)        switch (mod=
e) {
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 135)        case OFONO_=
RADIO_ACCESS_MODE_ANY:
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 136)                val=
ue =3D 1;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 137)                bre=
ak;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 138)        case OFONO_=
RADIO_ACCESS_MODE_GSM:
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 139)                val=
ue =3D 0;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 140)                bre=
ak;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 141)        case OFONO_=
RADIO_ACCESS_MODE_UMTS:
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 142)                val=
ue =3D 2;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 143)                bre=
ak;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 144)        default:
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 145)                CAL=
LBACK_WITH_FAILURE(cb, data);
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 146)                g_f=
ree(cbd);
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 147)                ret=
urn;
ac63fd95 (Marcel Holtmann 2010-09-23 23:27:08 +0900 148)        }

30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 133)        switch (mod=
e) {
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 134)        case OFONO_=
RADIO_ACCESS_MODE_ANY:
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 135)                val=
ue =3D 5;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 136)                bre=
ak;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 137)        case OFONO_=
RADIO_ACCESS_MODE_GSM:
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 138)                val=
ue =3D 0;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 139)                bre=
ak;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 140)        case OFONO_=
RADIO_ACCESS_MODE_UMTS:
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 141)                val=
ue =3D 1;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 142)                bre=
ak;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 143)        default:
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 144)                CAL=
LBACK_WITH_FAILURE(cb, data);
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 145)                g_f=
ree(cbd);
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 146)                ret=
urn;
30b054d0 (Marcel Holtmann 2010-06-06 15:18:57 -0700 147)        }

Sorry, couldn't resist. ;-)

Br,

	MikaL

--===============0750714970936731400==--

