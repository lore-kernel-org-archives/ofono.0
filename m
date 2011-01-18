Content-Type: multipart/mixed; boundary="===============2477359594292158063=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: Re: [RFC PATCH 0/3] Long phone numbers
Date: Tue, 18 Jan 2011 06:39:09 -0300
Message-ID: <20110118093908.GA20108@nodo3>
In-Reply-To: <AANLkTi=ZBdVALq+n4EOBMh-nMN2zkMbrzqOFvOor0ZhQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2477359594292158063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 17, 2011 at 11:18:51PM +0200, Pekka Pessi wrote:
> Hi Rafael,
> =

> 2011/1/17 Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>:
> > This is a proposal for the "long phone number" task (80 digits max leng=
th).
> > It changes OFONO_MAX_PHONE_NUMBER_LENGTH and splits
> > common:valid_phone_number_format(), to make sure long numbers are handl=
ed
> > appropriately for functions that need manage shorter numbers, like
> > numbers written to the SIM, or sms SCA.
> =

> Perhaps a validator and type for long phone numbers is better than for
> short numbers? I guess long numbers are mostly used when reporting an
> outgoing call back to oFono.

No completely sure if it is better. Maybe it is the same?. With a new
type for long number we will have modifications on other parts of the code
which use OFONO_MAX_PHONE_NUMBER_LENGTH. The first idea could be simpler
because we just have one type and would check for the format and length on =
the
proper places.
 =

> BTW, with call forwarding you could have numbers up to 16 digits or if
> longForwardedToNumber is supported (by modem and both home and visited
> networks) even 28 digits. See TS 29.002 for merry details.

Thanks for that. I am checking, and going to add an extra validator
surely.

Rafael Zurita

--===============2477359594292158063==--

