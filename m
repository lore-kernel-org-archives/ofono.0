Content-Type: multipart/mixed; boundary="===============1611176701360369157=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 03/15] hfp_hf_bluez5: Add extracting version
Date: Mon, 18 Mar 2013 13:55:41 -0500
Message-ID: <5147632D.8040406@gmail.com>
In-Reply-To: <1363092133-1092-4-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1611176701360369157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 03/12/2013 07:42 AM, Claudio Takahasi wrote:
> This patch parses and reads the profile "Version" that comes in the fd
> dictionary of the NewConnection method. "Version" is input for Audio Card
> registration.
> ---
>   plugins/hfp_hf_bluez5.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 2020e63..a8d8277 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -343,6 +343,37 @@ static ofono_bool_t device_path_compare(struct ofono=
_modem *modem,
>   	return g_str_equal(path, value);
>   }
>
> +static int get_version(DBusMessageIter *iter, uint16_t *version)
> +{
> +	DBusMessageIter dict, entry, valiter;
> +	const char *key;
> +	uint16_t value;
> +
> +	dbus_message_iter_recurse(iter,&dict);
> +
> +	/* Dict entry key */
> +	dbus_message_iter_recurse(&dict,&entry);
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
> +		return -EINVAL;
> +
> +	dbus_message_iter_get_basic(&entry,&key);
> +	if (g_str_equal("Version", key) =3D=3D FALSE)
> +		return -EINVAL;
> +
> +	/* Dict entry value */
> +	dbus_message_iter_next(&entry);
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
> +		return -EINVAL;
> +
> +	dbus_message_iter_recurse(&entry,&valiter);
> +	dbus_message_iter_get_basic(&valiter,&value);
> +
> +	if (version)
> +		*version =3D value;
> +
> +	return 0;
> +}
> +
>   static DBusMessage *profile_new_connection(DBusConnection *conn,
>   					DBusMessage *msg, void *user_data)
>   {
> @@ -353,6 +384,7 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
>   	DBusMessageIter entry;
>   	const char *device;
>   	char local[18], remote[18];
> +	uint16_t version;
>   	int fd, err;
>
>   	DBG("Profile handler NewConnection");
> @@ -373,6 +405,11 @@ static DBusMessage *profile_new_connection(DBusConne=
ction *conn,
>   	if (fd<  0)
>   		goto invalid;
>
> +	dbus_message_iter_next(&entry);
> +

I would not mind extra sanity checking here, e.g. argument type checking

> +	if (get_version(&entry,&version)<  0)
> +		goto invalid;
> +

I don't like this.  The fd_properties is a dictionary, you cannot assume =

that Version will be always the first one.

>   	modem =3D ofono_modem_find(device_path_compare, (void *) device);
>   	if (modem =3D=3D NULL) {
>   		close(fd);

Regards,
-Denis

--===============1611176701360369157==--

