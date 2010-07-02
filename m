Content-Type: multipart/mixed; boundary="===============3199063560236026334=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Fri, 02 Jul 2010 21:55:51 +0200
Message-ID: <AANLkTikkIUm1oD-ip_olA9NthV-I-ttP0_xw7J_W36WN@mail.gmail.com>
In-Reply-To: <4C2E2035.6050305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3199063560236026334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 2 July 2010 19:21, Denis Kenzior <denkenz@gmail.com> wrote:
> So to summarize here:
> =C2=A0 =C2=A0 =C2=A0 =C2=A01. If there's no agent, we start the command a=
nyway
> =C2=A0 =C2=A0 =C2=A0 =C2=A02. When the agent arrives, we send it the comm=
and to handle
> =C2=A0 =C2=A0 =C2=A0 =C2=A03. If the agent goes away, we don't cancel the=
 command
> =C2=A0 =C2=A0 =C2=A0 =C2=A04. If the agent is unregistered, we send a can=
cel but don't cancel the
> command

That's about right.

>
> So it seems to me with the exception of Setup Menu and Idle Mode Text we
> should simply reject the Proactive Command outright if there is no Agent
> registered.
>
> This will prevent weird situations where a proactive command is pending
> for Timeout - 1 seconds, an agent is registered, we send the agent the
> command and 1 second later the User gets booted out. =C2=A0It also seems =
to
> make the implementation easier...

As I mentioned in the other mail, I believe it's in line with the dbus
design that clients can connect and disconnect any time, and it
shouldn't affect the state.  If we choose to do it differently, I
think it ties the interface very much to dbus implementation and the
single type of users like a Home Screen app on a phone.  This use case
is not affected if we allow agents to connect and disconnect, so
absolutely there's no harm in doing it intelligently.

I agree with moving members related to the agent to a separate struct,
but I think the agent itself should be separate, so it can disconnect
and connect when it feels like it.

>> +
>> +static struct stk_app_agent *app_agent_create(struct ofono_stk *stk,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *sender)
>> +{
>> + =C2=A0 =C2=A0 struct stk_app_agent *agent =3D g_try_new0(struct stk_ap=
p_agent, 1);
>> + =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection();
>> +
>> + =C2=A0 =C2=A0 if (!agent)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>> + =C2=A0 =C2=A0 agent->path =3D g_strdup(path);
>> + =C2=A0 =C2=A0 agent->bus =3D g_strdup(sender);
>> +
>> + =C2=A0 =C2=A0 agent->watch =3D g_dbus_add_disconnect_watch(conn, sende=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_agent_disconnect_cb,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk, NULL);
>> +
>> + =C2=A0 =C2=A0 if (stk->app_agent_state !=3D STK_AGENT_IDLE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_agent_request_send(stk, =
agent);
>> +
>
> This looks a bit dangerous, you're sending a request to the agent before
> it is registered. =C2=A0Please be nice and perform the RegisterAgent meth=
od
> return first, and then send the request.

Good point, I'll move it.  (In my tests it always worked though)

>
>> + =C2=A0 =C2=A0 return agent;
>> +}
>
> <snip>
>
>> +
>> +static DBusMessage *stk_set_property(DBusConnection *conn,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBusMessage *msg, v=
oid *data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_stk *stk =3D data;
>> + =C2=A0 =C2=A0 const char *path =3D __ofono_atom_get_path(stk->atom);
>> + =C2=A0 =C2=A0 DBusMessageIter iter;
>> + =C2=A0 =C2=A0 DBusMessageIter var;
>> + =C2=A0 =C2=A0 const char *property;
>> + =C2=A0 =C2=A0 dbus_uint16_t timeout;
>> +
>> + =C2=A0 =C2=A0 if (!dbus_message_iter_init(msg, &iter))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_invalid=
_args(msg);
>> +
>> + =C2=A0 =C2=A0 if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE=
_STRING)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_invalid=
_args(msg);
>> +
>> + =C2=A0 =C2=A0 dbus_message_iter_get_basic(&iter, &property);
>> + =C2=A0 =C2=A0 if (!dbus_message_iter_next(&iter))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_invalid=
_args(msg);
>> +
>> + =C2=A0 =C2=A0 if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE=
_VARIANT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_invalid=
_args(msg);
>> +
>> + =C2=A0 =C2=A0 dbus_message_iter_recurse(&iter, &var);
>> +
>> + =C2=A0 =C2=A0 if (!strcmp(property, "Timeout")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dbus_message_iter_get_ar=
g_type(&var) !=3D DBUS_TYPE_UINT16)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return __ofono_error_invalid_args(msg);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_get_basic(=
&var, &timeout);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dbus_message_iter_next(&=
iter))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return __ofono_error_invalid_args(msg);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->timeout =3D timeout;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk->cmd_timeout && stk-=
>custom_timeout =3D=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
g_source_remove(stk->cmd_timeout);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 app_agent_request_timeout, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> This doesn't seem right to me, what if we have just 1 second left on our
> timeout and the Timeout property is set? =C2=A0We end up resetting the
> timeout completely. =C2=A0What do you think of simply using the new value=
 for
> all subsequent requests?
>
> I actually question the need for this attribute, who's going to actually
> set it? =C2=A0Let us default to some reasonable value and add a SetProper=
ty
> for this later if required...

I was thinking in particular of things like writing an e-mail.

When you navigate the menus, 20 seconds seem like a good value for the
timeout, or when you're shown a message like "SMS deliver".  This is
about what my old Nokia dumb-phone menu timeout was.  But the SIM I
tested has a "write an e-mail" application, so it sends a Get Input
proactive command so you can type the contents of the e-mail, and 20
seconds seems very short.  So in my python test client I set the
timeout to 2 minutes for Get Input (should actually reset the timeout
everytime you stop typing).

>> +static DBusMessage *stk_unregister_agent(DBusConnection *conn,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DBusMessage *msg, void *data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_stk *stk =3D data;
>> + =C2=A0 =C2=A0 const char *agent_path;
>> +
>> + =C2=A0 =C2=A0 if (dbus_message_get_args(msg, NULL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_OBJECT_PA=
TH, &agent_path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_INVALID) =
=3D=3D FALSE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_invalid=
_args(msg);
>> +
>> + =C2=A0 =C2=A0 if (!stk->app_agent || strcmp(stk->app_agent->path, agen=
t_path))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_failed(=
msg);
>> +
>
> One other thing to keep in mind here is that only the sender who
> registered the agent should be able to unregister it. =C2=A0This prevents
> some random app from messing with the system. =C2=A0However, this can be
> added later if leaving this check out helps in testing in the short term.

I actually forgot the check, we just need to compare the
stk->app_agent->bus value.

Best regards,
Andrew

--===============3199063560236026334==--

