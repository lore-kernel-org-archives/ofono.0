Content-Type: multipart/mixed; boundary="===============8509493892085800491=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: vendor models and options
Date: Sat, 15 Sep 2018 15:52:04 -0500
Message-ID: <d0d41734-9982-da27-ab4f-1437443bbfa8@gmail.com>
In-Reply-To: <CAKSBH7G1zTuDNVaqGNXSgcSpSjrH3N26dkiaMsoiTc1Rm+DY_w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8509493892085800491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> yes, CGAUTH can be queried, but there is no fallback command in case it =

> fails, so it has to be pre-defined based on the model used.

You might have to show me more specifics.  I don't see why we couldn't =

query +CGAUTH=3D? in all cases and if it isn't supported, fall back to =

vendor specific commands?

> No query commands would not return the name of the parameters, which in =

> this case is the only difference between username and password.

That's too bad.  Some vendors define a different length for username / =

password, so you could guess the order by which lengths are returned. =

Others use weird strings with password or username in the '=3D?' response.

However, since you likely want to use a vendor specific gprs-context =

driver anyway, this really shouldn't be that big of a deal.

> =

> I am introducing a specific gprs-context for some models, using atmodem =

> for others, and mbim and qmi for other models.
> I try to stick to gprs (not gprs-context) for most of them, because this =

> is pretty much the same for most of them. For some models that have a =

> lot of differences we are going to use specific atoms.
> We use the same code for the lte atom as well, unless there is a way to =

> factorize it.

It is generally quite easy to share things between AT command based =

drivers.  See drivers/atmodem/atutil.[ch].

Also, you might want to start by submitting a small subset of changes =

you have pending as a trial run to get comfortable with the overall =

development process, patch reviews, resubmissions, etc.

Regards,
-Denis

--===============8509493892085800491==--

