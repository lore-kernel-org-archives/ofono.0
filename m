Content-Type: multipart/mixed; boundary="===============0401050760299886518=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 20/24] stk: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 15:44:23 -0500
Message-ID: <571A8D27.6060006@gmail.com>
In-Reply-To: <1461330601-21333-21-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0401050760299886518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 04/22/2016 08:10 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> ---
>   src/stk.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 01c95b5..16c7152 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -2315,8 +2315,7 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
>   			break;
>   		}
>
> -		g_slist_foreach(file_list, (GFunc) g_free, NULL);
> -		g_slist_free(file_list);
> +		g_slist_free_full(file_list, g_free);
>
>   		return FALSE;
>   	}
> @@ -3131,6 +3130,11 @@ void ofono_stk_driver_unregister(const struct ofon=
o_stk_driver *d)
>   	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
>   }
>
> +static void free_envelope_item(gpointer pointer, gpointer user_data)
> +{
> +	g_free(pointer);
> +}
> +
>   static void stk_unregister(struct ofono_atom *atom)
>   {
>   	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
> @@ -3163,7 +3167,7 @@ static void stk_unregister(struct ofono_atom *atom)
>   		stk->main_menu =3D NULL;
>   	}
>
> -	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
> +	g_queue_foreach(stk->envelope_q, free_envelope_item, NULL);

Why not g_queue_free_full?

>   	g_queue_free(stk->envelope_q);
>
>   	ofono_modem_remove_interface(modem, OFONO_STK_INTERFACE);
>

Regards,
-Denis

--===============0401050760299886518==--

