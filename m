Content-Type: multipart/mixed; boundary="===============0518511809616032130=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ubloxmodem: add Toby L2 gprs context driver
Date: Thu, 17 Mar 2016 10:59:22 -0500
Message-ID: <56EAD45A.1090507@gmail.com>
In-Reply-To: <1458229430-31435-2-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0518511809616032130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/17/2016 10:43 AM, Dragos Tatulea wrote:
> For now the driver works only with bridged mode for 2G/3G.
>
> Once it activates the context it reads the ip, netmask,
> gw, dns and sets them in the context settings.
> ---
>   Makefile.am                       |   7 +
>   drivers/ubloxmodem/gprs-context.c | 401 +++++++++++++++++++++++++++++++=
+++++++
>   drivers/ubloxmodem/ubloxmodem.c   |  49 +++++
>   drivers/ubloxmodem/ubloxmodem.h   |  25 +++
>   4 files changed, 482 insertions(+)
>   create mode 100644 drivers/ubloxmodem/gprs-context.c
>   create mode 100644 drivers/ubloxmodem/ubloxmodem.c
>   create mode 100644 drivers/ubloxmodem/ubloxmodem.h
>

Applied, thanks.

Regards,
-Denis


--===============0518511809616032130==--

