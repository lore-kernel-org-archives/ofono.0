Content-Type: multipart/mixed; boundary="===============1004566822120456874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] emulator: Fix crash when dundee is disconnecting
Date: Fri, 22 Jun 2012 02:46:04 -0500
Message-ID: <4FE422BC.3040507@gmail.com>
In-Reply-To: <1340633992-14599-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1004566822120456874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 06/25/2012 09:19 AM, Guillaume Zajac wrote:
> Dundee is not waiting to receive the NO CARRIER notification
> to close the IO channel with oFono so that oFono is trying to
> send a NO CARRIER although GAtServer is removed.
> ---
>   src/emulator.c |    9 ++++++++-
>   1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/src/emulator.c b/src/emulator.c
> index c3165eb..cbee6ad 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -101,7 +101,14 @@ static void cleanup_ppp(struct ofono_emulator *em)
>   	em->pns_id =3D 0;
>
>   	g_at_server_resume(em->server);
> -	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_NO_CARRIER);
> +
> +	/*
> +	 * If GAtServer IO is lost, GAtServer can have been removed
> +	 * through emulator disconnect routine.
> +	 */
> +	if (em->server !=3D NULL)
> +		g_at_server_send_final(em->server,
> +					G_AT_SERVER_RESULT_NO_CARRIER);

If server is NULL then either it should be a global check like before =

(prior to proposed patch 1), or you should add a NULL check to =

g_at_server_send_final itself.

>   }
>
>   static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user=
_data)

Regards,
-Denis

--===============1004566822120456874==--

