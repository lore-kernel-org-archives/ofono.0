Content-Type: multipart/mixed; boundary="===============3865955469630551485=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] ubloxmodem: intialize and register the netmon driver
Date: Tue, 29 Nov 2016 10:53:18 -0600
Message-ID: <583DB27E.3040403@gmail.com>
In-Reply-To: <1480082415-30822-5-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3865955469630551485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
> From: Djalal Harouni <djalal@endocode.com>
>
> This patch allows to intialize and register the ublox netmon driver.
> ---
>   drivers/ubloxmodem/ubloxmodem.c | 2 ++
>   drivers/ubloxmodem/ubloxmodem.h | 3 +++
>   plugins/ublox.c                 | 3 +++
>   3 files changed, 8 insertions(+)
>

This patch isn't broken down properly.  See HACKING, 'Submitting =

patches' section.  Each top-level directory change should be in a =

separate patch.  E.g. one patch for drivers/* and one patch for plugins/*.

It might be easier to simply squash drivers/ubloxmodem/ubloxmodem.[ch] =

changes into patch 3.

Regards,
-Denis

--===============3865955469630551485==--

