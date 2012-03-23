Content-Type: multipart/mixed; boundary="===============3403588645098881746=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/6] service: remove dead file
Date: Fri, 23 Mar 2012 11:37:04 -0700
Message-ID: <1332527824.1870.43.camel@aeonflux>
In-Reply-To: <1332521141-31865-2-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3403588645098881746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastien,

> ---
>  src/service.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index ef6b544..3fdf4e0 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -755,6 +755,7 @@ static DBusMessage *send_message(DBusConnection *conn,
>  		release_attachement_data(msg->attachments);
>  		mms_message_free(msg);
>  =

> +		unlink(request->data_path);
>  		mms_request_destroy(request);

the commit message makes no sense to me. Why is this a "dead" file now?

Regards

Marcel



--===============3403588645098881746==--

