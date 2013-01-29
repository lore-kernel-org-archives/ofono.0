Content-Type: multipart/mixed; boundary="===============2439169274248726081=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 7/8] hfp_hf_bluez5: Add rejecting SCO connection
Date: Tue, 29 Jan 2013 09:27:32 -0600
Message-ID: <5107EA64.9000707@gmail.com>
In-Reply-To: <1359407468-5110-8-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2439169274248726081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/28/2013 03:11 PM, Claudio Takahasi wrote:
> This patch rejects the SCO incoming connection if there isn't a modem
> (service level connection) associated with the address.

Why service level connection is in parenthesis?

> ---
>   plugins/hfp_hf_bluez5.c | 82 ++++++++++++++++++++++++++++++++++++++++--=
-------
>   1 file changed, 68 insertions(+), 14 deletions(-)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 87ae5e3..871c720 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -61,6 +61,13 @@
>   struct hfp {
>   	struct hfp_slc_info info;
>   	DBusMessage *msg;
> +	bdaddr_t src;
> +	bdaddr_t dst;
> +};

What is src and what is dst? This is completely context dependent and =

confusing.  Also, we are already storing the device address on the modem =

object, why do we need this yet again?

> +
> +struct sock_bdaddr {
> +	bdaddr_t src;
> +	bdaddr_t dst;
>   };

I'd really like to avoid this structure.  At the very least change the =

name into something that conveys its purpose.  e.g. bdaddr_pair, or =

something.  The way it is now is just silly.

>
>   static GHashTable *modem_hash =3D NULL;
> @@ -68,6 +75,21 @@ static GHashTable *devices_proxies =3D NULL;
>   static GDBusClient *bluez =3D NULL;
>   static guint sco_watch =3D 0;
>
> +static gboolean modem_bacmp(gpointer key, gpointer value,
> +						gpointer user_data)
> +{
> +	const struct sock_bdaddr *bda =3D user_data;
> +	struct ofono_modem *modem =3D value;
> +	struct hfp *hfp =3D ofono_modem_get_data(modem);
> +	int ret;
> +
> +	ret =3D bt_bacmp(&bda->dst,&hfp->dst);
> +	if (ret !=3D 0)
> +		return FALSE;
> +
> +	return bt_bacmp(&bda->src,&hfp->src) !=3D 0 ? FALSE : TRUE;
> +}
> +
>   static void hfp_debug(const char *str, void *user_data)
>   {
>   	const char *prefix =3D user_data;
> @@ -275,14 +297,15 @@ static DBusMessage *profile_new_connection(DBusConn=
ection *conn,
>   {
>   	struct hfp *hfp;
>   	struct ofono_modem *modem;
> +	struct sockaddr_rc src, dst;
> +	socklen_t alen;
>   	DBusMessageIter iter;
>   	GDBusProxy *proxy;
>   	DBusMessageIter entry;
> -	const char *device, *alias, *address;
> +	const char *device, *alias;
> +	char device_address[18];
>   	int fd, err;
>
> -	DBG("Profile handler NewConnection");
> -
>   	if (dbus_message_iter_init(msg,&entry) =3D=3D FALSE)
>   		goto invalid;
>
> @@ -301,11 +324,6 @@ static DBusMessage *profile_new_connection(DBusConne=
ction *conn,
>
>   	dbus_message_iter_get_basic(&iter,&alias);
>
> -	if (g_dbus_proxy_get_property(proxy, "Address",&iter) =3D=3D FALSE)
> -		goto invalid;
> -
> -	dbus_message_iter_get_basic(&iter,&address);
> -
>   	dbus_message_iter_next(&entry);
>   	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
>   		goto invalid;
> @@ -314,7 +332,24 @@ static DBusMessage *profile_new_connection(DBusConne=
ction *conn,
>   	if (fd<  0)
>   		goto invalid;
>
> -	modem =3D modem_register(device, address, alias);
> +	memset(&src, 0, sizeof(src));
> +	alen =3D sizeof(src);
> +	if (getsockname(fd, (struct sockaddr *)&src,&alen)<  0) {
> +		close(fd);
> +		goto invalid;
> +	}
> +
> +	memset(&dst, 0, sizeof(dst));
> +	alen =3D sizeof(dst);
> +	if (getpeername(fd, (struct sockaddr *)&dst,&alen)<  0) {
> +		close(fd);
> +		goto invalid;
> +	}
> +
> +	bt_ba2str(&dst.rc_bdaddr, device_address);
> +	DBG("Profile handler NewConnection: %s", device_address);
> +
> +	modem =3D modem_register(device, device_address, alias);
>   	if (modem =3D=3D NULL) {
>   		close(fd);
>   		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
> @@ -329,6 +364,8 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
>   					"Not enough resources");
>
>   	hfp =3D ofono_modem_get_data(modem);
> +	bt_bacpy(&hfp->src,&src.rc_bdaddr);
> +	bt_bacpy(&hfp->dst,&dst.rc_bdaddr);
>   	hfp->msg =3D dbus_message_ref(msg);
>

Fair enough, but this chunk really belongs in a separate patch.

>   	return NULL;
> @@ -384,7 +421,9 @@ static const GDBusMethodTable profile_methods[] =3D {
>   static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
>   							gpointer user_data)
>   {
> -	struct sockaddr_sco saddr;
> +	struct ofono_modem *modem;
> +	struct sockaddr_sco src, dst;
> +	struct sock_bdaddr bda;
>   	socklen_t alen;
>   	int sk, nsk;
>
> @@ -393,14 +432,29 @@ static gboolean sco_accept(GIOChannel *io, GIOCondi=
tion cond,
>
>   	sk =3D g_io_channel_unix_get_fd(io);
>
> -	memset(&saddr, 0, sizeof(saddr));
> -	alen =3D sizeof(saddr);
> +	memset(&dst, 0, sizeof(dst));
> +	alen =3D sizeof(dst);
>
> -	nsk =3D accept(sk, (struct sockaddr *)&saddr,&alen);
> +	nsk =3D accept(sk, (struct sockaddr *)&dst,&alen);

When reading this patch I go 'what the...'

>   	if (nsk<  0)
>   		return TRUE;
>
> -	/* TODO: Verify if the device has a modem */
> +	memset(&src, 0, sizeof(src));
> +	alen =3D sizeof(src);
> +	if (getsockname(nsk, (struct sockaddr *)&src,&alen)<  0) {
> +		close(nsk);
> +		return TRUE;
> +	}
> +
> +	bt_bacpy(&bda.src,&src.sco_bdaddr);
> +	bt_bacpy(&bda.dst,&dst.sco_bdaddr);
> +
> +	modem =3D g_hash_table_find(modem_hash, modem_bacmp,&bda);
> +	if (modem =3D=3D NULL) {
> +		ofono_error("Rejecting SCO: SLC connection missing!");
> +		close(nsk);
> +		return TRUE;
> +	}
>
>   	return TRUE;
>   }

Regards,
-Denis

--===============2439169274248726081==--

