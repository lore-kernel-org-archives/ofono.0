Content-Type: multipart/mixed; boundary="===============1938359192555502309=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: list-modems patch
Date: Fri, 15 Oct 2010 12:09:26 +0300
Message-ID: <1287133766.3316.59.camel@aeonflux>
In-Reply-To: <1287133345.21789.0.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1938359192555502309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> > > > > > > Sometimes i see =

> > > > > > > =

> > > > > > > [root(a)alexander-desktop ofono-0.31]# /usr/lib/ofono/test/li=
st-modems =

> > > > > > > [ /huawei5 ]
> > > > > > >     Features =3D sim =

> > > > > > >     Powered =3D 1
> > > > > > >     Interfaces =3D org.ofono.Phonebook org.ofono.AudioSettings
> > > > > > > org.ofono.VoiceCallManager org.ofono.SimManager =

> > > > > > >     Online =3D 0
> > > > > > >     Model =3D E1550
> > > > > > >     Manufacturer =3D huawei
> > > > > > >     Serial =3D 353142033084081
> > > > > > >     Revision =3D 11.608.12.00.143
> > > > > > >     [ org.ofono.Phonebook ]
> > > > > > >     [ org.ofono.AudioSettings ]
> > > > > > > Traceback (most recent call last):
> > > > > > >   File "/usr/lib/ofono/test/list-modems", line 61, in <module>
> > > > > > >     print "        %s =3D %s" % (key, val).encode('ascii')
> > > > > > > =

> > > > > > > =

> > > > > > > Patch
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > diff --git a/test/list-modems b/test/list-modems
> > > > > > > index 557efd5..df1dca8 100755
> > > > > > > --- a/test/list-modems
> > > > > > > +++ b/test/list-modems
> > > > > > > @@ -58,6 +58,10 @@ for path, properties in modems:
> > > > > > >                                         ")" for text, icon in
> > > > > > > properties[key] ])
> > > > > > >                         else:
> > > > > > >                              	val =3D str(properties[key])
> > > > > > > -                       print "        %s =3D %s" % (key, val)
> > > > > > > +                       try:
> > > > > > > +                               print  "       %s =3D %s" % (=
key, val)
> > > > > > > +                       except:
> > > > > > > +                               continue
> > > > > > > +
> > > > > > =

> > > > > > can you at least print the key value. Just not printing that pr=
operty at
> > > > > > all is bad since it is there. Just marking the value as not pri=
ntable
> > > > > > seems to be the better approach.
> > > > > > =

> > > > > > Regards
> > > > > > =

> > > > > > Marcel
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > =

> > > > > Last fully-working script
> > > > > =

> > > > > [ /huawei0 ]
> > > > > =

> > > > > =

> > > > > del overquote
> > > > > =

> > > > >         ServiceNumbers =3D [=D0=9C=D0=BE=D0=B1. =D0=9F=D0=BE=D0=
=BC=D0=BE=D1=89=D0=BD=D0=B8=D0=BA] =3D '111' [MT=D0=A1] =3D
> > > > > '+78003330890' [=D0=A1=D0=BB=D1=83=D0=B6=D0=B1=D0=B0 =D1=81=D0=BF=
=D0=B0=D1=81=D0=B5=D0=BD=D0=B8=D1=8F] =3D '112' =

> > > > >         CardIdentifier =3D 89701012417666587513
> > > > >         LockedPins =3D =

> > > > >         PinRequired =3D none
> > > > >         SubscriberIdentity =3D 250011766658751
> > > > >         Present =3D 1
> > > > > =

> > > > > =

> > > > > [=D0=9C=D0=BE=D0=B1. =D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D0=BD=D0=B8=
=D0=BA] - in russian means "Mobile Partner"
> > > > > [=D0=A1=D0=BB=D1=83=D0=B6=D0=B1=D0=B0 =D1=81=D0=BF=D0=B0=D1=81=D0=
=B5=D0=BD=D0=B8=D1=8F] - rescue rangers :3           =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > diff --git a/test/list-modems b/test/list-modems
> > > > > index 557efd5..59765f9 100755
> > > > > --- a/test/list-modems
> > > > > +++ b/test/list-modems
> > > > > @@ -58,6 +58,10 @@ for path, properties in modems:
> > > > >                                         ")" for text, icon in
> > > > > properties[key] ])
> > > > >                         else:
> > > > >                                 val =3D str(properties[key])
> > > > > -                       print "        %s =3D %s" % (key, val)
> > > > > -
> > > > > +                       try:
> > > > > +                               print "        %s =3D %s" %
> > > > > (key.encode('utf8'), val.encode('utf8'))
> > > > > +                       except:
> > > > > +                               print "Cannot encode some charcte=
rs
> > > > > please change locale"
> > > > > +                       else:
> > > > > +                                continue
> > > > >         print
> > > > =

> > > > patch does not apply. Please always check with git am that your pat=
ch
> > > > would apply cleanly. And that your mailer doesn't screw it up.
> > > > =

> > > > Regards
> > > > =

> > > > Marcel
> > > > =

> > > > =

> > > > =

> > > =

> > > Evolution reformate message anyway
> > > Please click on link.
> > > Was checked and applied for me with success
> > > =

> > > http://pastie.org/pastes/1220422/text
> > =

> > I see a whitespace damage in the patch and it is still not possible to
> > apply this. Please send a proper patch to the mailing list. You do need
> > to get your email client fixed anyway.
> > =

> > Regards
> > =

> > Marcel
> > =

> > =

> > =

> =

> Patch verified with applying 2 times.
> File in attach.

if the patch does not apply with git am, it is not ready.

Regards

Marcel



--===============1938359192555502309==--

