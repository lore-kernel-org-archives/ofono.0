Content-Type: multipart/mixed; boundary="===============3459013449937223214=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] voicecall: manage multiparty list in AT+CHLD=3
Date: Wed, 29 Jun 2011 16:09:29 -0500
Message-ID: <4E0B9489.1000108@gmail.com>
In-Reply-To: <1309376333-6076-2-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3459013449937223214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 06/29/2011 02:38 PM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>  src/voicecall.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 64 insertions(+), 1 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 9620838..8e4ab58 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -94,6 +94,12 @@ struct voicecall {
>  	ofono_bool_t remote_multiparty;
>  };
>  =

> +struct mpty_cb_info {
> +	struct ofono_voicecall *vc;
> +	struct ofono_emulator *em;
> +	int id;
> +};
> +
>  struct dial_request {
>  	struct ofono_voicecall *vc;
>  	char *message;
> @@ -2710,6 +2716,48 @@ static void emulator_generic_cb(const struct ofono=
_error *error, void *data)
>  	ofono_emulator_send_final(em, error);
>  }
>  =

> +static void emulator_mpty_join_cb(const struct ofono_error *error, void =
*data)
> +{
> +	struct mpty_cb_info *mp =3D data;
> +	GSList *old;
> +
> +	ofono_emulator_send_final(mp->em, error);
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		g_free(mp);
> +		return;
> +	}
> +
> +	/*
> +	 * We just created a multiparty call, gather all held
> +	 * active calls and add them to the multiparty list
> +	 */
> +	old =3D mp->vc->multiparty_list;
> +	mp->vc->multiparty_list =3D 0;
> +
> +	mp->vc->multiparty_list =3D g_slist_concat(mp->vc->multiparty_list,
> +						voicecalls_held_list(mp->vc));
> +
> +	mp->vc->multiparty_list =3D g_slist_concat(mp->vc->multiparty_list,
> +						voicecalls_active_list(mp->vc));
> +
> +	mp->vc->multiparty_list =3D g_slist_sort(mp->vc->multiparty_list,
> +						call_compare);
> +
> +	if (g_slist_length(mp->vc->multiparty_list) < 2) {
> +		ofono_error("Created multiparty call, but size is less than 2"
> +				" panic!");
> +
> +		return;
> +	}
> +
> +	voicecalls_multiparty_changed(old, mp->vc->multiparty_list);
> +	g_slist_free(old);
> +	g_free(mp);
> +}
> +
> +}
> +

Something is wrong with your git-foo here:
src/voicecall.c:2759: error: expected identifier or =E2=80=98(=E2=80=99 bef=
ore =E2=80=98}=E2=80=99 token

>  static void emulator_ata_cb(struct ofono_emulator *em,
>  			struct ofono_emulator_request *req, void *userdata)
>  {
> @@ -2900,12 +2948,27 @@ static void emulator_chld_cb(struct ofono_emulato=
r *em,
>  					emulator_generic_cb, em);
>  			return;
>  		case 3:
> +		{
> +			struct mpty_cb_info *mp;
> +
>  			if (vc->driver->create_multiparty =3D=3D NULL)
>  				goto fail;
>  =

> +			if (!voicecalls_have_held(vc)
> +					|| !voicecalls_have_active(vc))
> +				goto fail;
> +
> +			mp =3D g_try_malloc0(sizeof(struct mpty_cb_info));
> +			if (!mp)
> +				goto fail;
> +
> +			mp->vc =3D vc;
> +			mp->em =3D em;
> +
>  			vc->driver->create_multiparty(vc,
> -					emulator_generic_cb, em);
> +					emulator_mpty_join_cb, mp);

So unfortunately you cannot do this, the current oFono driver framework
does not have a mechanism to guarantee the destruction of userdata you
pass to the driver method.  There was never a reason to have it...
Since atoms can and are forcefully removed at any time, you would
potentially be leaking memory here.

Can you re-use the existing pending_em member of ofono_voicecall for
this purpose?

>  			return;
> +		}
>  		case 4:
>  			if (vc->driver->transfer =3D=3D NULL)
>  				goto fail;

Regards,
-Denis

--===============3459013449937223214==--

