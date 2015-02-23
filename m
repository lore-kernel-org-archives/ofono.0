Content-Type: multipart/mixed; boundary="===============3459796643479305337=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: Re: Re: [PATCH 0/2] Add ResetProperties method to ConnectionContext
 interface
Date: Mon, 23 Feb 2015 14:31:06 +0200
Message-ID: <CAAVgdeFqOXKC+8=ce-g6Yg4gE+TuxhAOLkxxFqnfzPt6nV5bgA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3459796643479305337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Date: Fri, 20 Feb 2015 10:00:31 -0600
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 0/2] Add ResetProperties method to
>         ConnectionContext interface
> Message-ID: <54E75A1F.8070709@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> Hi Tommi,
>
> On 02/19/2015 05:59 AM, Tommi Kenakkala wrote:
>> In some cases it is useful to reset connection context settings back to =
ones
>> ofono provisioning resolved initially.
>> What's your opinion on the API design, implementation and use-case descr=
ibed
>> next?
>>
> Why don't you just remove the settings file and restart oFono?
oFono handles many other services so restarting would have undesirable effe=
cts.
For a moment clients would think there is no telephony at all: no SIM,
no cellular signal strength, no voice/emergency calls, no SIM ATK etc.

>> Deactivation of the context is obviously mandatory. The reasoning for pl=
acing
>> this into ofono is handling client requests consistently and avoiding ra=
ce
>> conditions. Using this approach ofono does not re-activate the context, =
that's
>> done by ConnMan or whatever connection manger the system uses.
>>
> I'm not so sure that this is a good idea.  A 'live' reset of the
> settings just seems wrong to me.  Why would you ever want to do that
> anyway?  If something is working, why bother resetting the settings?
Generally speaking I agree with the point of view. The main point was
not the 'live' part, but to allow running provisioning again, e.g. if
user has set wrong ones.
FYI a MMS context may be active using a correct APN but messages don't
flow due to a wrong proxy. In such a case context remains active for
some time.

> oFono supports arbitrary number of contexts, so your UI can always add
> more.  So if you need to re-provision, let your UI handle this.  The UI
> should be capable of reading the provisioning database anyway in order
> to handle duplicates, etc.
When ofono already implements the initial provisioning logic it is not
tempting to duplicate it but instead trigger it again.
(A more suitable name for the new method could be  "ProvisiongContext"
or similar.)
If reverting provisioned settings is done by creating a new empty
context, one would still want to run ofono provisioning for that
(ofono restart not an option).
>
> Regards,
> -Denis

Thanks for your feedback Denis, I appreciate it. All tips to make
changes more upstream-worthy, or if not then otherwise better, are
welcome.

Thanks
-- =

Tommi

--===============3459796643479305337==--

