Content-Type: multipart/mixed; boundary="===============2986353487853178538=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/4] This patch add support for SIM900 GSM module
Date: Wed, 11 Jan 2012 23:52:52 -0600
Message-ID: <4F0E7534.40307@gmail.com>
In-Reply-To: <1326371542-29964-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2986353487853178538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 01/12/2012 06:32 AM, r.r.zaripov(a)gmail.com wrote:
> From: Renat Zaripov <r.r.zaripov@gmail.com>
> =

> This patch add support for SIM900 GSM module
> http://wm.sim.com/Sim/FrontShow_en/wireless/detail.aspx?cid=3D6&nid=3D770
> =

> ---
>  Makefile.am      |    3 +
>  plugins/sim900.c |  261 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 264 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/sim900.c
> =

> v4: Adding vendor quirk OFONO_VENDOR_SIM900
> cleanup whitespaces
> =


I went ahead and applied all four patches with some minor whitespace /
style cleanups.  I have also renamed OFONO_VENDOR_SIM900 to
OFONO_VENDOR_SIMCOM to be more in line with our historical naming.

The plugin might need to be called simcom.c, but I leave this as is for now.

Thanks!

Regards,
-Denis

--===============2986353487853178538==--

