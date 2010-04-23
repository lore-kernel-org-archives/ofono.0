Content-Type: multipart/mixed; boundary="===============9167955182408660140=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC][PATCH] Add: online method to isimodem
Date: Fri, 23 Apr 2010 16:46:04 +0300
Message-ID: <l2g80fd4e751004230646xbc33ebaaxe9f7e8242f03662f@mail.gmail.com>
In-Reply-To: <201004222025.34820.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9167955182408660140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 Denis Kenzior <denkenz@gmail.com>:
>> =C2=A0gatchat/gatppp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 16 ++++
>> =C2=A0gatchat/ppp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A02 +
>> =C2=A0gatchat/ppp_lcp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A04 +
>> =C2=A0gatchat/ppp_net.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 13 +=
++-

> And why exactly are you including ppp patches along with isimodem? =C2=A0=
I'm
> confused.

I'm as confused as you. It seems to me I squished somebody else's
patch here during rebase. ;-o

>> diff --git a/include/modem.h b/include/modem.h
>> index d502640..34cac7b 100644
>> --- a/include/modem.h
>> +++ b/include/modem.h
>> @@ -50,6 +50,9 @@ void ofono_modem_remove(struct ofono_modem *modem);
>> =C2=A0void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool=
_t
>> =C2=A0powered); ofono_bool_t ofono_modem_get_powered(struct ofono_modem =
*modem);
>>
>> +void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t
>
> This is assuming the driver can set online states outside of oFono contro=
l.
> Tell me a use case where this makes sense please. =C2=A0If this is meant =
to be used
> only by ofono core, then this function should not be declared here.

I'm not assuming only core being able to drive the online state. If
you are using a PC with an external handset as modem, it will have its
own flight mode settings.


>> =C2=A0int ofono_modem_driver_register(const struct ofono_modem_driver *);
>> diff --git a/src/modem.c b/src/modem.c
>> index 8319702..05b1fed 100644
>> --- a/src/modem.c
>> +++ b/src/modem.c
>> @@ -61,6 +61,11 @@ struct ofono_modem {
>> =C2=A0 =C2=A0 =C2=A0 ofono_bool_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0powered;
>> =C2=A0 =C2=A0 =C2=A0 ofono_bool_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0powered_pending;
>> =C2=A0 =C2=A0 =C2=A0 guint =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 timeout;
>> + =C2=A0 =C2=A0 DBusMessage =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *p=
ending_online;
>
> We allow only one outstanding call / interface, so there's really no need=
 for
> this member.

It depends on how the flight mode is driven. If ofono will follow user
changing online/offline directly on external handset, the
ofono_modem_set_online needs to know which SetProperty call is
pending.

>> + =C2=A0 =C2=A0 ofono_bool_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on=
line_timeout;
>
> Is this supposed to be a guint?

Sure.

>> + =C2=A0 =C2=A0 ofono_dbus_dict_append(&dict, "Online", DBUS_TYPE_BOOLEA=
N,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &modem->online);

> I think FlightMode will be more recognizable for the UI guys.

It depends. Our UI people want to use "Offline" and "Online" in UI
(while the values used in D-Bus are "flight" and "normal"). It is
probably because they have plenty of use cases for "Offline" outside
aeroplanes.

...
> My overall feeling here is that there's no need to make FlightMode state =
so
> complicated. =C2=A0Can we assume that powering down the modem from 'onlin=
e' state
> will take care of bringing the hardware down cleanly and avoid explicitly
> calling the driver to bring it 'offline' first?

You are probably right, I did not think the underlying mechanism through.

> There's also the question of who stores the FlightMode user setting, and
> whether we store it by device ID or IMSI.

Unless we provide multiple settings, it is best left to some
application. Using my favourite phone as an example, the N900
application controlling the modem keeps track of Call UI state and two
UI settings, system mode (Online/offline, or if you prefer,
normal/flight) and cellular enable/disable. Only if Call UI is ready,
system mode is online and cellular radio is enabled, it will let modem
out of flight mode.

-- =

Pekka.Pessi mail at nokia.com

--===============9167955182408660140==--

