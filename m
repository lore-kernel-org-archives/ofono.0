Content-Type: multipart/mixed; boundary="===============6672345978258789203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/gprs: added LTE and NR indicators
Date: Fri, 28 Sep 2018 09:00:58 -0500
Message-ID: <c8f258f7-321a-f66b-0223-6ef8aeb024f9@gmail.com>
In-Reply-To: <CAKSBH7HJ0XghPAVzMxhFoarg03xo6CWde-GzSW7=TjnaKzFyhA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6672345978258789203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> Err, why?  We should get a proper status from +CREG.  And the
>> network-registration state overrides whatever status the gprs atom
>> thinks it is in.
> =

> yes and no. In case of handover things get messy today.
> I will try to collect a log to show this.
> =


Great, that would be useful.

>>
>> Also, the driver is the wrong place for all this logic anyway.  CEREG
>> and C5REG status reporting is standardized, so we can easily add this to
>> the oFono core (gprs) API.  E.g. ofono_gprs_status_notify was for 2G/3G
>> PS domain registration state reporting (CGREG).  We should now introduce
>> ofono_gprs_eutran_status_notify for reporting CEREG status and
>> ofono_gprs_5g_status_notify for C5REG.  The core then can collate this
>> information and act accordingly.  Having each driver doing all this
>> logic is wasteful and error prone.
> =

> this is specific to AT-based modem. qmi and mbim do not suffer from this.
> I don't know about dun, ril, isi drivers (the other ones that
> implement a gprs atom)
> So, in my opinion is related to the 27.007, and stays in the driver.
> =


So just as a bit of background, oFono follows 27.007 to the letter when =

possible.  If you look at the way atom driver APIs are defined, they map =

1:1 to 27.007.  We only introduce enums and operations that are not =

present in 27.007 for very specific circumstances.

In the end QMI was also very similar to 27.007.  I don't know if they =

have kept up with some of the latest features introduced by 3GPP, but =

all these status reporting operations can remain optional.  If QMI/MBIM =

can emulate them, that's great.  If not, things should still work.

Also note that gprs driver might not be shared across all AT command =

based modems in the future.  E.g. you may want to have your own version =

for gemalto if the vendor specific logic gets too invasive.  In which =

case you'd need to duplicate all this logic...  No, it really does =

belong in the core.

>>> If COPS does not report a technology or reports the same technology,
>>> we take the indicator.
>>
>> This sounds unnecessary to me...
> =

> the problem here is that when there are different indicators for 2G/3G an=
d LTE,
> in case of change of technology one of them reports a deregistration
> (from the previous technology), and promptly ofono sends AT+CGATT=3D0.
> =


Unsurprising.  This is a common issue with AT commands.  The issue is =

that AT command order matters.  So if the modem sends them in a sequence =

that isn't useful to the upper layers, things become hard.  Each command =

is processed individually without actual context as to what is going on =

elsewhere.  This is why I'm actually against using C5REG/EREG except for =

informational purposes only.  The definitive information needs to come =

from CREG.

>>
>>>
>>> Similar handling for AT+CGREG?, AT+CEREG?, AT+C5GREG? : we take the
>>> best result.
>>>
>>> An initial verification for the presence of any of these indicators is
>>> required. Also how many of them are available is needed information.
>>
>> So the real question is, why do you think you need all this anyway?  The
>> GPRS registration status is only important for one case, and that is
>> control of packet domain registration while roaming on 2G/3G networks.
>> On EUTRAN networks that is not possible anyway, so we're essentially
>> always Powered & Attached regardless of the RoamingAllowed setting.
>>
> =

> maybe this is the issue: roaming should be handled at context-activation =
stage,
> not with the attach.
> All hand-over cases don't work well with ofono.
> Even a simple registration in 3G first then upgraded to LTE by the
> network will not work because
> the module would send +CGREG=3D4 and ofono AT+CGATT=3D0, and detach from =
LTE,
> back to 3G, perform another attach and repeat forever...

Yep, I agree, the logic is overly aggressive.  The reason is that =

there's no 27.007 standard for disabling automatic PS attach while =

roaming.  So in order to implement RoamingAllowed we had to issue the =

big CGATT=3D0 hammer to stop the modem from attaching until we told it to =

do so.

Do we have any vendor specific commands that we can use to send a hint =

to the modem not to auto-attach while roaming?  Then gprs can stop being =

so paranoid.  Another option would be to only detach once we're roaming =

and attached...

> =

> LTE modules are supposed to react to AT+CGATT=3Dx, just like any pre-LTE =
ones.
> I haven't seen anywhere in the 27.007 that CGATT doesn't apply there.
> =


Agreed, that is my interpretation of what 27.007 says as well.  However, =

I think 3GPP messed this up...

> I understand from your comments that the aim of ofono is to handle
> first the registration with CREG,
> then the attach.
> I see if it is possible to come with some clean scenarios for this in
> case of multiple technologies,
> but I fear not without this kind of code.
> Note that it will be the same for LTE->NR as it is now for 2G/3G->LTE.

Lets fix the LTE cases first and then we worry about NR :)

Regards,
-Denis

--===============6672345978258789203==--

