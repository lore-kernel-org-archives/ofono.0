Content-Type: multipart/mixed; boundary="===============3877790496475232052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/6] Add IncomingStatusReport a{sv} signal.
Date: Fri, 04 Jun 2010 11:58:41 -0500
Message-ID: <201006041158.41462.denkenz@gmail.com>
In-Reply-To: <1275650257-30593-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3877790496475232052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/sms.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index c0e9fc4..618e035 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -472,9 +472,10 @@ static GDBusMethodTable sms_manager_methods[] =3D {
>  };
> =

>  static GDBusSignalTable sms_manager_signals[] =3D {
> -	{ "PropertyChanged",	"sv"		},
> -	{ "IncomingMessage",	"sa{sv}"	},
> -	{ "ImmediateMessage",	"sa{sv}"	},
> +	{ "PropertyChanged",		"sv"		},
> +	{ "IncomingMessage",		"sa{sv}"	},
> +	{ "ImmediateMessage",		"sa{sv}"	},
> +	{ "IncomingStatusReport",	"a{sv}"		},
>  	{ }
>  };
> =


IncomingStatusReport signal is the wrong approach, we need to actually =

associate a status report with a message.  This will be done in two ways:
	- Via sms history
	- Via sms message D-Bus interface.  See the "See / Cancel pending..." task=
 in =

TODO

Until that task is done, I would only go through the history plugin.  Feel =

free to modify the example history to simply print the delivery status.

Regards,
-Denis

--===============3877790496475232052==--

