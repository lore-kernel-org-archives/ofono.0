Content-Type: multipart/mixed; boundary="===============1126076525826084007=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] G1: Add an SMS quirk for CNMI mode
Date: Wed, 02 Sep 2009 19:06:53 -0700
Message-ID: <1251943613.1266.132.camel@localhost.localdomain>
In-Reply-To: <20090902215909.7b7a6c52@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1126076525826084007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> The G1 doesn't support mode2, despite advertising it.
> The G1 chokes w/ an "Error 303" when we specify NMI mode 2.  Adding a qui=
rk
> to drop that mode from the supported list (just use mode 1) allows the G1
> to properly deal with SMS.
> ---
>  drivers/atmodem/sms.c    |   19 ++++++++++++++-----
>  drivers/atmodem/vendor.h |    1 +
>  plugins/g1.c             |    3 +++
>  3 files changed, 18 insertions(+), 5 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============1126076525826084007==--

