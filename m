Content-Type: multipart/mixed; boundary="===============7950945097188094450=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 20/20] SMS: Implement D-Bus SMS-MSG::GetProperties
Date: Mon, 02 Aug 2010 12:14:39 -0700
Message-ID: <1280776479.11046.651.camel@localhost.localdomain>
In-Reply-To: <4C4F14F8.5080700@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7950945097188094450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-27 at 10:18 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +static DBusMessage *dbus_sms_msg_get_properties(
> > +	DBusConnection * conn, DBusMessage *dbus_msg, void *_sms_msg)
> > +{
> > +	struct tx_queue_entry *sms_msg =3D _sms_msg;
> > +	DBusMessage *reply;
> > +	DBusMessageIter iter;
> > +	DBusMessageIter dict;
> > +	const char *str;
> > +
> > +	reply =3D dbus_message_new_method_return(dbus_msg);
> > +	if (!reply)
> > +		return NULL;
> =

> Empty line here
... =

> Empty line here
... =

> Empty line here
... =

> And one more here

Done

> Also, you might want to think about what other properties would be
> useful here.  E.g. perhaps queue time, submission time, To address,
> contents?

None are needed so far

Contents will be quite messy, as there is only binary encoded data at
this point and we might not even know how to decode it (let's say a
binary list of PDUs vs a text message).

Other immediate ones are submission and delivery time, which also means
we'd have to have a (property changed) signal for them and that'd
require adding another callback in the core code [I am talking
_txq_submit()]. I am going to leave it out for now because I don't want
to add more complexity -- it's easy to add them later, but will require
more changes.

> No double empty lines allowed.

fixed

> >  /*
> >   * Note that the D-Bus specific cleanups are taken care by the
> >   * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
> > @@ -564,6 +587,8 @@ static DBusMessage *dbus_sms_msg_cancel(
> >  =

> >  static
> >  GDBusMethodTable sms_msg_methods[] =3D {
> > +	{ "GetProperties",	"",	"a{sv}",
> > +	  dbus_sms_msg_get_properties, G_DBUS_METHOD_FLAG_ASYNC },
> =

> Why exactly is this method ASYNC?

Hmm, that was cut & paste from the manager's get_properties and it is
obviously wrong -- fixed thanks




--===============7950945097188094450==--

