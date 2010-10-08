Content-Type: multipart/mixed; boundary="===============2073789779240632354=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 3/4] radio settings: document FastDormancy property
Date: Fri, 08 Oct 2010 08:56:20 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7CE20A82@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1286465668.6145.155.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2073789779240632354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> so how does the future prediction is suppose to work. Are we =

> shipping a
> time machine together with oFono ;)

I would say the heuristic is system dependent. Typical way would be to moni=
tor events from different input devices. If no events arrive for a specifie=
d time the user is assumed to be inactive. The user might also have some ex=
plicit way to do this, such as locking the display and keys.

	MikaL

--===============2073789779240632354==--

