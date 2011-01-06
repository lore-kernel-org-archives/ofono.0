Content-Type: multipart/mixed; boundary="===============1929400143905013596=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
 4.5.1
Date: Thu, 06 Jan 2011 09:44:47 -0800
Message-ID: <1294335887.2501.7.camel@aeonflux>
In-Reply-To: <1294310006-14285-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1929400143905013596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>  src/call-forwarding.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 512f223..36ba4f1 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -246,7 +246,7 @@ static gboolean is_cfu_enabled(struct ofono_call_forw=
arding *cf,
>  static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
>  {
>  	gboolean cfu_voice;
> -	struct ofono_call_forwarding_condition *cond;
> +	struct ofono_call_forwarding_condition *cond =3D NULL;
>  =

>  	cfu_voice =3D is_cfu_enabled(cf, &cond);

I really hate trying to fix compiler warnings like this.

        /*
         * For now we only support Voice, although Fax & all Data
         * basic services are applicable as well.
         */
        for (; l; l =3D l->next) {
                cond =3D l->data;

                if (cond->cls > BEARER_CLASS_VOICE)
                        continue;

                if (out)
                        *out =3D cond;

                return TRUE;
        }

        return FALSE;

So this is clearly a false positive. The only why this would fail is
when l->data is NULL, but even then cond is initialized properly.

Regards

Marcel



--===============1929400143905013596==--

