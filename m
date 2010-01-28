Content-Type: multipart/mixed; boundary="===============3638921510177388922=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: RE: FW: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Thu, 28 Jan 2010 21:19:08 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E0790326B620@eseldmw101.eemea.ericsson.se>
In-Reply-To: <201001281025.35704.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3638921510177388922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:
Denis Kenzior wrote:
> Hi Sjur,
> =

>>> All of this logic needs to go away.  The core already handles all of
>>> this, including selection of ATH/CHLD, waiting/held.  Please review
>>> src/voicecall.c. If the core logic is not sufficient or does not
>>> properly handle a certain case, then lets see if we can fix the
>>> core first.  Drivers should not concern themselves with this stuff.
>> =

>> OK, we can remove the state logic, but STE modem cannot terminate
>> calls in state DIALING and ALERTING with CHLD=3D1X. We need to use ATH
>> (or AT+CHUP) instead.
> =

> oFono already takes care of this for single calls (see src/voicecall.c
> voicecall_hangup.)  So this is only an issue in the case of three way
> calls, is this what you're referring to here? =

Kind of. This is very good, it takes care of the situation with emergency c=
all
which cannot be terminated with CHLD commands.

But I think there are more issues. If I am not mistaken STE-modems have =

the following behavior:
CHLD=3D1X can only terminate call in state ACTIVE or HELD. (I think =

this is as STE interprets the standards).

a) If you are in a active call and receives a new incoming call (ALERTING)
and want to reject the new ALERTING call, then STE modem cannot =

terminate this call with CHLD=3D1X. It has to be terminated with CHLD=3D0 =

(cause=3DBUSY) or ATH (possible CHUP). =


b) Or you may have the following situation. One call on HOLD,
another ACTIVE call, and then you receive a new incoming call ALERTING.
If you try to terminate the new incoming (ALERTING) call with CHLD=3D0,
I think you as a side effect will terminate the call on hold as well.
If I am not mistaken ATH (possible CHUP) would be the correct in this
situation for STE modems

c) If you have an call on hold and initiate a new call, but want to
terminate the newly initiated call (DIALING), then this call cannot be =

terminated with CHLD=3D1X, but you would have to use ATH (or possible CHUP)=
. =


>> For now I think we will remove the state logic from
>> ste_release_specific as you suggest. Terminating calls in state
>> DIALING and ALERTING must then be handled by the Core part. The
>> simplest would probably be to use hangup in this case, but I suspect
>> hangup work differently for different modems. So if you cannot use
>> hangup as the general approach, maybe it could be =

>> implemented by adding callback functions release_dialing and
>> release_alerting in struct ofono_voicecall_driver. The STE driver
>> could  send ATH from release_dialing and release_alerting, other
>> drivers could  leave them empty and this could default to use
>> release_specific instead? =

What I referred to here was the solution to the situations described above
in a,b,c. =


> =

> What I have been considering to take care of this case is to add
> end_all and end_all_active callbacks.  According to 27.007/22.030 ATH
> should end all calls (active + held) except waiting calls, while
> +CHUP should only end the currently active call.  At least on one TI
> modem I tried this works as expected.  Do your modems implement the
> same behavior?     =


No, I don't think so. I think ATH will only terminate one call.
In order to terminate all calls you would probably need to do something
like: AT+CHLD=3D0;H But I'm not sure this works in all possible scenarios =

either...

> If so then we can always use end_all_active for
> dialing/incoming/alerting cases. =

> =

>> =

>>> With this in mind, you might not need to track any state in this
>>> driver at all.  See drivers/calypsomodem/voicecall.c for details.
>>> TI's CPI notifications are almost exactly the same as the STE ECAV.
>> =

>> The STE ECAV update is giving delta updates on the state information,
>> right now I don't see how we can get the ofono_voicall_notify right
>> without keeping some state information in ecav_notify.
>> =

> =

> Yes you're right, I was assuming ECAV gives you more information on
> whether the call was released locally or remotely. =

> =

> Regards,
> -Denis

Finally I'm not in office so I have taken this from top of my head so
I might have got something wrong here.

BR/Sjur

--===============3638921510177388922==--

