Content-Type: multipart/mixed; boundary="===============1159291242856113301=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 10/15] hfpmodem: Avoid segfault in network-registration
Date: Thu, 20 Oct 2011 12:59:56 -0500
Message-ID: <4EA0619C.7050707@gmail.com>
In-Reply-To: <1319128700-15841-11-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1159291242856113301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/20/2011 11:38 AM, Mikel Astiz wrote:
> The use of g_idle_add can cause a segmentation fault if the object is
> destroyed in the meantime.
> ---
>  drivers/hfpmodem/network-registration.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> =


Looks good to me, but please...

> diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/n=
etwork-registration.c
> index da7d8eb..6c27a23 100644
> --- a/drivers/hfpmodem/network-registration.c
> +++ b/drivers/hfpmodem/network-registration.c
> @@ -51,6 +51,7 @@ struct netreg_data {
>  	GAtChat *chat;
>  	unsigned char cind_pos[HFP_INDICATOR_LAST];
>  	int cind_val[HFP_INDICATOR_LAST];
> +	guint registration_event_id;

...name this 'register_source' to be more consistent with how oFono
names variables that store GSource ids.

Same comment applies to patch 11 and 12.

Regards,
-Denis

--===============1159291242856113301==--

