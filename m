Content-Type: multipart/mixed; boundary="===============4338129826312871746=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check if lock is locked after code changing attempt
Date: Thu, 13 Jan 2011 10:28:08 -0600
Message-ID: <4D2F2818.3060006@gmail.com>
In-Reply-To: <20A4FB08D632914F9C09B9F05CBDF258192DAA2580@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4338129826312871746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>>
>> First, please fix your authorship information.  See the AUTHORS file =

>> to see what we expect.  Also, please make sure that you're using tabs =

>> for indentation and following the relevant coding style.  See the =

>> Submitting Patches section in the HACKING document in oFono git as =

>> well as doc/coding-style.txt.
> =

> I think whole this chapter should be translated as "Do not use Outlook".
> I asked around little bit and best guess seems to be that you are using s=
omething that takes authorship information from mail address. Also since th=
e patch passes the checkpatch here with no problems whatsoever I guess Outl=
ook ruined the patch. Fine, I'll try Evolution next. If possible, I would l=
ike to avoid using the git send-email. I prefer tools with GUI. =


git-send-email is the only sane approach.  Save yourself some time and
just use it.  Or find a GUI tool to do it for you.

> =

>>
>>> diff --git a/src/sim.c b/src/sim.c
>>> index d627647..789ddde 100644
>>> --- a/src/sim.c
>>> +++ b/src/sim.c
>>> @@ -712,8 +712,60 @@ static DBusMessage =

>>> *sim_unlock_pin(DBusConnection *conn, DBusMessage *msg,  static void =

>>> sim_change_pin_cb(const struct ofono_error *error, void *data)  {
>>
>> So my first concern is that whatever you do here also has to work for =

>> LockPin and UnlockPin.
> =

> I'm not after total solution here. I would like to implement this so that=
 first the ChangePin starts working, i.e fullfill the existing TODO task fi=
rst. Reasoning here is that I thought it would be easier to get the fixes i=
n if I keep them small. If u mean that stuff inside (error->error =3D 12) c=
ondition should be as separate function to be usable for LockPin and Unlock=
Pin, I agree. I was just thinking that separation could be done when fix is=
 extended to LockPin and UnlockPin. =

> =


Whatever you do here applies to LockPin and UnlockPin, so you might as
well handle them too.

>> Have you considered querying the PIN state on a failure instead?  If =

>> the lock/unlock/change pin operation fails, then re-query the current PI=
N.
>> If the CPIN is no longer returning READY and we're in a state =

>> OFONO_SIM_STATE_READY, then tear us back down to an earlier state.
> =

> Yes, I have. As I answered to Lucas already at least with the modem I'm u=
sing the return value I get seems to be trustable and there is no point to =
go querying the information I already know. Also there could be other reaso=
ns why sim state is not ready ( small chance of course ) so to satisfy my p=
edant nature I would have to either check the return value anyways or use s=
ome other means to get the reason why the sim is not ready in order to be 1=
00 % sure that PUK is required. At least Lucas seemed to favor query approa=
ch. I guess that has to mean that return value is not trustable with all mo=
dems. I can change this if required. =

> =

>>

In general you cannot trust the return value.  Most modems simply get
this wrong.  On a well setup modem driver you do not need to worry about
sim readiness conditions.  The driver should take care of that.  If the
modem firmware is buggy, well there's no strategy that will save you anyway.

So I'd prefer if we try out the query approach first.

Regards,
-Denis

--===============4338129826312871746==--

