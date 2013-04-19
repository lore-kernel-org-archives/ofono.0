Content-Type: multipart/mixed; boundary="===============4375875751729258773=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] hfp_ag_bluez5: Create a hash to store connections
Date: Fri, 19 Apr 2013 10:36:42 -0500
Message-ID: <5171648A.8000109@gmail.com>
In-Reply-To: <1366383661-26950-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4375875751729258773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/19/2013 10:00 AM, Paulo Borges wrote:
> We need to store active connections so we can disconnect them at
> RequestDisconnect().
>
> When we remove a connection from the hash, we also close it.
> ---
>   plugins/hfp_ag_bluez5.c |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
> index c171c87..edc76e6 100644
> --- a/plugins/hfp_ag_bluez5.c
> +++ b/plugins/hfp_ag_bluez5.c
> @@ -48,6 +48,17 @@
>   static guint modemwatch_id;
>   static GList *modems;
>   static GHashTable *sim_hash =3D NULL;
> +static GHashTable *connection_hash;
> +
> +static void connection_removed_notify(gpointer data)
> +{
> +	int fd =3D GPOINTER_TO_INT(data);
> +
> +	DBG("%d", fd);
> +
> +	shutdown(fd, SHUT_RDWR);
> +	close(fd);
> +}

I will be a bit nit-picky here, but shutdown() does not belong here. =

You only want to do this inside the RequestDisconnection() implementation.

Also, please name this function connection_destroy().

Regards,
-Denis

--===============4375875751729258773==--

