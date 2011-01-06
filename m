Content-Type: multipart/mixed; boundary="===============4376564671435909248=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 13:02:33 +0100
Message-ID: <AANLkTimxkKAjcEdS9hGLECWEaW4o+ygPU3RCikFpcK0i@mail.gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9C123E86@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4376564671435909248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,
...
> +static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 idmap_take(gprs->cid_map, id);
> +}
> +
How do we assure that this CID is not already in use?
I think the M7400 is going to use CID=3D0 and M700 uses CID=3D1.
Perhaps we should make sure CID=3D0 is a legal value and reserve CID 0
and 1 at start up.

There is probably other ways of handling this as well, but I think any
other solution
would end up with race conditions, as context could be initiated from
two sources.

Regards,
Sjur

--===============4376564671435909248==--

