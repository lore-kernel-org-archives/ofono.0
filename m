Content-Type: multipart/mixed; boundary="===============5161756449662085113=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 7/8] hfp_hf_bluez5: Add rejecting SCO connection
Date: Tue, 29 Jan 2013 10:25:18 -0600
Message-ID: <5107F7EE.6080500@gmail.com>
In-Reply-To: <CAKT1EBdEp1eBuhphdzeFo=PuMwJiWasumtp4Ywz3wcTrhWqREw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5161756449662085113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

>>> This patch rejects the SCO incoming connection if there isn't a modem
>>> (service level connection) associated with the address.
>>
>>
>> Why service level connection is in parenthesis?
>
> I thought this additional information could be useful.
> No problem, I gonna remove it.
>

Actually the service level connection is important, the modem part is =

not.  Hence why I'm lost why it is in parenthesis.

<snip>

>>> +       bdaddr_t src;
>>> +       bdaddr_t dst;
>>> +};
>>
>>
>> What is src and what is dst? This is completely context dependent and
>> confusing.  Also, we are already storing the device address on the modem
>> object, why do we need this yet again?
>
> We use this standard in BlueZ for source and destination. It could be
> also sba and dba.
> Do you have another suggestion?

Then BlueZ is just plain weird.  Local and Remote would be way better names.

>
> Indeed, we already have the address stored in the modem, but it is the
> opposite thing of what Marcel is asking: avoid BT address stored using
> string format.
> If I use string to store the BT source address I will be blamed also,
> I did this for the PATCH v0. Please define how you want to store this
> data.
>

Whenever we store duplicate information, a question will be raised.  I =

see no point in doing it twice.

>>
>>
>>> +
>>> +struct sock_bdaddr {
>>> +       bdaddr_t src;
>>> +       bdaddr_t dst;
>>>    };
>>
>>
>> I'd really like to avoid this structure.  At the very least change the n=
ame
>> into something that conveys its purpose.  e.g. bdaddr_pair, or something.
>> The way it is now is just silly.
>
> If we get the Device address from the modem string this struct will
> not be necessary.
>
>>
>>>
>>>    static GHashTable *modem_hash =3D NULL;
>>> @@ -68,6 +75,21 @@ static GHashTable *devices_proxies =3D NULL;
>>>    static GDBusClient *bluez =3D NULL;
>>>    static guint sco_watch =3D 0;
>>>
>>> +static gboolean modem_bacmp(gpointer key, gpointer value,
>>> +                                               gpointer user_data)
>>> +{
>>> +       const struct sock_bdaddr *bda =3D user_data;
>>> +       struct ofono_modem *modem =3D value;
>>> +       struct hfp *hfp =3D ofono_modem_get_data(modem);
>>> +       int ret;
>>> +
>>> +       ret =3D bt_bacmp(&bda->dst,&hfp->dst);
>>>
>>> +       if (ret !=3D 0)
>>> +               return FALSE;
>>> +
>>> +       return bt_bacmp(&bda->src,&hfp->src) !=3D 0 ? FALSE : TRUE;
>>>
>>> +}
>>> +
>>>    static void hfp_debug(const char *str, void *user_data)
>>>    {
>>>          const char *prefix =3D user_data;
>>> @@ -275,14 +297,15 @@ static DBusMessage
>>> *profile_new_connection(DBusConnection *conn,
>>>    {
>>>          struct hfp *hfp;
>>>          struct ofono_modem *modem;
>>> +       struct sockaddr_rc src, dst;
>>> +       socklen_t alen;
>>>          DBusMessageIter iter;
>>>          GDBusProxy *proxy;
>>>          DBusMessageIter entry;
>>> -       const char *device, *alias, *address;
>>> +       const char *device, *alias;
>>> +       char device_address[18];
>>>          int fd, err;
>>>
>>> -       DBG("Profile handler NewConnection");
>>> -
>>>          if (dbus_message_iter_init(msg,&entry) =3D=3D FALSE)
>>>
>>>                  goto invalid;
>>>
>>> @@ -301,11 +324,6 @@ static DBusMessage
>>> *profile_new_connection(DBusConnection *conn,
>>>
>>>          dbus_message_iter_get_basic(&iter,&alias);
>>>
>>> -       if (g_dbus_proxy_get_property(proxy, "Address",&iter) =3D=3D FA=
LSE)
>>>
>>> -               goto invalid;
>>> -
>>> -       dbus_message_iter_get_basic(&iter,&address);
>>> -
>>>          dbus_message_iter_next(&entry);
>>>          if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX=
_FD)
>>>                  goto invalid;
>>> @@ -314,7 +332,24 @@ static DBusMessage
>>> *profile_new_connection(DBusConnection *conn,
>>>          if (fd<   0)
>>>                  goto invalid;
>>>
>>> -       modem =3D modem_register(device, address, alias);
>>> +       memset(&src, 0, sizeof(src));
>>> +       alen =3D sizeof(src);
>>> +       if (getsockname(fd, (struct sockaddr *)&src,&alen)<   0) {
>>>
>>> +               close(fd);
>>> +               goto invalid;
>>> +       }
>>> +
>>> +       memset(&dst, 0, sizeof(dst));
>>> +       alen =3D sizeof(dst);
>>> +       if (getpeername(fd, (struct sockaddr *)&dst,&alen)<   0) {
>>>
>>> +               close(fd);
>>> +               goto invalid;
>>> +       }
>>> +
>>> +       bt_ba2str(&dst.rc_bdaddr, device_address);
>>> +       DBG("Profile handler NewConnection: %s", device_address);
>>> +
>>> +       modem =3D modem_register(device, device_address, alias);
>>>          if (modem =3D=3D NULL) {
>>>                  close(fd);
>>>                  return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
>>> @@ -329,6 +364,8 @@ static DBusMessage
>>> *profile_new_connection(DBusConnection *conn,
>>>                                          "Not enough resources");
>>>
>>>          hfp =3D ofono_modem_get_data(modem);
>>> +       bt_bacpy(&hfp->src,&src.rc_bdaddr);
>>> +       bt_bacpy(&hfp->dst,&dst.rc_bdaddr);
>>>          hfp->msg =3D dbus_message_ref(msg);
>>>
>>
>> Fair enough, but this chunk really belongs in a separate patch.
>
> IMO it belongs to this patch since it is initializing a value that
> will be used to compare the addresses when the sco connection is
> accepted.
> But no problem, I can split it.
>

I'd like to see the profile_new_connection changes as a separate patch, =

this part can be there as well, not a biggie.

>>
>>
>>>          return NULL;
>>> @@ -384,7 +421,9 @@ static const GDBusMethodTable profile_methods[] =3D=
 {
>>>    static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
>>>                                                          gpointer
>>> user_data)
>>>    {
>>> -       struct sockaddr_sco saddr;
>>> +       struct ofono_modem *modem;
>>> +       struct sockaddr_sco src, dst;
>>> +       struct sock_bdaddr bda;
>>>          socklen_t alen;
>>>          int sk, nsk;
>>>
>>> @@ -393,14 +432,29 @@ static gboolean sco_accept(GIOChannel *io,
>>> GIOCondition cond,
>>>
>>>          sk =3D g_io_channel_unix_get_fd(io);
>>>
>>> -       memset(&saddr, 0, sizeof(saddr));
>>> -       alen =3D sizeof(saddr);
>>> +       memset(&dst, 0, sizeof(dst));
>>> +       alen =3D sizeof(dst);
>>>
>>> -       nsk =3D accept(sk, (struct sockaddr *)&saddr,&alen);
>>> +       nsk =3D accept(sk, (struct sockaddr *)&dst,&alen);
>>
>>
>> When reading this patch I go 'what the...'
>
> I am renaming it to follow a standard: src for source and dst for destina=
tion.
> But I can revert it, no problem.
>

This is a dual-initiator profile, src and dst are really bad names for this.

Regards,
-Denis

--===============5161756449662085113==--

