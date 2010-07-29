Content-Type: multipart/mixed; boundary="===============8062046874892161000=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 13/20] SMS: encapsulate D-Bus specific data in 'struct
 sms_msg_dbus_data'
Date: Thu, 29 Jul 2010 14:47:49 -0700
Message-ID: <1280440069.16826.80.camel@localhost.localdomain>
In-Reply-To: <4C4F12AA.3040501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8062046874892161000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-27 at 10:08 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +/*
> > + * Encapsulate information needed to export an SMS message over D-Bus.
> > + *
> > + * @dbus_path: path of the object in the D-Bus
> > + * @dbus_msg: message this originated at
> > + */
> > +struct sms_msg_dbus_data {
> > +	char *dbus_path;
> > +	DBusMessage *dbus_msg;
> > +};
> > +
> =

> I don't really see a point for this structure.  When you send an SMS,
> assuming the arguments and format were valid, you return straight away.
>  Thus SendMessage should be marked as not being ASYNC and storing of
> DBusMessage is unnecessary.  Rest can be handled by txq_submit and the
> dbus path can be easily generated based on the UUID.

First it serves as transitional storage -- later in the commit sequences
the dbus_msg is removed as it is, as you say, unneeded once all the code
is made sync. If at the end only one member is left (dbus_msg)

In our discussions to plan this stuff you said you wanted the D-Bus
unique name to contain the UUID and the number of PDUs
(/modemX/UUID_PDUs). That means I need to access the SMS object if I
want to generate the name on the fly. I need a backpointer for that.

Even if we remove the _PDUs requirement:

To generate on the fly whenever is needed we need to have access to who
is the 'parent' in:

- the destructor function, which is not going to be easy

- the PropertyChanged signal generator

which means that instead of storing a name I have to store, for example
the 'struct ofono_sms' that is the parent, get its name, figure out how
to pull the name of the SMS object from a UUID *and* then generate a
name *and* do the actual work.

That is not effective and adds more code. Generating the name once and
storing it is the simplest solution. If you want it out of the structure
that encapsulates it, well I can do that as a final follow up patch once
dbus_msg is no longer needed. It's syntactic sugar to enforce
encapsulation.

> >  /*
> > @@ -590,6 +604,9 @@ static void send_message_destroy(void *data)
> >   * is created by tx_queue_entry_new() and g_queue_push_tail()
> >   * appends that entry to the SMS transmit queue. Then the tx_next()
> >   * function is scheduled to run to process the queue.
> > + *
> > + * @sms is the main SMS driver struct, @entry and @msg_list represent
> > + * the current message being processed.
> >   */
> >  static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage=
 *msg,
> >  					void *data)
> =

> This chunk seems totally unrelated...

Yep, it is -- this should be a separate doc commit. Thanks for catching
it.




--===============8062046874892161000==--

