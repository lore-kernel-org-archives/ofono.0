Content-Type: multipart/mixed; boundary="===============1850181442068128456=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: Re: [PATCH] atmodem: Add MBM/STE quirk for SIM record update
Date: Mon, 28 Feb 2011 09:22:03 +0200
Message-ID: <1298877723.1616.7.camel@miia-desktop>
In-Reply-To: <1298448563-5033-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1850181442068128456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

On Wed, 2011-02-23 at 10:09 +0200, Miia Leinonen wrote:
> Fixed the <data> string to be set inside quotes for STE/MBM.
> =

> ---
> =

> Hi,
> =

> This fix has been tested with STE modem only due the lack of MBM HW.
> =

> Would it be possible that someone checks this with MBM modem? The problem=
 is =

> likely to appear also there - therefore OFONO_VENDOR_MBM used. Could fix =
this =

> also to cover all modems, but that might cause some backward compatibilit=
y =

> issues.
> =

> BR,
> Miia

Is this fix OK or should I use some other approach? No one seem to have
commented anything so far.

BR,
Miia



--===============1850181442068128456==--

