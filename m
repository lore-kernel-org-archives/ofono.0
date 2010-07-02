Content-Type: multipart/mixed; boundary="===============6982531948693659720=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Sat, 03 Jul 2010 01:40:04 +0200
Message-ID: <AANLkTin7W2jI49AkuWBd545wCMYLs31oRO0J5o8sgDAE@mail.gmail.com>
In-Reply-To: <4C2E4A1E.3020004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6982531948693659720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2 July 2010 22:20, Denis Kenzior <denkenz@gmail.com> wrote:
>>> So it seems to me with the exception of Setup Menu and Idle Mode Text we
>>> should simply reject the Proactive Command outright if there is no Agent
>>> registered.
>>>
>>> This will prevent weird situations where a proactive command is pending
>>> for Timeout - 1 seconds, an agent is registered, we send the agent the
>>> command and 1 second later the User gets booted out. =C2=A0It also seem=
s to
>>> make the implementation easier...
>>
>> As I mentioned in the other mail, I believe it's in line with the dbus
>> design that clients can connect and disconnect any time, and it
>> shouldn't affect the state. =C2=A0If we choose to do it differently, I
>
> I have to disagree here. =C2=A0While what you say is true in the 'classic=
al'
> D-Bus usage, it is not true of Agents. =C2=A0An Agent going away should
> affect state, and I really don't want to deal with the 'abrupt user
> interruption' caused by doing it this way.
>
>> think it ties the interface very much to dbus implementation and the
>> single type of users like a Home Screen app on a phone. =C2=A0This use c=
ase
>> is not affected if we allow agents to connect and disconnect, so
>> absolutely there's no harm in doing it intelligently.
>
> Actually for the most part that is exactly what we want, a nice and
> optimized way for the UI to interact with oFono. =C2=A0As I pointed out
> earlier, we're not making a fully generic stack. =C2=A0In the case of STK
> only a single always-resident Agent is really required. =C2=A0So I'm agai=
nst
> complicating either Agents or the core unnecessarily. =C2=A0However, I
> welcome anyone else's input here.

I don't mind doing it the way you propose, but I'd really appreciate
if you can comment on api proposal before I implement it instead of
after :)  Basically you read the code, say "oh, this is how it works
(repeating almost word for word the proposal), let's do it
differently".  (Both this request lifetime thing and the Timeout
property)

My personal opinion though (just saying it so I can quote myself) is
that the agent is not a good reason to evade some d-bus principles,
they're there to make life easier for API users.  In this case it also
makes things easier on ourselves.  I also don't think that's a good
excuse to dumb the api down for a particular use case, I myself have
described ofono to people as the linux telephony stack. So I think
this kind of things can come back and bite.

>
>>
>> I agree with moving members related to the agent to a separate struct,
>> but I think the agent itself should be separate, so it can disconnect
>> and connect when it feels like it.
>
> <snip>
>
>>>> + =C2=A0 =C2=A0 if (!strcmp(property, "Timeout")) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dbus_message_iter_get_=
arg_type(&var) !=3D DBUS_TYPE_UINT16)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return __ofono_error_invalid_args(msg);
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_get_basi=
c(&var, &timeout);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dbus_message_iter_next=
(&iter))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return __ofono_error_invalid_args(msg);
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->timeout =3D timeout;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk->cmd_timeout && st=
k->custom_timeout =3D=3D 0) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 g_source_remove(stk->cmd_timeout);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 app_agent_request_timeout, stk);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> This doesn't seem right to me, what if we have just 1 second left on our
>>> timeout and the Timeout property is set? =C2=A0We end up resetting the
>>> timeout completely. =C2=A0What do you think of simply using the new val=
ue for
>>> all subsequent requests?
>>>
>>> I actually question the need for this attribute, who's going to actually
>>> set it? =C2=A0Let us default to some reasonable value and add a SetProp=
erty
>>> for this later if required...
>>
>> I was thinking in particular of things like writing an e-mail.
>>
>> When you navigate the menus, 20 seconds seem like a good value for the
>> timeout, or when you're shown a message like "SMS deliver". =C2=A0This is
>> about what my old Nokia dumb-phone menu timeout was. =C2=A0But the SIM I
>> tested has a "write an e-mail" application, so it sends a Get Input
>> proactive command so you can type the contents of the e-mail, and 20
>> seconds seems very short. =C2=A0So in my python test client I set the
>
> Get Input can override the duration, is it not happening in this case?

Get InKey can override the timeout, but Get Input can't.  The reason
for the timeout is that while a command is executing other
communications with the card may be blocked, so we may want the ui
programmer to note how much time it is using.

I think it would make sense to get rid of the timeout completely, if
the Agent was registered exactly for the duration of the "UICC
proactive session".  I haven't found a good definition in TS102.223 of
the proactive UICC session, but "6.9 Proactive UICC session and
terminal display interaction" makes it sound like a session is
basically started by choosing an element from the main menu, and
terminates when we go back to the main menu (no other command is
pending).

So when the user launches a SIM Applications app on their device, they
would see the main menu.  Menu would be available as a property of the
D-bus interface, and the user would register an agent and provide a
selection from the menu at the same time.  Then when the session ends,
the agent would be released at the same time.  The question is if a
session can be started by the UICC, there's no indication that it can
or cannot, but I haven't seen the sim use any command like DisplayText
on a different occasion than when navigating the menu.  For any other
command, like SendSMS, call control etc, an Alpha Id is supplied
instead of using DisplayText.

Best regards,
Andrew

--===============6982531948693659720==--

