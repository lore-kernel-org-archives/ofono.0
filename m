Content-Type: multipart/mixed; boundary="===============1584808356405104053=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 11:02:58 -0500
Message-ID: <1eb977ba-e4be-b6c8-11fb-9059ad2256cd@gmail.com>
In-Reply-To: <CAKSBH7HkxiEySdhB1diB=+KvDiyEe5iz0SyFg=0xdRUiq0MPgw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1584808356405104053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> static DBusMessage *lte_set_property(DBusConnection *conn,
> DBusMessage *msg, void *data)
> {
> [...]
> if (lte->driver->set_property)
> lte->driver->set_property(...);

What is this buying you?

> else if (lte->driver->set_default_attach_info)
> lte->driver->set_default_attach_info(...);
> else
> return __ofono_error_not_implemented(msg);
> [...]
> =

> in src/modem.c:
> =

> static void sim_state_watch(enum ofono_sim_state new_state, void *user)
> {
> [...]
> case OFONO_SIM_STATE_READY:
> modem_change_state(modem, MODEM_STATE_OFFLINE);
> =

> ofono_lte_set_reginfo(modem);

How does this help you?  You might be in the OFFLINE state for a while =

and the LTE settings might still be messed with in that time.

> =

> /* Modem is always online, proceed to online state. */
> if (modem_is_always_online(modem) =3D=3D TRUE)
> set_online(modem, TRUE);
> =

> if (modem->online =3D=3D TRUE)
> modem_change_state(modem, MODEM_STATE_ONLINE);
> else if (modem->get_online)
> modem->driver->set_online(modem, 1, common_online_cb,
> modem);
> =

> modem->get_online =3D FALSE;
> =

> break;
> }
> =

> I see that if(modem_is_always_online) maybe it will come too late, but =

> in that case also the current solution
> with set_default_attach_info suffers from the same limitation, so no =

> regression.

The modem_is_always_online case is a bit strange, it is for really =

primitive devices which likely won't have an LTE atom anyway.

> =

> Of course then, again in src/lte.c, the function ofono_lte_set_reginfo =

> will look for an lte atom, if present will call it without parameter for =

> sending the AT+CGDCONT and AT+CGAUTH to the modem.
> =

> Would this work for you?
> =


I don't see how this helps.

Regards,
-Denis

--===============1584808356405104053==--

