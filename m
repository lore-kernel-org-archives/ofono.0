Content-Type: multipart/mixed; boundary="===============8618811325913046134=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv5] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 13:52:36 -0800
Message-ID: <1294782756.3873.37.camel@aeonflux>
In-Reply-To: <AANLkTi=u1D3jbA7s8BsToGC7qHRjHO-cFpLn+9xdATRm@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8618811325913046134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > so these are declared as get_modems(void) btw. The compiler should have
> > warned you about this.
> =

> I don't get a compiler warning for this one, not even with -Wall
> -Wextra -Wpedantic on GCC 4.4.3.
> But a new rule in the coding-style should perhaps be added, e.g:
> =

> M15: Use void if function has no parameters
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> A function with no parameters must use void in the parameter list.
> Example:
> 1)
> void foo(void)
> {
> }
> =

> 2)
> void foo()	// Wrong
> {
> }

please go ahead and send a patch for this. I am happily adding it.

> ...
> >> +static void mgr_disconnect(DBusConnection *connection, void *user_dat=
a)
> >> +{
> >> +     g_hash_table_remove_all(modem_list);
> >> +     g_dbus_remove_watch(connection, property_changed_watch);
> >> +}
> >> +
> ....
> >> +static void stemgr_exit()
> >> +{
> >> +     g_hash_table_destroy(modem_list);
> >> +     g_dbus_remove_watch(connection, modem_daemon_watch);
> >> +     g_dbus_remove_watch(connection, property_changed_watch);
> >
> > This is not right. You need to remove the property_changed_watch in the
> > disconnect callback. Otherwise if your daemon restarts twice you
> > actually have two watches.
> It's already present in mgr_disconnect, did you miss that?

I did miss that. So you are correct, but you should add

	property_changed_watch =3D 0

to mgr_disconnect.

And then do this in stemgr_exit

	if (property_changed_watch > 0)
		g_dbus_remove_watch(...


> In the previous review 2011/1/5 you said:
> > +static void stemgr_exit()
> > +{
> >The only thing you missed here is to remove the property changed watch
> >in case it was registered (aka the init daemon started).
> =

> Anyway, I think the watch handing in the latest patch is correct,
> we need to do remove_watch for property_changed_watch
> in both stemgr_exit and in stemgr_disconnect.

I got lost a little bit, but you still need to make sure to not remove a
watch on plugin exit in case modem init manager not running as I
mentioned above.

Regards

Marcel



--===============8618811325913046134==--

