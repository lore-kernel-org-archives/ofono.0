Content-Type: multipart/mixed; boundary="===============1417957245120406983=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: list-modems patch
Date: Thu, 14 Oct 2010 11:45:18 +0300
Message-ID: <1287045918.3316.34.camel@aeonflux>
In-Reply-To: <1287045079.32351.3.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1417957245120406983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> Sometimes i see =

> =

> [root(a)alexander-desktop ofono-0.31]# /usr/lib/ofono/test/list-modems =

> [ /huawei5 ]
>     Features =3D sim =

>     Powered =3D 1
>     Interfaces =3D org.ofono.Phonebook org.ofono.AudioSettings
> org.ofono.VoiceCallManager org.ofono.SimManager =

>     Online =3D 0
>     Model =3D E1550
>     Manufacturer =3D huawei
>     Serial =3D 353142033084081
>     Revision =3D 11.608.12.00.143
>     [ org.ofono.Phonebook ]
>     [ org.ofono.AudioSettings ]
> Traceback (most recent call last):
>   File "/usr/lib/ofono/test/list-modems", line 61, in <module>
>     print "        %s =3D %s" % (key, val).encode('ascii')
> =

> =

> Patch
> =

> =

> =

> diff --git a/test/list-modems b/test/list-modems
> index 557efd5..df1dca8 100755
> --- a/test/list-modems
> +++ b/test/list-modems
> @@ -58,6 +58,10 @@ for path, properties in modems:
>                                         ")" for text, icon in
> properties[key] ])
>                         else:
>                              	val =3D str(properties[key])
> -                       print "        %s =3D %s" % (key, val)
> +                       try:
> +                               print  "       %s =3D %s" % (key, val)
> +                       except:
> +                               continue
> +

can you at least print the key value. Just not printing that property at
all is bad since it is there. Just marking the value as not printable
seems to be the better approach.

Regards

Marcel



--===============1417957245120406983==--

