Content-Type: multipart/mixed; boundary="===============6231856842276780821=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/6] doc: Modify SendMessage D-Bus API
Date: Mon, 25 Jun 2012 00:10:44 -0700
Message-ID: <1340608244.29898.5.camel@aeonflux>
In-Reply-To: <1339509855-7467-3-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6231856842276780821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  doc/service-api.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/service-api.txt b/doc/service-api.txt
> index 36e1161..57e8942 100644
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -36,7 +36,8 @@ Methods		array{object,dict} GetMessages()
>  			Possible Errors: [service].Error.InvalidArguments
>  					 [service].Error.TransientFailure
>  =

> -		object SendMessage(array{string} recipients, string smil,
> +		object SendMessage(array{string} recipients,
> +					boolean delivery-report, string smil,
>  					array{string id, string content-type,
>  							string filename})

I think we should do it the same as we do for oFono. Make this is global
settings. Since you don't do that on a per message basis anyway.

Regards

Marcel



--===============6231856842276780821==--

