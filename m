Content-Type: multipart/mixed; boundary="===============1380045032294442154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 4/7] ubloxmodem: add the netmon driver
Date: Thu, 01 Dec 2016 11:29:06 -0600
Message-ID: <58405DE2.7060007@gmail.com>
In-Reply-To: <1480600793-24788-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1380045032294442154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 12/01/2016 07:59 AM, Djalal Harouni wrote:
> This adds a netmon driver for ublox. The driver support both +COPS and
> +CESQ commands to return the previously added ofono netmon types:
>
> RSCP: Received Signal Code Power
> ECN0: Received Energy Ratio
> RSRQ: Reference Signal Received Quality
> RSRP: Reference Signal Received Power
>
> Current revision makes the driver use ref countig when chaining multiple
> AT commands.
> ---
>   drivers/ubloxmodem/netmon.c     | 352 +++++++++++++++++++++++++++++++++=
+++++++
>   drivers/ubloxmodem/ubloxmodem.c |   2 +
>   drivers/ubloxmodem/ubloxmodemn.h |   3 +
>   3 files changed, 357 insertions(+)
>   create mode 100644 drivers/ubloxmodem/netmon.c
>

Applied.  Also applied v3 patch 5 & 6.

I pushed out a couple of small patches afterwards to clean up this =

version.  Please have a look and make sure I didn't screw anything up.

Regards,
-Denis

--===============1380045032294442154==--

