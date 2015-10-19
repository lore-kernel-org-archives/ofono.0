Content-Type: multipart/mixed; boundary="===============8124662419668169183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/10] ril: Remove asserts
Date: Mon, 19 Oct 2015 08:55:20 -0500
Message-ID: <5624F648.9020209@gmail.com>
In-Reply-To: <1444927623-31141-8-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8124662419668169183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/15/2015 11:47 AM, Alfonso Sanchez-Beato wrote:
> ---
>   plugins/ril.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/ril.c b/plugins/ril.c
> index e31f24b..2edb0a9 100644
> --- a/plugins/ril.c
> +++ b/plugins/ril.c
> @@ -144,7 +144,9 @@ static void ril_radio_state_changed(struct ril_msg *m=
essage, gpointer user_data)
>   			break;
>   		default:
>   			/* Malformed parcel; no radio state =3D=3D broken rild */
> -			g_assert(FALSE);
> +			ofono_error("%s: Bad radio state (%d), exiting",
> +							__func__, radio_state);
> +			exit(1);

Can we just remove the ril modem in question instead of killing the =

entire daemon?

>   		}
>   	}
>   }
> @@ -213,7 +215,6 @@ void ril_pre_sim(struct ofono_modem *modem)
>   	sim_data.ril_state_watch =3D NULL;
>
>   	rd->sim =3D ofono_sim_create(modem, rd->vendor, RILMODEM, &sim_data);
> -	g_assert(rd->sim !=3D NULL);
>   }
>
>   void ril_post_sim(struct ofono_modem *modem)
>

Regards,
-Denis

--===============8124662419668169183==--

