Content-Type: multipart/mixed; boundary="===============5260506086893932510=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 10:33:28 -0300
Message-ID: <1278509608.2789.123.camel@localhost.localdomain>
In-Reply-To: <AANLkTiklQhayPAhums1pWVC43_u_GUYiyDJzEQifik7H@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5260506086893932510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> I just did some emergency calls in our lab with the Ericsson MBM modem
> (3507g). The modem firmware has the voice calls enabled, even while
> there is no audio input/output from the modem (as far as I know).
> =

> Main results are:
> - emergency calls are not possible in offline mode (CFUN=3D4), ATD112;
> returns NO DIALTONE
> - emergency calls can be made without SIM card (but they require AT+CFUN=
=3D1)
> - most MBM modem functionality (AT+COPS, AT+CLCC does not work without SI=
M card)
> - emergency calls cannot be handled with usual AT+CHLD commands (e.g.,
> AT+CHLD=3D11 does not hang up emergency calls)
>   (ofono cannot hangup emergency call and it does not notice when it ends)
> - emergency call gets number "112" and type 128 (unknown type of
> number and numbering plan)

thanks for testing this. However I am not sure how representative these
tests are since we are basically dealing with data-only modem. I know
that the MBM in theory can support some sort of voice calls, but for the
currently on the market MBM devices, that support might not be tested at
all or being proper certified.

So I think we need to get some feedback from the Ericsson guys and how
this is suppose to work (or maybe not work).

Regards

Marcel



--===============5260506086893932510==--

