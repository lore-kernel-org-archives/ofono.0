Content-Type: multipart/mixed; boundary="===============7456712628336617867=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: automatically retrieve the apn for a network
Date: Tue, 10 Dec 2019 20:05:11 +0100
Message-ID: <CAKSBH7FMu6URnLDdToSdkrU08AaGc6yQ9JyL-pJeaqN2onGxHQ@mail.gmail.com>
In-Reply-To: <CABPh3UOH_3wctPiEOjQjZNYh46oXKNkwr3rz+U9vZdVSbcQwUQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7456712628336617867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,


On Tue, Dec 10, 2019 at 7:35 PM nick83ola <nick83ola@gmail.com> wrote:
>
> Hi Giacinto,
>
> thanks for your email.
> Is not possible either to get it from the SIM card itself?

yes, this is exactly the property you mentioned earlier:
org.ofono.AllowedAccessPoints

but in general is not populated in the SIM. You can also see this in
the apdu answer you posted below:
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF


BR,
Giacinto
--===============7456712628336617867==--

