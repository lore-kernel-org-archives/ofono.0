Content-Type: multipart/mixed; boundary="===============9215394529026196574=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4] atmodem: Poll SIM state after having entered PIN
Date: Wed, 18 Apr 2012 04:22:51 -0500
Message-ID: <4F8E87EB.20206@gmail.com>
In-Reply-To: <1334752788-5597-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9215394529026196574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/18/2012 07:39 AM, Guillaume Zajac wrote:
> We encountered the problem of CME ERROR 14: SIM busy on ZTE modems.
> ZTE modems don't use SIM notification to check SIM state.
> We poll SIM ready state before confirming PIN is entered.
> ---
>  drivers/atmodem/sim.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============9215394529026196574==--

