Content-Type: multipart/mixed; boundary="===============3566010502214561670=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/6] stk-api.txt. Introduce the new API ConfirmOpenChannel
Date: Fri, 08 Apr 2011 09:36:39 -0700
Message-ID: <1302280599.2572.202.camel@aeonflux>
In-Reply-To: <1302280411-20762-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3566010502214561670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  doc/stk-api.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index 0bcc6b5..aaa9fba 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -278,6 +278,13 @@ Methods		byte RequestSelection(string title, byte ic=
on_id,
>  =

>  			Possible Errors: [service].Error.SimToolkit.EndSession
>  =

> +		boolean ConfirmOpenChannel(string information, byte icon_id)
> +
> +			Asks the agent to request user to confirm the channel
> +			set-up.
> +
> +			Possible Errors: [service].Error.SimToolkit.EndSession
> +

we need to talk a bit about these boolean return parameters for
confirmation. Since essentially a positive D-Bus reply can be considered
as TRUE and a D-Bus error as FALSE. So this essentially implicit.

You can not return FALSE and an error. That is not how D-Bus works.

Regards

Marcel



--===============3566010502214561670==--

