Content-Type: multipart/mixed; boundary="===============3403137255750260390=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 15:21:08 -0500
Message-ID: <201004201521.08399.denkenz@gmail.com>
In-Reply-To: <h2kfb249edb1004201233lf8c2807en734f9ee8d40daeff@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3403137255750260390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi Denis,
> =

> On 15 April 2010 23:48, Denis Kenzior <denkenz@gmail.com> wrote:
> > The terminal response goes something like this:
> >> +
> >> +     len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
> >> +                     10 + length * 2, length);
> >> +
> >> +     for (; length; length--)
> >> +             len +=3D sprintf(buf + len, "%02hhX", *value++);
> >> +
> >
> > In the new stk envelope code it goes something like this:
> >> +     len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
> >> +                     12 + length * 2, length);
> >> +
> >> +     for (; length; length--)
> >> +             len +=3D sprintf(buf + len, "%02hhX", *command++);
> >> +
> >> +     len +=3D sprintf(buf + len, "FF");
> >
> > What is the point of this last 'FF'?  The code removed from the sim atom
> > driver doesn't have it either...
> =

> Rereading the etsi ts102.221 the "Le" field in the Envelope APDU
> (11.2.2.2) is not explictly defined "not present", instead it says
> "empty or maximum length of expected data".  It doesn't say what the
> default value is when empty so I conclude it's safer to have the field
> present or the card may think it's not allowed to send any response at
> all -- depending on the implementer's interpretation of the spec.
> =

> 10.1.6 says the field is the maximum respose length expected, but then
> some commands suggest it should be the exact length wanted and some
> make the field obligatory.

So I re-read that part of the spec, and I can see why we might want it.  =

However, this quote seemed rather interesting: "Le set to '00' indicates th=
at =

the terminal expects to receive at most the maximum number of bytes, i.e. 2=
56, =

in the response ADPU. The UICC may return any number of bytes in the range =
1 =

to 256."

Shouldn't that 'FF' be changed to '00'?  Also, you might want to include th=
e =

relevant passage or Spec/Section reference in this code so we don't wonder =

where it came from in the future.

Regards,
-Denis

--===============3403137255750260390==--

