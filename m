Content-Type: multipart/mixed; boundary="===============8135442760763567734=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] util: Fix GSM to UTF8 conversion mechanism
Date: Wed, 18 Jul 2012 14:31:25 +0200
Message-ID: <1342614685.24426.5.camel@aeonflux>
In-Reply-To: <50066E69.108@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8135442760763567734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >>>> + /*
> >>>> + * According to the 3GPP specifications 23.038
> >>>> + * section 6.2.1.1:
> >>>> + * In the case there is no character in the extension
> >>>> + * table, the character of the main default alphabet
> >>>> + * table or the character from the National Language
> >>>> + * Locking Shift Table should be displayed.
> >>>> + */
> >>>
> >>> What version of 23.038 are you using? I cannot find such wording in R9
> >>> or R10 specs.
> >>
> >> It is not the exact wording, I have just rephrased the comment.
> >> The exact wording it just below the GSM 7 bits default alphabet
> >> extension table in section 6.2.1.1
> >> Generally, do you prefer having an exact extract of the 3GPP spec or
> >> just an explanation of what is happening?
> >>
> >
> > The preference is to quote the spec verbatim and enclose the quote in =

> > "".  You can quote fragments of a sentence, etc.
> >
> > You can paraphrase, but I prefer that we only do that to distill =

> > something simple, e.g. maximum size of a structure/member.
> >
> =

> Ok, I keep his in mind for the next patches.

and can someone please run the unit tests if we are touching this:

/testutil/Invalid Conversions: **
ERROR:unit/test-util.c:362:test_invalid: assertion failed: (res =3D=3D NULL)
Aborted (core dumped)

Regards

Marcel



--===============8135442760763567734==--

