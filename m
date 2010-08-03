Content-Type: multipart/mixed; boundary="===============7755619509015807056=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Add CDMA/EVDO into TODO
Date: Mon, 02 Aug 2010 22:30:19 -0700
Message-ID: <1280813419.12579.78.camel@localhost.localdomain>
In-Reply-To: <52CF90264091A14888078A031D780F43060FCB01@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7755619509015807056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Penghuo,

I am not fully against submitting patches as attachments, but if you do
expect reviews, then we do prefer inline patches. I would advise to
start using git send-email for patch submission.

> From 9af61f4d2546ff28a8b1ed9546c41f5f3c945f5a Mon Sep 17 00:00:00 2001
> From: Pengzhuo wang <pengzhuo.wang0@windriver.com>
> Date: Tue, 3 Aug 2010 19:53:32 +0800
> Subject: [PATCH] Update TODO to add CDMA/EVDO support
> =

> ---
>  TODO |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 5221324..b9130d3 100644
> --- a/TODO
> +++ b/TODO
> @@ -567,3 +567,28 @@ Miscellaneous
>  =

>    Priority: High
>    Complexity: C1
> +
> +CDMA/EVDO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Extend modem interface with a 'Type' property to indicate the modem
> type. =

> +
> +  Priority: High
> +  Complexity: C1

We need to discuss this with Denis. Either we do it here on the mailing
list or on #ofono IRC channel on Freenode.

> +- Disable CDMA unsupport feature for CDMA modem. Include USSD,
> supplementary services, =

> +  SSN, PDP context.  =

> +  =

> +  Priority: High
> +  Complexity: C2

Actually this is not a TODO item. That is a modem plugin specific
detail. If your modem (CDMA or not) doesn't supports such features, then
don't enable the atoms for it.

So I say that this already supported ;)

> +- Add call forwarding, call waiting, network registration
> implementation for CDMA.
> +  =

> +  Priority: High
> +  Complexity: C4

This is more like add CDMA specific atom drivers for netreg etc. That
these are CDMA specific is more a minor detail.

I like to hear Denis comment on his, but first guess would be that this
should be done as drivers/cdmamodem/...

> +- Change radio setting, SIM manager, SMS manager, voice call manager,
> Data Connection
> +  Manager to make them support both GSM and CDMA
> +  =

> +  Priority: High
> +  Complexity: C8

I think you have to be a bit more specific here. Maybe it is a good idea
to split them into separate items.

Regards

Marcel



--===============7755619509015807056==--

