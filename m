Content-Type: multipart/mixed; boundary="===============8829672206437250577=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Tue, 27 Apr 2010 14:14:41 +0300
Message-ID: <20100427111441.GA7453@jh-x301>
In-Reply-To: <1272335616.22838.121.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8829672206437250577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 27, 2010, Marcel Holtmann wrote:
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
> =

> I think that a g_dbus_method_call which is always async and take a
> pending call notifier is just enough.

In many cases you also want/need the ability to cancel the method call
before a reply has been received. If the DBusPendingCall object isn't
exposed to the caller then it seems canceling wouldn't be possible with
this API.

Johan

--===============8829672206437250577==--

