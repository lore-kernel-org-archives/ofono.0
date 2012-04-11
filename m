Content-Type: multipart/mixed; boundary="===============8728821655912302954=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 1/2] service: remove files when unable to decode
 received msg
Date: Wed, 11 Apr 2012 20:29:26 +0200
Message-ID: <1334168966.16897.126.camel@aeonflux>
In-Reply-To: <1333720967-17878-2-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8728821655912302954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  src/service.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index f148252..851db34 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -984,7 +984,12 @@ static gboolean load_message_from_store(const char *=
service_id,
>  	if (mms_message_decode(pdu, len, msg) =3D=3D FALSE) {
>  		mms_error("Failed to decode %s", data_path);
>  		munmap(pdu, len);
> -		goto out;
> +		g_free(state);

are we not leaking data_path here?

> +
> +		mms_store_meta_close(service_id, uuid, meta, FALSE);
> +		mms_store_remove(service_id, uuid);
> +
> +		return FALSE;
>  	}

And why are we turning a perfect good label into something were we have
the label and also duplicated code. This is not a good idea.

Regards

Marcel



--===============8728821655912302954==--

