Content-Type: multipart/mixed; boundary="===============8640679223195793872=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv5] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 18:06:43 +0100
Message-ID: <AANLkTi=u1D3jbA7s8BsToGC7qHRjHO-cFpLn+9xdATRm@mail.gmail.com>
In-Reply-To: <1294707482.3873.17.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8640679223195793872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> +static void get_modems()
>> +{
>
> so these are declared as get_modems(void) btw. The compiler should have
> warned you about this.

I don't get a compiler warning for this one, not even with -Wall
-Wextra -Wpedantic on GCC 4.4.3.
But a new rule in the coding-style should perhaps be added, e.g:

M15: Use void if function has no parameters
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
A function with no parameters must use void in the parameter list.
Example:
1)
void foo(void)
{
}

2)
void foo()	// Wrong
{
}

...
>> +static void mgr_disconnect(DBusConnection *connection, void *user_data)
>> +{
>> + =C2=A0 =C2=A0 g_hash_table_remove_all(modem_list);
>> + =C2=A0 =C2=A0 g_dbus_remove_watch(connection, property_changed_watch);
>> +}
>> +
....
>> +static void stemgr_exit()
>> +{
>> + =C2=A0 =C2=A0 g_hash_table_destroy(modem_list);
>> + =C2=A0 =C2=A0 g_dbus_remove_watch(connection, modem_daemon_watch);
>> + =C2=A0 =C2=A0 g_dbus_remove_watch(connection, property_changed_watch);
>
> This is not right. You need to remove the property_changed_watch in the
> disconnect callback. Otherwise if your daemon restarts twice you
> actually have two watches.
It's already present in mgr_disconnect, did you miss that?

In the previous review 2011/1/5 you said:
> +static void stemgr_exit()
> +{
>The only thing you missed here is to remove the property changed watch
>in case it was registered (aka the init daemon started).

Anyway, I think the watch handing in the latest patch is correct,
we need to do remove_watch for property_changed_watch
in both stemgr_exit and in stemgr_disconnect.

Regards,
Sjur

--===============8640679223195793872==--

