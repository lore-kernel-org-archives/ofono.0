Content-Type: multipart/mixed; boundary="===============8201126734980292849=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/20] stkutil: Add the Call Control envelope builder
Date: Fri, 11 Jun 2010 14:34:35 -0500
Message-ID: <201006111434.35867.denkenz@gmail.com>
In-Reply-To: <AANLkTincE0TeBlPw8gnaNmOoRMK46USpW3XBHZ0aNWU6@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8201126734980292849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,


> >> +/* Used both in the ENVELOPE message to UICC and response from UICC */
> >> +struct stk_envelope_call_control {
> >> +     /* Exactly one of the following 5 fields must be present */
> >
> > Why are we not using a union then?
> =

> We don't know which one of 5 is valid if it's a union.  We could add a
> field to indicate that but I guess it's simpler the way it is.

It seems like a type + union might be better for the consumers of this =

structure though.  Otherwise they have to check up to 5 structs for emptine=
ss =

before figuring out what the type actually is.  Your call.

Regards,
-Denis

--===============8201126734980292849==--

