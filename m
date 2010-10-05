Content-Type: multipart/mixed; boundary="===============1268273347543224815=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] sms: fix type error
Date: Tue, 05 Oct 2010 13:53:39 +0200
Message-ID: <1286279619.17473.75.camel@aeonflux>
In-Reply-To: <1286275075-31292-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1268273347543224815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  src/sms.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index b7051b9..aee9a61 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -69,7 +69,7 @@ struct ofono_sms {
>  	struct sms_assembly *assembly;
>  	guint ref;
>  	GQueue *txq;
> -	gint tx_source;
> +	guint tx_source;
>  	struct ofono_message_waiting *mw;
>  	unsigned int mw_watch;
>  	struct ofono_sim *sim;

good catch. Patch has been applied. Thanks.

Regards

Marcel



--===============1268273347543224815==--

