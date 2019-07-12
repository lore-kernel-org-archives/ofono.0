Content-Type: multipart/mixed; boundary="===============3576277878618468606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 6/9] quectel: support gpio to power on/off the modem
Date: Fri, 12 Jul 2019 10:54:03 -0500
Message-ID: <e7d5c834-9b37-4433-2ccf-9ff88c5f7da7@gmail.com>
In-Reply-To: <20190710215148.78083-7-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3576277878618468606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/10/19 4:51 PM, Martin Hundeb=C3=B8ll wrote:
> This adds support for configuring a gpio in udev to control the modem
> power.
> =

> To enable gpio control, specify OFONO_QUECTEL_GPIO_CHIP and
> OFONO_QUECTEL_GPIO_OFFSET in the udev environment, for example:
> =

> KERNEL=3D=3D"ttymxc0", ENV{OFONO_DRIVER}=3D"quectel", \
>          ENV{OFONO_QUECTEL_GPIO_CHIP}=3D"gpiochip2", \
>          ENV{OFONO_QUECTEL_GPIO_OFFSET}=3D"26"
> ---
> =

> Changes since v2:
>   * fix memleak in quectel_probe_gpio()
>   * expand comment to g_at_chat_set_wakeup_command()
> =

>   plugins/quectel.c | 84 +++++++++++++++++++++++++++++++++++++++++++----
>   plugins/udevng.c  | 10 +++++-
>   2 files changed, 87 insertions(+), 7 deletions(-)

The built-in ell sources were missing gpio.[ch], so I added a commit for =

that.  Also fixed a few > 80 chars / line issues.

Applied, thanks.

Regards,
-Denis


--===============3576277878618468606==--

