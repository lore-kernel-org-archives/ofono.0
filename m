Content-Type: multipart/mixed; boundary="===============6350671033450907386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 15:55:33 -0500
Message-ID: <201004201555.33596.denkenz@gmail.com>
In-Reply-To: <l2tfb249edb1004201348re351d92bre2347973abd7d9c3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6350671033450907386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > So I re-read that part of the spec, and I can see why we might want it.
> > However, this quote seemed rather interesting: "Le set to '00' indicates
> > that the terminal expects to receive at most the maximum number of byte=
s,
> > i.e. 256, in the response ADPU. The UICC may return any number of bytes
> > in the range 1 to 256."
> >
> > Shouldn't that 'FF' be changed to '00'?  Also, you might want to include
> > the relevant passage or Spec/Section reference in this code so we don't
> > wonder where it came from in the future.
> =

> Attached patch adds a comment and changes the FF to 00.  I guess it is
> largely theoretical right now.  The issue again with "any number of
> bytes in the range 1 to 256" is that this prohibits an empty response,
> which we want to allow too :)   Maybe this should be a parameter of
> driver->envelope()

"The maximum number of bytes expected in the data part of the response APDU=
 is =

presented in the parameter Le, which is optional. This means that if the =

terminal does not expect any data in the response APDU Le is absent from th=
e =

command"

The question really becomes, do we actually want a response and know what t=
o =

do with it?

Regards,
-Denis

--===============6350671033450907386==--

