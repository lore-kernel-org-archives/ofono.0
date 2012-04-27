Content-Type: multipart/mixed; boundary="===============2569318156615980057=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv1 5/5] doc: Update service-api.txt
Date: Fri, 27 Apr 2012 14:20:14 +0200
Message-ID: <1335529214.16897.462.camel@aeonflux>
In-Reply-To: <1335344513-2347-6-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2569318156615980057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  doc/service-api.txt |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/service-api.txt b/doc/service-api.txt
> index 46989f4..99e80be 100644
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -24,11 +24,18 @@ Methods		array{object,dict} GetMessages()
>  			that are part of a conversation between the service
>  			entity and the number provided.
> =

> +			The number parameter must only contains	significant digits

actually using "must" is a wrong description.
> +			to look for (i.e.: n last digits of the phone number), only
> +			messages with a recipient containing the given number will
> +			be part of the GetConversation result.

And I am not sure we do wanna make some sort of assumption here anyway.
These are not CLIP numbers where the operators don't seem to get this
right. For SMS and MMS is seems the international numbering plan is
used.

Or do you have counter examples. If so, please post them here first.

> +
>  			The count parameter can either be 0 for unlimited
>  			messages in the conversation or limit the conversation
>  			to count last messages.
> =

> -			Possible Errors: [service].Error.InvalidArguments
> +			Possible Errors:
> +				[service].Error.InvalidArguments
> +				[service].Error.TransientFailure

Please don't invent your own indentation here. Keep it aligned as all
the other documents in oFono and mmsd do.

Regards

Marcel



--===============2569318156615980057==--

