Content-Type: multipart/mixed; boundary="===============8641166637022553296=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Fri, 30 Apr 2010 20:40:11 -0300
Message-ID: <20100430234011.GB11712@vigoh>
In-Reply-To: <1272335616.22838.121.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8641166637022553296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Marcel Holtmann <marcel@holtmann.org> [2010-04-27 04:33:36 +0200]:

> Hi Gustavo,
> =

> > Puting send_method_call and send_method_call_with_reply on g_dbus will
> > avoid some code duplication and will make things easier mainly for the
> > Bluetooth plugins (HFP, DUN, SAP) inside oFono.
> > ---
> >  gdbus/gdbus.h  |   12 ++++
> >  gdbus/object.c |   81 +++++++++++++++++++++++++++++
> >  plugins/hfp.c  |  154 +++++++++++++-----------------------------------=
-------
> >  3 files changed, 130 insertions(+), 117 deletions(-)
> =

> first of all, we don't intermix gdbus patches with other changes.
> Remember that these commits have to be applied to BlueZ and ConnMan as
> well.
> =

> > diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> > index 47e18cf..ac488c5 100644
> > --- a/gdbus/gdbus.h
> > +++ b/gdbus/gdbus.h
> > @@ -106,12 +106,24 @@ DBusMessage *g_dbus_create_error_valist(DBusMessa=
ge *message, const char *name,
> >  DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...);
> >  DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
> >  						int type, va_list args);
> > +DBusMessage *g_dbus_create_method_call(const char *dest, const char *p=
ath,
> > +				const char *interface, const char *method,
> > +				int type, va_list args);
> >  =

> >  gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *=
message);
> >  gboolean g_dbus_send_reply(DBusConnection *connection,
> >  				DBusMessage *message, int type, ...);
> >  gboolean g_dbus_send_reply_valist(DBusConnection *connection,
> >  				DBusMessage *message, int type, va_list args);
> > +gboolean g_dbus_send_method_call(DBusConnection *connection, const cha=
r *dest,
> > +				const char *path, const char *interface,
> > +				const char *method, int type, ...);
> > +gboolean g_dbus_send_method_call_with_reply(DBusConnection *connection,
> > +				const char *dest, const char *path,
> > +				const char *interface, const char *method,
> > +				DBusPendingCallNotifyFunction cb,
> > +				void *user_data, DBusFreeFunction free_func,
> > +				int timeout, int type, ...);
> =

> Is there any real reason to export send_method_call and
> create_method_call? What are these good for and what are your expected
> users of these?

I'm trying to avoid call 3 functions every time I want call a dbus
method. Today we have to do:

 dbus_message_new_method_call()
 dbus_message_append_args()
 g_dbus_send_message()

With the call I'm proposing we just call g_dbus_send_method_call() to
call a dbus method. HFP plugin (and soon the DUN plugin) will make use
of that function a lot. The same goes for
g_dbus_send_method_call_with_reply().

My idea could be wrong since I'm not a DBus expertise. ;)

> =

> I think that a g_dbus_method_call which is always async and take a
> pending call notifier is just enough.
> =

> All the other helpers are more for callbacks that have to respond to
> messages than for client usage.
> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

-- =

Gustavo F. Padovan
http://padovan.org

--===============8641166637022553296==--

