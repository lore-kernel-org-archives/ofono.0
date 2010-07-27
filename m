Content-Type: multipart/mixed; boundary="===============1095538862855382666=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 13/20] SMS: encapsulate D-Bus specific data in 'struct
 sms_msg_dbus_data'
Date: Tue, 27 Jul 2010 12:08:58 -0500
Message-ID: <4C4F12AA.3040501@gmail.com>
In-Reply-To: <5b31eccef49bc44a558f6a16cbaccbe1d36d06ee.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1095538862855382666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +/*
> + * Encapsulate information needed to export an SMS message over D-Bus.
> + *
> + * @dbus_path: path of the object in the D-Bus
> + * @dbus_msg: message this originated at
> + */
> +struct sms_msg_dbus_data {
> +	char *dbus_path;
> +	DBusMessage *dbus_msg;
> +};
> +

I don't really see a point for this structure.  When you send an SMS,
assuming the arguments and format were valid, you return straight away.
 Thus SendMessage should be marked as not being ASYNC and storing of
DBusMessage is unnecessary.  Rest can be handled by txq_submit and the
dbus path can be easily generated based on the UUID.

>  /*
> @@ -590,6 +604,9 @@ static void send_message_destroy(void *data)
>   * is created by tx_queue_entry_new() and g_queue_push_tail()
>   * appends that entry to the SMS transmit queue. Then the tx_next()
>   * function is scheduled to run to process the queue.
> + *
> + * @sms is the main SMS driver struct, @entry and @msg_list represent
> + * the current message being processed.
>   */
>  static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *=
msg,
>  					void *data)

This chunk seems totally unrelated...

Regards,
-Denis

--===============1095538862855382666==--

