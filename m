Content-Type: multipart/mixed; boundary="===============1693486863159918851=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Tue, 27 Apr 2010 04:33:36 +0200
Message-ID: <1272335616.22838.121.camel@localhost.localdomain>
In-Reply-To: <1271746281-26784-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1693486863159918851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> Puting send_method_call and send_method_call_with_reply on g_dbus will
> avoid some code duplication and will make things easier mainly for the
> Bluetooth plugins (HFP, DUN, SAP) inside oFono.
> ---
>  gdbus/gdbus.h  |   12 ++++
>  gdbus/object.c |   81 +++++++++++++++++++++++++++++
>  plugins/hfp.c  |  154 +++++++++++++-------------------------------------=
-----
>  3 files changed, 130 insertions(+), 117 deletions(-)

first of all, we don't intermix gdbus patches with other changes.
Remember that these commits have to be applied to BlueZ and ConnMan as
well.

> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 47e18cf..ac488c5 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -106,12 +106,24 @@ DBusMessage *g_dbus_create_error_valist(DBusMessage=
 *message, const char *name,
>  DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...);
>  DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
>  						int type, va_list args);
> +DBusMessage *g_dbus_create_method_call(const char *dest, const char *pat=
h,
> +				const char *interface, const char *method,
> +				int type, va_list args);
>  =

>  gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *me=
ssage);
>  gboolean g_dbus_send_reply(DBusConnection *connection,
>  				DBusMessage *message, int type, ...);
>  gboolean g_dbus_send_reply_valist(DBusConnection *connection,
>  				DBusMessage *message, int type, va_list args);
> +gboolean g_dbus_send_method_call(DBusConnection *connection, const char =
*dest,
> +				const char *path, const char *interface,
> +				const char *method, int type, ...);
> +gboolean g_dbus_send_method_call_with_reply(DBusConnection *connection,
> +				const char *dest, const char *path,
> +				const char *interface, const char *method,
> +				DBusPendingCallNotifyFunction cb,
> +				void *user_data, DBusFreeFunction free_func,
> +				int timeout, int type, ...);

Is there any real reason to export send_method_call and
create_method_call? What are these good for and what are your expected
users of these?

I think that a g_dbus_method_call which is always async and take a
pending call notifier is just enough.

All the other helpers are more for callbacks that have to respond to
messages than for client usage.

Regards

Marcel



--===============1693486863159918851==--

