Content-Type: multipart/mixed; boundary="===============1016710047391488185=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: Handle voicecall_dbus_register() return value
Date: Mon, 25 Jun 2018 10:25:52 -0500
Message-ID: <024c98e6-c948-6229-dd93-2fee66abb481@gmail.com>
In-Reply-To: <1529770121-13691-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1016710047391488185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/23/2018 11:08 AM, Slava Monich wrote:
> FALSE means that struct voicecall passed in as a parameter
> has been deallocated.
> ---
>   src/voicecall.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Is there an actual issue you're fixing?  Or is this just a be paranoid =

patch?

> diff --git a/src/voicecall.c b/src/voicecall.c
> index e4f6a4c..194b75f 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -1391,7 +1391,9 @@ static struct voicecall *synthesize_outgoing_call(s=
truct ofono_voicecall *vc,
>   	v->detect_time =3D time(NULL);
>   =

>   	DBG("Registering new call: %d", call->id);
> -	voicecall_dbus_register(v);
> +
> +	if (!voicecall_dbus_register(v))
> +		return NULL;

Okay, but you probably also want to release the callid which is being =

held above.

>   =

>   	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v, call_compare=
);
>   =

> =


Regards,
-Denis

--===============1016710047391488185==--

