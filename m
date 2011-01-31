Content-Type: multipart/mixed; boundary="===============8664708892183172695=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 12:06:45 +0200
Message-ID: <1296468405.1662.67.camel@miia-desktop>
In-Reply-To: <1296467266.1520.189.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8664708892183172695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Marcel,

> > +- Add support for setting the SMS Validity Period (3GPP 23.040). Curre=
ntly the
> > +  value is hard coded as 24 hours.
> =

> didn't we actually change this to be the maximum value?

Only place I could find this to be edited was following line in
smsutil.c (3421)

  template.submit.vp.relative =3D 0xA7; /* 24 Hours */

Have I missed something then?

In any case, I'd rather see the value something that API allows to set
instead of hard coded value, as user can have different needs for the
SMS validity period and sometimes it is not the best thing either that
period is set to maximum. =


BR,
Miia

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



--===============8664708892183172695==--

