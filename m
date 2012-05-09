Content-Type: multipart/mixed; boundary="===============0518155842742473948=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] doc: Update service-api doc to match the code
Date: Wed, 09 May 2012 10:20:42 -0700
Message-ID: <1336584042.5970.177.camel@aeonflux>
In-Reply-To: <1336567936-4624-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0518155842742473948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

> GetMessages method has no argument and the implementation does not
> return any error.
> =

> ---
>  doc/service-api.txt |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> =

> diff --git a/doc/service-api.txt b/doc/service-api.txt
> index 46989f4..d87644b 100644
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -16,8 +16,6 @@ Methods		array{object,dict} GetMessages()
>  			and removal shall be monitored via MessageAdded and
>  			MessageRemoved signals.
> =

> -			Possible Errors: [service].Error.InvalidArguments
> -

actually this error is valid. For example in case you call GetMessages
with an argument. So the error should stay.

Regards

Marcel



--===============0518155842742473948==--

