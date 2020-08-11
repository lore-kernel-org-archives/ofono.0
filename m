Content-Type: multipart/mixed; boundary="===============0529212690138014924=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] Add a vendor OFONO_VENDOR_QUECTEL_EC2X
Date: Tue, 11 Aug 2020 10:51:57 -0500
Message-ID: <fe68a715-440f-887c-f841-6bdb14f2ee69@gmail.com>
In-Reply-To: <20200811114217.370049-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0529212690138014924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/11/20 6:42 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The distinction between OFONO_VENDOR_QUECTEL and
> OFONO_VENDOR_QUECTEL_SERIAL does not suffice for EC21/EC25 in some
> places, so introduce and use a new vendor:
> OFONO_VENDOR_QUECTEL_EC2X
> ---
>   drivers/atmodem/sim.c       | 1 +
>   drivers/atmodem/sms.c       | 2 ++
>   drivers/atmodem/vendor.h    | 1 +
>   drivers/atmodem/voicecall.c | 3 ++-
>   plugins/quectel.c           | 2 +-
>   5 files changed, 7 insertions(+), 2 deletions(-)
> =


Patch 1 & 2 applied with minor style cleanups.

Regards,
-Denis

--===============0529212690138014924==--

