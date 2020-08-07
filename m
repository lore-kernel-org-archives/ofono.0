Content-Type: multipart/mixed; boundary="===============9006204237257808154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Add a vendor OFONO_VENDOR_QUECTEL_EC2X
Date: Fri, 07 Aug 2020 11:09:19 -0500
Message-ID: <62d7c37e-8cb9-3929-67aa-bf25de21d663@gmail.com>
In-Reply-To: <20200804123849.909105-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9006204237257808154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/4/20 7:38 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The distinction between OFONO_VENDOR_QUECTEL and
> OFONO_VENDOR_QUECTEL_SERIAL does not suffice for EC21/EC25 in some
> places, so introduce and use a new vendor:
> OFONO_VENDOR_QUECTEL_EC2X
> ---
>   drivers/atmodem/lte.c       | 2 +-
>   drivers/atmodem/sim.c       | 1 +
>   drivers/atmodem/sms.c       | 2 ++
>   drivers/atmodem/vendor.h    | 1 +
>   drivers/atmodem/voicecall.c | 3 ++-
>   plugins/quectel.c           | 2 +-
>   6 files changed, 8 insertions(+), 3 deletions(-)
> =


This doesn't apply:
denkenz(a)localhost ~/ofono-master $ git am --3way ~/merge/\[PATCH\ 1_5\]\ =
Add\ a\ =

vendor\ OFONO_VENDOR_QUECTEL_EC2X.eml
Applying: Add a vendor OFONO_VENDOR_QUECTEL_EC2X
error: sha1 information is lacking or useless (drivers/atmodem/lte.c).
error: could not build fake ancestor
Patch failed at 0001 Add a vendor OFONO_VENDOR_QUECTEL_EC2X

The chunk in drivers/atmodem/lte.c doesn't look like upstream code at all.

Regards,
-Denis
--===============9006204237257808154==--

