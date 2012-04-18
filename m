Content-Type: multipart/mixed; boundary="===============4916934823900669333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: send CallRemoved for calls when voicecall atom
 is unregistered
Date: Wed, 18 Apr 2012 10:52:40 -0500
Message-ID: <4F8EE348.2000602@gmail.com>
In-Reply-To: <1334786546-4890-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4916934823900669333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On 04/18/2012 05:02 PM, Mike Brudevold wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
> =

> The CallRemoved signal was not being sent for existing calls when the voi=
cecall
> atom was unregistered. An example of this is the lack of a CallRemoved si=
gnal
> when an HFP AG is disconnected due to SLC timeout while a call is active.
> ---
>  src/voicecall.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 104b600..263f1ee 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -2699,8 +2699,11 @@ static void voicecall_unregister(struct ofono_atom=
 *atom)
>  	if (vc->dial_req)
>  		dial_request_finish(vc);
>  =

> -	for (l =3D vc->call_list; l; l =3D l->next)
> +	for (l =3D vc->call_list; l; l =3D l->next) {
> +		voicecalls_emit_call_removed(vc, l->data);
> +
>  		voicecall_dbus_unregister(vc, l->data);
> +	}
>  =


In some respect this is on purpose, the application should listen to the
PropertyChanged on the main Modem object and keep track of Interfaces
property.  e.g. if the VoiceCallManager goes away the application can
pretty much assume that all calls are gone.

I could use some more convincing that this is really needed...

Regards,
-Denis

>  	g_slist_free(vc->call_list);
>  	vc->call_list =3D NULL;


--===============4916934823900669333==--

