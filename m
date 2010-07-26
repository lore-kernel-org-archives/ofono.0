Content-Type: multipart/mixed; boundary="===============0869034411911972802=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 08/20] sms: document the org.ofono.SMSMessage D-Bus
 interface
Date: Mon, 26 Jul 2010 13:41:37 -0700
Message-ID: <1280176897.26204.175.camel@localhost.localdomain>
In-Reply-To: <4C4DCE82.7090700@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0869034411911972802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-07-26 at 11:05 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> >>> +SMS / Messaging interface
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> +
> >>> +Service		org.ofono
> >>> +Interface	org.ofono.SMSMessage
> >>
> >> oFono API is full CamelCase, so this should be SmsMessage.
> > =

> > I disagree. It would be like that if SMS was a word, but it is an
> > acronym. It makes it quite confusing, if you ask me. If that's still how
> > you like it, I'll change it, but I think it is wrong to capitalize an
> > acronym.
> > =

> =

> Your objection has been noted.  However, pure camel case looks nicer and
> that is how most of the API already is (e.g. SmsManager, SimManager,
> UnlockPin, etc)  So please change it or name it simply 'Message'.

Changed to SmsMessage as discussed over IRC.


--===============0869034411911972802==--

