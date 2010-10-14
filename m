Content-Type: multipart/mixed; boundary="===============7760039531608794528=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: list-modems patch
Date: Thu, 14 Oct 2010 13:17:29 +0400
Message-ID: <1287047849.32351.16.camel@mezon.ru>
In-Reply-To: <1287045918.3316.34.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7760039531608794528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=A7=D1=82=D0=B2, 14/10/2010 =D0=B2 11:45 +0300, Marcel Holtmann =
=D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi Alex,
> =

> > Sometimes i see =

> > =

> > [root(a)alexander-desktop ofono-0.31]# /usr/lib/ofono/test/list-modems =

> > [ /huawei5 ]
> >     Features =3D sim =

> >     Powered =3D 1
> >     Interfaces =3D org.ofono.Phonebook org.ofono.AudioSettings
> > org.ofono.VoiceCallManager org.ofono.SimManager =

> >     Online =3D 0
> >     Model =3D E1550
> >     Manufacturer =3D huawei
> >     Serial =3D 353142033084081
> >     Revision =3D 11.608.12.00.143
> >     [ org.ofono.Phonebook ]
> >     [ org.ofono.AudioSettings ]
> > Traceback (most recent call last):
> >   File "/usr/lib/ofono/test/list-modems", line 61, in <module>
> >     print "        %s =3D %s" % (key, val).encode('ascii')
> > =

> > =

> > Patch
> > =

> > =

> > =

> > diff --git a/test/list-modems b/test/list-modems
> > index 557efd5..df1dca8 100755
> > --- a/test/list-modems
> > +++ b/test/list-modems
> > @@ -58,6 +58,10 @@ for path, properties in modems:
> >                                         ")" for text, icon in
> > properties[key] ])
> >                         else:
> >                              	val =3D str(properties[key])
> > -                       print "        %s =3D %s" % (key, val)
> > +                       try:
> > +                               print  "       %s =3D %s" % (key, val)
> > +                       except:
> > +                               continue
> > +
> =

> can you at least print the key value. Just not printing that property at
> all is bad since it is there. Just marking the value as not printable
> seems to be the better approach.
> =

> Regards
> =

> Marcel
> =

> =

> =


Little fix

diff --git a/test/list-modems b/test/list-modems
index 557efd5..f8f10ac 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -58,6 +58,12 @@ for path, properties in modems:
                                        ")" for text, icon in
properties[key] ])
                        else:
                                val =3D str(properties[key])
-                       print "        %s =3D %s" % (key, val)
+                       try:
+                               print  "       %s =3D %s" % (key, val)
+                       except:
+                               print "Script mesaage:maybe wrong ASCII
characters\n"
+                       else:
+                               continue
+

        print



--===============7760039531608794528==--

