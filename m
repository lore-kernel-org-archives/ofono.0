Content-Type: multipart/mixed; boundary="===============6435314793248857749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim900: Using AT+SPIC for obtaining times remains input
 SIM PIN/PUK
Date: Wed, 22 Feb 2012 04:19:01 -0600
Message-ID: <4F44C115.9060506@gmail.com>
In-Reply-To: <1329913117-19530-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6435314793248857749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 02/22/2012 06:18 AM, r.r.zaripov(a)gmail.com wrote:
> From: Renat Zaripov <r.r.zaripov@gmail.com>
> =

> In SIMCOM SIM900 not implemented AT+CPINR, but possible use AT+SPIC
> instead this one.
> =

> AT+SPIC Times Remained to Input SIM PIN/PUK
> =

> +SPIC: <pin1>,<pin2>,<puk1>,<puk2>
> =

> Parameters
> <pin1> Times remained to input chv1
> <pin2> Times remained to input chv2
> <puk1> Times remained to input puk1
> <puk2> Times remained to input puk2
> ---
>  drivers/atmodem/sim.c |   45 +++++++++++++++++++++++++++++++++++++++++++=
++
>  plugins/sim900.c      |    2 +-
>  2 files changed, 46 insertions(+), 1 deletions(-)
> =


I broke this patch up into two, one for drivers/atmodem changes and one
for plugins/ changes.  Please refer to item 3) in 'Submitting patches'
section of the HACKING document.

I also re-worded the commit message slightly and applied the patch.

Thanks!

Regards,
-Denis

--===============6435314793248857749==--

