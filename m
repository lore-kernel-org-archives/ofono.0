Content-Type: multipart/mixed; boundary="===============3219927119370600156=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 2/4] cdma-connman: add username and password,
 pass them to drivers
Date: Thu, 21 Jul 2011 04:54:23 -0500
Message-ID: <4E27F74F.3020703@gmail.com>
In-Reply-To: <1311223244-26904-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3219927119370600156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 07/20/2011 11:40 PM, Guillaume Zajac wrote:
> ---
>  src/cdma-connman.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++=
+-
>  1 files changed, 47 insertions(+), 1 deletions(-)
> =


I applied this patch, with a follow on commit afterwards:

> @@ -371,6 +373,36 @@ static DBusMessage *cdma_connman_get_properties(DBus=
Connection *conn,
>  	return reply;
>  }
>  =

> +static DBusMessage *cdma_connman_set_username(struct ofono_cdma_connman =
*cm,
> +					DBusConnection *conn, DBusMessage *msg,
> +					const char *username)
> +{
> +	if (strlen(username) > OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH)
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (g_str_equal(username, cm->username))
> +		return dbus_message_new_method_return(msg);
> +
> +	strcpy(cm->username, username);
> +
> +	return dbus_message_new_method_return(msg);

When you're changing a property, you really must signal PropertyChanged
as well.

> +}
> +
> +static DBusMessage *cdma_connman_set_password(struct ofono_cdma_connman =
*cm,
> +					DBusConnection *conn, DBusMessage *msg,
> +					const char *password)
> +{
> +	if (strlen(password) > OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH)
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (g_str_equal(password, cm->password))
> +		return dbus_message_new_method_return(msg);
> +
> +	strcpy(cm->password, password);
> +
> +	return dbus_message_new_method_return(msg);

same comment as above.

> +}
> +
>  static DBusMessage *cdma_connman_set_property(DBusConnection *conn,
>  					DBusMessage *msg, void *data)
>  {

Regards,
-Denis

--===============3219927119370600156==--

