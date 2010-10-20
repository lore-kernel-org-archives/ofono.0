Content-Type: multipart/mixed; boundary="===============8341128556694494106=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: A way of polling SIM status
Date: Wed, 20 Oct 2010 16:21:49 +0300
Message-ID: <AANLkTinUHKokaYjfc=jg0tmf+PSwSk7bbOr0FsgzpZom@mail.gmail.com>
In-Reply-To: <4CBDE333.7090605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8341128556694494106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

2010/10/19 Denis Kenzior <denkenz@gmail.com>:
> Unfortunately some modems report CPIN: READY even though they're not
> ready. =C2=A0The only reliable way to poll for this is to poll the IMSI, =
then
> the phonebook and the sms store and report ready only once all of them
> can be manipulated.

I seems to me that Caiwen is proposing SIM presence polling. Each and
every modem does it now separately. Unfortunately this seems to be
even trickier than PIN lock polling, at least MBM returns different
error codes depending on how far its own initialization has got.

-- =

Pekka.Pessi mail at nokia.com

--===============8341128556694494106==--

