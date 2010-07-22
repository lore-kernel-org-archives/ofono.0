Content-Type: multipart/mixed; boundary="===============2990506652124733841=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] doc: stk-api proposal
Date: Thu, 22 Jul 2010 04:01:58 +0200
Message-ID: <AANLkTinvqZ-AJtx_bitEJ8mWybNDcJzRWQz5ooy96hya@mail.gmail.com>
In-Reply-To: <4C478F58.9050309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2990506652124733841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 22 July 2010 02:22, Denis Kenzior <denkenz@gmail.com> wrote:
> On 07/21/2010 05:06 PM, Shane Bryan wrote:
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [service].Error.No=
tFound
>>> +
>>> [service].Error.NotAuthorized +
>>
>> - What are the plans for the configuration of services/object paths for
>> =C2=A0 "launch-able" Terminal Applications (AKA, Agents?)? =C2=A0Will th=
ere be a
>> =C2=A0 stk.conf file or similar or will this be protected in a dbus serv=
ice
>> =C2=A0 config file?

Most likely the Terminal Applications capability will not be
implemented for a while, it is not used by popular SIMs and is not
very practical.  It may be implemented if needed.

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string GetInput(string alpha=
, array{byte} icon,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0string default, byte min, byte max,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0boolean hide_typing)
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Tells the agent to request an input string
>>> from the
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
user. =C2=A0The alpha parameter and icon gives
>>> context to
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
the user. =C2=A0The default string contains the
>>> suggested
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
default by the SIM. =C2=A0The min and max
>>> parameters contain
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
how many characters the user should enter.
>>> The
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
parameter hide_typing indicates whether
>>> user's typing
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
should be opaque.
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Possible Errors:
>>> [service].Error.SimToolkit.GoBack +
>>
>> - Same questions as above regarding the icon data formatting.
>>
>> - Given the min/max constraints, plus the default value, I assume
>> =C2=A0 that if the input provided by the user falls within (inclusive) b=
oth
>> =C2=A0 conditions, this is what is returned, otherwise the value of defa=
ult
>> =C2=A0 is returned, correct?
>
> No, this is more about validation. =C2=A0E.g. the agent should not return
> more than max or less than min characters. =C2=A0A maximum value of 255 m=
eans
> no maximum is given.
>
> The user can either accept the default value or enter his own input.

This really just means a text input field, with the default text as
initial value, if any.

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string GetKey(string alpha, =
array{byte} icon)
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Tells the agent to request a single input
>>> key from
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
the user. =C2=A0The alpha parameter contains the
>>> context
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
for the request.
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Possible Errors:
>>> [service].Error.SimToolkit.GoBack +
>>
>> - I am assuming this "Key" is in fact meant to imply a single
>> =C2=A0 Character, not a scan code or keycode from some hardware key,
>> =C2=A0 correct? =C2=A0May seem obvious to some, but I can't always be su=
re.
>>
>
> Correct

The SIM either requests a single gsm 7-bit character, a single unicode
character or a single key press (on the physical keypad), depending on
the parameters of the SIM command.  However this api does not make a
distiction between these options (the previous api does has an
"alphabet" parameter).

>>
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void Release()
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Agent is being released, possibly because of
>>> oFono
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
terminating, SimToolkit interface torn down
>>> or modem
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
off. =C2=A0If the agent is registered as a global
>>> agent,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
no UnregisterAgent call is expected.
>>
>> Ok, so in this case, the SimToolkit will call the agents Release()
>> method when (as asked above in the RegisterAgent() comments) the modem
>> Powered state goes from true to false (as well as under other possible
>> conditions, yeah, I know), correct?

Yes, additionally ofono will call Release() on the "user-initiated
agent" when the card wants the UI to go back to the main menu or close
the UI altogether.  The spec suggests / recommends that basically the
application should go to main menu if the last action performed was a
GoBack button press, otherwise the application should exit, but it may
depend on the specific use case.  For example the javascript GUI
client I use for testing this always has screen space available so it
always goes to main menu.

Regards

--===============2990506652124733841==--

