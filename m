Content-Type: multipart/mixed; boundary="===============1565147788783502497=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] mmsutil: add mms_message_status_get_string API
Date: Fri, 20 Apr 2012 18:44:11 +0200
Message-ID: <1334940251.16897.332.camel@aeonflux>
In-Reply-To: <1334939946-8835-2-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1565147788783502497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastien,

>  src/mmsutil.c |   25 +++++++++++++++++++++++++
>  src/mmsutil.h |    1 +
>  2 files changed, 26 insertions(+), 0 deletions(-)
> =

> diff --git a/src/mmsutil.c b/src/mmsutil.c
> index c507d6f..725849b 100644
> --- a/src/mmsutil.c
> +++ b/src/mmsutil.c
> @@ -1661,3 +1661,28 @@ gboolean mms_message_encode(struct mms_message *ms=
g, int fd)
>  =

>  	return FALSE;
>  }
> +
> +char *mms_message_status_get_string(enum mms_message_status status)
> +{
> +	char *status_str;
> +
> +	switch (status) {
> +	case MMS_MESSAGE_STATUS_DOWNLOADED:
> +		status_str =3D "downloaded";
> +		break;
> +	case MMS_MESSAGE_STATUS_RECEIVED:
> +		status_str =3D "received";
> +		break;
> +	case MMS_MESSAGE_STATUS_READ:
> +		status_str =3D "read";
> +		break;
> +	case MMS_MESSAGE_STATUS_SENT:
> +		status_str =3D "sent";
> +		break;
> +	case MMS_MESSAGE_STATUS_DRAFT:
> +		status_str =3D "draft";
> +		break;
> +	}
> +
> +	return status_str;
> +}

why bother with status_str here. Just call return right away. Also the
return value is const char *.

> diff --git a/src/mmsutil.h b/src/mmsutil.h
> index b2a0418..d3b507f 100644
> --- a/src/mmsutil.h
> +++ b/src/mmsutil.h
> @@ -146,3 +146,4 @@ gboolean mms_message_decode(const unsigned char *pdu,
>  				unsigned int len, struct mms_message *out);
>  gboolean mms_message_encode(struct mms_message *msg, int fd);
>  void mms_message_free(struct mms_message *msg);
> +char *mms_message_status_get_string(enum mms_message_status status);

Regards

Marcel



--===============1565147788783502497==--

