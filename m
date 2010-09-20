Content-Type: multipart/mixed; boundary="===============1423606629426559971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono gprs_primary_context description
Date: Mon, 20 Sep 2010 07:49:48 -0500
Message-ID: <4C97586C.8000801@gmail.com>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A09201AA8517@renesas4bis.renesas-rdf.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1423606629426559971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On 09/20/2010 04:20 AM, Laurent THOMAS wrote:
> Hi,
> =

>  =

> =

> According to the interface org.ofono.ConnectionContext description, the
> property =E2=80=9CName=E2=80=9D is a free short string used to describe t=
he context.
> =

> Extract from =E2=80=9Cconman-api.txt=E2=80=9D
> =

> /Properties         string Name [readwrite]/
> =

> / /
> =

> /                                   The name is a free form string that
> describes this/
> =

> /                                   context.  The name should not be
> empty and limited/
> =

> /                                   to a short string for display purpose=
s./
> =

>  =

> =

> But according to source code (version 0.28), this attribute is now only
> affected with the context String Type (=E2=80=9Cinternet=E2=80=9D, =E2=80=
=9Cwap=E2=80=9D or =E2=80=9Cmms=E2=80=9D)
> =

>  =

> =

> is it really the expected behaviour or did I miss something ?

By default the Name is set to the context type.  E.g. creating an
"internet" context results in the name being set to "internet."  You can
still reset the Name later to whatever you wish.

~/ofono-master$ test/list-contexts
[ /phonesim ]
    [ /phonesim/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Foobar
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D
        Password =3D
        Type =3D internet


Regards,
-Denis

--===============1423606629426559971==--

