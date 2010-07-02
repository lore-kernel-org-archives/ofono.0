Content-Type: multipart/mixed; boundary="===============5747169355964583812=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Fri, 02 Jul 2010 15:20:46 -0500
Message-ID: <4C2E4A1E.3020004@gmail.com>
In-Reply-To: <AANLkTikkIUm1oD-ip_olA9NthV-I-ttP0_xw7J_W36WN@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5747169355964583812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> So it seems to me with the exception of Setup Menu and Idle Mode Text we
>> should simply reject the Proactive Command outright if there is no Agent
>> registered.
>>
>> This will prevent weird situations where a proactive command is pending
>> for Timeout - 1 seconds, an agent is registered, we send the agent the
>> command and 1 second later the User gets booted out.  It also seems to
>> make the implementation easier...
> =

> As I mentioned in the other mail, I believe it's in line with the dbus
> design that clients can connect and disconnect any time, and it
> shouldn't affect the state.  If we choose to do it differently, I

I have to disagree here.  While what you say is true in the 'classical'
D-Bus usage, it is not true of Agents.  An Agent going away should
affect state, and I really don't want to deal with the 'abrupt user
interruption' caused by doing it this way.

> think it ties the interface very much to dbus implementation and the
> single type of users like a Home Screen app on a phone.  This use case
> is not affected if we allow agents to connect and disconnect, so
> absolutely there's no harm in doing it intelligently.

Actually for the most part that is exactly what we want, a nice and
optimized way for the UI to interact with oFono.  As I pointed out
earlier, we're not making a fully generic stack.  In the case of STK
only a single always-resident Agent is really required.  So I'm against
complicating either Agents or the core unnecessarily.  However, I
welcome anyone else's input here.

> =

> I agree with moving members related to the agent to a separate struct,
> but I think the agent itself should be separate, so it can disconnect
> and connect when it feels like it.

<snip>

>>> +     if (!strcmp(property, "Timeout")) {
>>> +             if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_U=
INT16)
>>> +                     return __ofono_error_invalid_args(msg);
>>> +
>>> +             dbus_message_iter_get_basic(&var, &timeout);
>>> +             if (dbus_message_iter_next(&iter))
>>> +                     return __ofono_error_invalid_args(msg);
>>> +
>>> +             stk->timeout =3D timeout;
>>> +
>>> +             if (stk->cmd_timeout && stk->custom_timeout =3D=3D 0) {
>>> +                     g_source_remove(stk->cmd_timeout);
>>> +                     stk->cmd_timeout =3D g_timeout_add_seconds(stk->t=
imeout,
>>> +                                             app_agent_request_timeout=
, stk);
>>> +             }
>>
>> This doesn't seem right to me, what if we have just 1 second left on our
>> timeout and the Timeout property is set?  We end up resetting the
>> timeout completely.  What do you think of simply using the new value for
>> all subsequent requests?
>>
>> I actually question the need for this attribute, who's going to actually
>> set it?  Let us default to some reasonable value and add a SetProperty
>> for this later if required...
> =

> I was thinking in particular of things like writing an e-mail.
> =

> When you navigate the menus, 20 seconds seem like a good value for the
> timeout, or when you're shown a message like "SMS deliver".  This is
> about what my old Nokia dumb-phone menu timeout was.  But the SIM I
> tested has a "write an e-mail" application, so it sends a Get Input
> proactive command so you can type the contents of the e-mail, and 20
> seconds seems very short.  So in my python test client I set the

Get Input can override the duration, is it not happening in this case?

> timeout to 2 minutes for Get Input (should actually reset the timeout
> everytime you stop typing).

Fair enough, but my view is that using this attribute is still the wrong
way to solve this.  I'd simply default to an infinite timeout for Get
Input, Get Inkey unless the SIM overrides the duration.  There's no need
to involve the UI here.

Regards,
-Denis

--===============5747169355964583812==--

