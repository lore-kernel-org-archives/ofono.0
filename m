Content-Type: multipart/mixed; boundary="===============2928442786480644818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stemodem: Check for ok in voicecall_initialize.
Date: Thu, 03 Feb 2011 10:13:21 -0600
Message-ID: <4D4AD421.1020309@gmail.com>
In-Reply-To: <1296738804-23599-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2928442786480644818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

On 02/03/2011 07:13 AM, Marit Henriksen wrote:
> From: Marit Henriksen <marit.henriksen@stericsson.com>
> =

> ---
>  drivers/stemodem/voicecall.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index fa078a8..2eaba8c 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -522,6 +522,10 @@ static void ste_voicecall_initialized(gboolean ok, G=
AtResult *result,
>  	struct ofono_voicecall *vc =3D user_data;
>  	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>  =

> +	if (!ok)
> +		ofono_error("*ECAV not enabled. "
> +				"Do not have proper call handling");
> +

Why do you still register the atom here? Should you also call
ofono_voicecall_remove() and return here?

>  	g_at_chat_register(vd->chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
>  	ofono_voicecall_register(vc);
>  }

Regards,
-Denis

--===============2928442786480644818==--

