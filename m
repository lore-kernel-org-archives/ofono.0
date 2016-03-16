Content-Type: multipart/mixed; boundary="===============6850084969244420764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] atmodem: add support for U-Blox TOBY L2 modems
Date: Wed, 16 Mar 2016 13:20:52 -0500
Message-ID: <56E9A404.90107@gmail.com>
In-Reply-To: <1457970664-20782-5-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6850084969244420764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/14/2016 10:50 AM, Dragos Tatulea wrote:
> Besides exceptions below, act like normal U-Blox devices.
>
> gprs-context: don't set auth for TOBY L2. U-Blox Toby L2
> doesn't support PAP/CHAP APN auth method.
>
> atmodem: TOBY L2 supports only CMER mode 1. Also chaged original
> mode variable to ind, which is a more appropriate name.
> mode is what is being set first.
> ---
>   drivers/atmodem/gprs.c                 |  1 +
>   drivers/atmodem/network-registration.c | 21 ++++++++++++++++-----
>   drivers/atmodem/sim.c                  |  1 +
>   3 files changed, 18 insertions(+), 5 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============6850084969244420764==--

