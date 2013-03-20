Content-Type: multipart/mixed; boundary="===============2620770437417751007=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] handsfree-audio: Add support for initiating SCO
 connections
Date: Wed, 20 Mar 2013 16:04:08 -0500
Message-ID: <514A2448.8030002@gmail.com>
In-Reply-To: <20130320151501.GB6190@samus>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2620770437417751007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 03/20/2013 10:15 AM, Vinicius Costa Gomes wrote:
> Hi Denis,
>
> On 22:38 Tue 19 Mar, Denis Kenzior wrote:
>> Hi Vinicius,
>>
>> On 03/19/2013 07:10 PM, Vinicius Costa Gomes wrote:
>>> When calling the card's .Connect() method, we should be able to
>>> establish a SCO connection.
>>>
>>> Right now, we only have support for establishing the SCO connection
>>> directly, this is what is expected from HFP 1.5 HF/AG devices.
>>> ---
>>>   src/handsfree-audio.c | 94 ++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>>   1 file changed, 93 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>>> index c7fa2fb..9eecb8e 100644
>>> --- a/src/handsfree-audio.c
>>> +++ b/src/handsfree-audio.c
>>> @@ -53,6 +53,8 @@ struct ofono_handsfree_card {
>>>   	char *remote;
>>>   	char *local;
>>>   	char *path;
>>> +	DBusMessage *msg;
>>> +	guint sco_watch;
>>>   	const struct ofono_handsfree_card_driver *driver;
>>>   	void *driver_data;
>>>   };
>>> @@ -235,10 +237,100 @@ static DBusMessage *card_get_properties(DBusConn=
ection *conn,
>>>   	return reply;
>>>   }
>>>
>>> +static int card_connect_sco(struct ofono_handsfree_card *card)
>>> +{
>>> +	struct sockaddr_sco addr;
>>> +	int sk, ret;
>>> +
>>> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXE=
C,
>>> +								BTPROTO_SCO);
>>> +	if (sk<   0)
>>> +		return -1;
>>> +
>>> +	/* Bind to local address */
>>> +	memset(&addr, 0, sizeof(addr));
>>> +	addr.sco_family =3D AF_BLUETOOTH;
>>> +	bt_str2ba(card->local,&addr.sco_bdaddr);
>>> +
>>> +	if (bind(sk, (struct sockaddr *)&addr, sizeof(addr))<   0) {
>>> +		close(sk);
>>> +		return -1;
>>> +	}
>>> +
>>> +	/* Connect to remote device */
>>> +	memset(&addr, 0, sizeof(addr));
>>> +	addr.sco_family =3D AF_BLUETOOTH;
>>> +	bt_str2ba(card->remote,&addr.sco_bdaddr);
>>> +
>>> +	ret =3D connect(sk, (struct sockaddr *)&addr, sizeof(addr));
>>> +	if (ret<   0&&   !(errno =3D=3D EAGAIN || errno =3D=3D EINPROGRESS)) {
>>
>> Why do we use EAGAIN here?  I thought only EINPROGRESS can be
>> returned from a non-blocking connect.  Or are Bluetooth semantics
>> different?
>
> Just checked, you are right: only EINPROGRSS will be returned in this cas=
e.
> Will fix.
>
>>
>>> +		close(sk);
>>> +		return -1;
>>> +	}
>>> +
>>> +	return sk;
>>> +}
>>> +
>>> +static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
>>> +							gpointer user_data)
>>> +
>>> +{
>>> +	struct ofono_handsfree_card *card =3D user_data;
>>> +	DBusMessage *reply;
>>> +	int sk;
>>> +
>>> +	if (cond&   (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
>>> +		reply =3D __ofono_error_failed(card->msg);
>>> +		goto done;
>>> +	}
>>> +
>>> +	sk =3D g_io_channel_unix_get_fd(io);
>>> +
>>> +	close(sk);
>>> +
>>> +	reply =3D dbus_message_new_method_return(card->msg);
>>> +
>>
>> We probably should be paranoid and check whether we still have the agent.
>
> For the method return message of the 'Connect()' call, I can't see any ga=
ins of
> this check, but for sending the 'NewConnection()' message I can (and that=
 is
> what the next patch does). Could be that I am missing something.

Just being symmetrical.  In the Connect() implementation you return a =

not_available error if the agent is not registered (before starting the =

connection procedure).

>
> One thing I just noticed that is missing is that there's no check that on=
ly
> the agent may call 'Connect()'.
>

Yes, put this in for now.  We might or might not want to relax this =

condition later.

>>
>>> +done:
>>> +	g_dbus_send_message(ofono_dbus_get_connection(), reply);
>>> +
>>> +	return FALSE;
>>> +}
>>> +
>>> +static void sco_watch_destroy(gpointer user_data)
>>> +{
>>> +	struct ofono_handsfree_card *card =3D user_data;
>>> +
>>> +	card->sco_watch =3D 0;
>>> +	dbus_message_unref(card->msg);
>>> +}
>>> +
>>>   static DBusMessage *card_connect(DBusConnection *conn,
>>>   						DBusMessage *msg, void *data)
>>>   {
>>> -	return __ofono_error_not_implemented(msg);
>>> +	struct ofono_handsfree_card *card =3D data;
>>> +	GIOChannel *io;
>>> +	int sk;
>>> +
>>> +	if (agent =3D=3D NULL)
>>> +		return __ofono_error_not_available(msg);
>>> +
>>> +	if (card->msg)
>>> +		return __ofono_error_busy(msg);
>>> +
>>> +	sk =3D card_connect_sco(card);
>>
>> I presume this fails if we already have a SCO link?
>
> It will, but I will replace the check above (card->msg) with a check for
> sco_watch, to make it clearer.
>
>>
>>> +	if (sk<   0)
>>> +		return __ofono_error_failed(msg);
>>> +
>>> +	io =3D g_io_channel_unix_new(sk);
>>> +	card->sco_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
>>> +				G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>>> +				sco_connect_cb, card, sco_watch_destroy);
>>> +
>>> +	g_io_channel_unref(io);
>>> +
>>> +	card->msg =3D dbus_message_ref(msg);
>>> +
>>> +	return NULL;
>>>   }
>>>
>>>   static const GDBusMethodTable card_methods[] =3D {
>>
>> Regards,
>> -Denis
>
>
> Cheers,

Regards,
-Denis

--===============2620770437417751007==--

