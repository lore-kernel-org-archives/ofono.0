Content-Type: multipart/mixed; boundary="===============1142528358638804027=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
 4.5.1
Date: Thu, 06 Jan 2011 17:54:32 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD34CC40B5@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294307171-13485-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1142528358638804027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using the old version of gcc 4.4.2 I did not meet the issue, but using 4.5.=
1, we have warning.

> -----Original Message-----
> From: Xu, Martin
> Sent: Thursday, January 06, 2011 5:46 PM
> To: ofono(a)ofono.org
> Cc: Xu, Martin; blutolan
> Subject: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo 4.=
5.1
> =

> From: blutolan <blutolan@blutolan-desktop.(none)>
> =

> ---
>  src/call-forwarding.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 512f223..36ba4f1 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -246,7 +246,7 @@ static gboolean is_cfu_enabled(struct
> ofono_call_forwarding *cf,
>  static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
>  {
>  	gboolean cfu_voice;
> -	struct ofono_call_forwarding_condition *cond;
> +	struct ofono_call_forwarding_condition *cond =3D NULL;
> =

>  	cfu_voice =3D is_cfu_enabled(cf, &cond);
> =

> --
> 1.7.2.2


--===============1142528358638804027==--

