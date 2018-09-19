Content-Type: multipart/mixed; boundary="===============9036533899728444826=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Wed, 19 Sep 2018 11:30:19 -0500
Message-ID: <6991808a-8090-ef91-eef3-1d0e8b9f0789@gmail.com>
In-Reply-To: <CAKSBH7EXVzFTHPdG3QofsHW5ULP=XnpgHfKpp=Y+E_44eHoGzQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9036533899728444826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> so, first the documentation?

Correct.  Whenever you touch something that affects the D-Bus API, it is =

really preferable to have the D-Bus API changes in the preceding commit. =

  That way the reviewers can cross-reference what is being proposed to =

the actual implementation.  Anything that breaks the D-Bus API can also =

be spotted much earlier.

oFono's D-Bus API is stable.  That means we can add new things, but we =

cannot change existing ones as that will break existing clients.

We also cannot break existing settings, as that would break oFono =

installations on existing devices if they are upgraded.

This is a handicap that we have to live with right now.

<snip>

> =

> So there can be no unification with the GPRS naming now that the D-Bus =

> API is set?

I'm afraid not.  But I'm not sure why this is a problem?

> =

>      > +#define LTE_PROTO "Protocol"
>      > +#define LTE_USERNAME "Username"
>      > +#define LTE_PASSWORD "Password"
>      > +#define LTE_AUTH_METHOD "AuthenticationMethod"
>      >
>      >=C2=A0 =C2=A0struct ofono_lte {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ofono_lte_driver *driver;
>      > @@ -50,13 +55,82 @@ struct ofono_lte {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMessage *pending;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_lte_default_attach_info pen=
ding_info;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_lte_default_attach_info inf=
o;
>      > +=C2=A0 =C2=A0 =C2=A0const char *prop_changed;
> =

>     ??=C2=A0 What memory location is this const char pointing to?
> =

> =

> it is initialized to null with the containing structure.

That is not what I'm asking.  This pointer points into data owned by =

DBusMessage and the semantics of whether it is valid or not are not =

enforced.  Avoid that at all cost...

> =

> What about reading also the previous key?

Ideally you shouldn't change the key in the first place.  But if you =

are, then yes you need to be able to read legacy settings versions in =

order to be backwards-compatible.

> =

>     You do realize you're never actually calling into the driver method,
>     right?=C2=A0 So none of these changes actually go out to the modem.=
=C2=A0 Have
>     you
>     actually tested any of this?
> =

> =

> Yes, it works. Actually the only call is when the APN is set, as =

> mentioned in the lte-api.txt.

No, it really doesn't...

> And at that point all parameters are also set in the module.
> It is not possible to set separately protocol and apn, and auth_method, =

> username, and password.
> For ublox modules, the auth_method is also part of the APN name.
> =

> So we kept the call into the module when the APN is set, and previously =

> to it all other parameters are set.

You simply cannot do that.  You cannot assume that the client knows how =

your API is implemented underneath.  So if they set the APN first and =

then change the username, that has to work.  This is why the =

default_attach_info contains everything.  If anything is changed the =

entire structure is sent to the modem and every parameter is updated.

> =

> You have also mentioned that somewhere we should also verify that with =

> AUTH_NONE there are no user/pwd.
> This also can only be verified at the end.
> =

> Any suggestions to improve this, given these limitations?
> =


See above.  Any parameter change has to trigger =

set_default_attach_info() call.  If something is invalid, then you have =

to return a D-Bus error.

For example, if my method is set to 'none' and I try to do =

LongTermEvolution.SetProperty("DefaultUsername", "foo") that should =

return an error.

> =

>      > +=C2=A0 =C2=A0 =C2=A0return dbus_message_ref(msg);;
>      >=C2=A0 =C2=A0}
>      >
>      >=C2=A0 =C2=A0static DBusMessage *lte_set_property(DBusConnection *c=
onn,
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMe=
ssage *msg, void *data)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DBusMessage *msg,
>     void *data)
>      >=C2=A0 =C2=A0{
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_lte *lte =3D data;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMessageIter iter;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMessageIter var;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *property;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *str;
>      > +=C2=A0 =C2=A0 =C2=A0enum ofono_gprs_auth_method auth_method;
>      > +=C2=A0 =C2=A0 =C2=A0enum ofono_gprs_proto proto;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0if (lte->driver->set_default_attach_info =3D=
=3D NULL)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __ofono_er=
ror_not_implemented(msg);
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0if (lte->pending)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __ofono_er=
ror_busy(msg);
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dbus_message_iter_init(msg, &iter))
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __ofo=
no_error_invalid_args(msg);
>      > @@ -192,13 +428,58 @@ static DBusMessage
>     *lte_set_property(DBusConnection *conn,
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_message_iter_recurse(&iter, &var);
>      >
>      > -=C2=A0 =C2=A0 =C2=A0if (!strcmp(property, DEFAULT_APN_KEY)) {
>      > +=C2=A0 =C2=A0 =C2=A0lte->prop_changed=3Dproperty;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0if (!strcmp(property, LTE_PROTO)) {
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dbus_message_=
iter_get_arg_type(&var) !=3D
>     DBUS_TYPE_STRING)
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return __ofono_error_invalid_args(msg);
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_message_iter=
_get_basic(&var, &str);
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gprs_proto_fr=
om_string(str, &proto))
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return lte_set_proto(lte, conn, msg, proto);
> =

>     The return from this callback is always supposed to be a method_return
>     or NULL if the method_return will be done asynchronously (in your case
>     always)=C2=A0 You're somehow returning the method_call itself...
> =

> =

> I am not sure I follow you, but you suggested to restructure the code, =

> so I will come back on this later.

You need to understand the semantics of GDBus.  GDBUS_ASYNC_METHOD() =

callback can only return the D-Bus method_return for message or NULL if =

the method return will be generated asynchronously.  You cannot return =

the message itself.  While this may 'work' the behavior is undefined.

>      > +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *l=
te)
>      > +{
>      > +=C2=A0 =C2=A0 =C2=A0return __ofono_atom_get_modem(lte->atom);
>      > +}
>      > \ No newline at end of file
> =

>     Fix this.
> =

> =

> ?

You have no newline after the last '}' and git complains.  If git =

complains I cannot apply the patch...

> =

> I agree it is unrelated, I will post a separate post, but I turn on =

> NEED_THREADS, and the build fails. Looking at the g_thread =

> documentations, nowadays it has to come out of the code:
> =

> |g_thread_init|=C2=A0has been deprecated since version 2.32 and should no=
t be =

> used in newly-written code.
> =

> This function is no longer necessary. The GLib threading system is =

> automatically initialized at the start of your program.
> =


Okay, please send this as a separate patch.  We might need to remove =

this configure option as well.

Regards,
-Denis

--===============9036533899728444826==--

