Content-Type: multipart/mixed; boundary="===============4096965272022859595=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: airplane mode
Date: Mon, 22 Oct 2018 12:02:29 -0500
Message-ID: <c264e35a-d7e3-fab0-b307-e3f5dee64ccf@gmail.com>
In-Reply-To: <CAKSBH7GnR1cMpdARRPxG5SUoir1jU3jaSFYrxYC7NH0m=oFqAg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4096965272022859595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> And it is fully possible to make emergency calls.  Just set Online=3DTrue
>> first.
> =

> ahh, like that yes.... but then, wouldn't be better to create the
> voicecall atom where it belongs, in post_online ?
> Or this stage is never reached without a SIM? If not, what handle we
> have that is called for sure after AT+CFUN=3D1 ?
> =


Correct, without a SIM or PIN not unlocked, you'd never get to =

post_online, even Online=3DTrue being set.

You can watch the modem state, but I don't recall that any of our modems =

had this issue...

>>> Also, several test commands fail in airplane mode, e.g.: AT+CLCK=3D?
>>
>> I doubt this has anything to do with airplane mode.  Is it that the SIM
>> is not initialized yet?  But even then, why would the firmware not
>> report all available locks regardless?
>>
> =

> According to the 27.007 (and our modules) AT+CLCK interrogates the
> network for some locks, and for this it must be online.
> Au passage, the 27.007 mentions explicitly that the command must be
> abortable when network facilities are set or interrogated.

Sure, but we're not setting or interrogating any network locks.  We're =

just testing the capability of the modem.  So the above 27.007 part does =

not apply.

> =

> So, that command is not well placed when the module is in CFUN=3D4.
> I don't know on what insane kind of modules it has been tested, but it
> is wrong ;)

I would disagree.  We use CLCK to query for SIM locks, facility locks, =

etc...

> =

>>>
>>> Is there a way to re-initialize all required atoms at the post-inline s=
tage?
>>> Or should they be destroyed and re-created?
>>>
>>
>> destroying and recreating is a bad idea because they will be moved into
>> a different modem state level.  So the next time you go to airplane mode
>> you will lose your SIM atom.
>>
>> You can always listen to modem state changes in the driver, but I
>> wouldn't recommend it.  The simplest answer is to fix your firmware ;)
> =

> Let's think about a more reasonable solution.
> Again, if there is an handle that is called after AT+CFUN=3D1,
> regardless of the SIM presence, that would be the perfect place.
> =


You can only listen to modem state changes.  oFono core doesn't know =

anything about CFUN=3D1.

Regards,
-Denis

--===============4096965272022859595==--

