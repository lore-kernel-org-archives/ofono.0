Content-Type: multipart/mixed; boundary="===============4173610134806961682=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: Re: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Tue, 02 Feb 2010 09:17:42 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E079032A1FC4@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4173610134806961682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.

Sorry if you get this mail twice, something went wrong when posting this la=
st time so
I'm resending it.

We have done some testing with the STE modem for call termination, and this=
 is the result:

TC |Call #1 | Call #2 | Call #3  | Command   | Result
---|--------------------------------------------------------------------
1  |ACTIVE  | ACTIVE  | ..       | ATH         | call 1, 2 terminated	=

2  |ACTIVE  | ACTIVE  | ..       | AT+CHUP     | call 1, 2 terminated	=

3  |ACTIVE  | ACTIVE  | HELD     | ATH         | call 1, 2 terminated	=

4  |ACTIVE  | ACTIVE  | HELD     | AT+CHUP     | call 1, 2 terminated
5  |ACTIVE  | ACTIVE  | HELD     | AT+CHLD=3D0;H | call 1, 2 and 3 terminat=
ed
6  |ACTIVE  | ACTIVE  | WAITING  | ATH         | call 1, 2 terminated
7  |ACTIVE  | ACTIVE  | WAITING  | AT+CHUP     | call 1, 2 terminated
8  |ACTIVE  | HELD    | WAITING  | CHLD=3D0      | call 3 terminated, =

9  |ACTIVE  | HELD    | WAITING  | ATH         | call 1 terminated
10 |ACTIVE  | HELD    | WAITING  | AT+CHUP     | call 1 terminated
11 |HELD    | HELD    | ACTIVE   | AT+CHLD=3D0   | call 1, 2 terminated
12 |HELD    | HELD    | ACTIVE   | AT+CHLD=3D0;H | call 1, 2 and 3 terminat=
ed
13 |HELD    | DIALING | ..       | ATH         | call 2 (MO) terminated
14 |HELD    | DIALING | ..       | CHUP        | call 2 (MO) terminated
15 |HELD    | DIALING | ..       | AT+CHLD=3D12  | call 2 (MO) NOT terminat=
ed
16 |HELD    | WAITING | ..       | AT+CHLD=3D0   | call 2 terminated
17 |HELD    | ..      | ..       | ATH         | call 1 NOT terminated	=



Denis Kenzior wrote:
>>> oFono already takes care of this for single calls (see =

>>> src/voicecall.c voicecall_hangup.)  So this is only an issue in the =

>>> case of three way calls, is this what you're referring to here?
>> =

>> Kind of. This is very good, it takes care of the situation with =

>> emergency  call which cannot be terminated with CHLD commands.
>> =

>> But I think there are more issues. If I am not mistaken STE-modems =

>> have the following behavior:
>> CHLD=3D1X can only terminate call in state ACTIVE or HELD. (I think =

>> this is as STE interprets the standards).
> =

> The standards specify that CHLD=3D1X can only terminate an ACTIVE call.
> Most modems implement it this way.  There are vendor extensions that =

> provide this functionality (e.g. CHLD=3D7X on TI.)  By default oFono =

> assumes that release_specific will simply fail if a user attempts to
> use it on an e.g. HELD call with no modem support.    =


For the STE modem, AT+CHLD=3D1x terminates calls in state ACTIVE and HELD.

>> =

>> a) If you are in a active call and receives a new incoming call
>> (ALERTING) and want to reject the new ALERTING call, then STE modem =

>> cannot terminate this call with CHLD=3D1X. It has to be terminated with =

>> CHLD=3D0 (cause=3DBUSY) or ATH (possible CHUP).
> =

> Ok, lets get the terminology clear here.  In this case the incoming =

> call is not ALERTING, it is WAITING.  WAITING calls are always =

> rejected by using CHLD=3D0.  ALERTING calls are always outgoing calls
> that transitioned from DIALING to alerting the user.   =

> =

>> =

>> b) Or you may have the following situation. One call on HOLD, another =

>> ACTIVE call, and then you receive a new incoming call ALERTING. If =

>> you try to terminate the new incoming (ALERTING) call with CHLD=3D0, I =

>> think you as a side effect will terminate the call on hold as well.
>> If I am not mistaken ATH (possible CHUP) would be the correct in this =

>> situation for STE modems
> =

> The standards are quite clear here, the WAITING call always takes =

> precedence and thus only the WAITING call is affected. Can you check =

> that STE modems do indeed get this wrong?  If the modem is standards =

> compliant, oFono does the right thing here.

STE is standard compliant, only the WAITING call is terminated with AT+CHLD=
=3D0. (TC 8)
 =

>> =

>> c) If you have an call on hold and initiate a new call, but want to =

>> terminate the newly initiated call (DIALING), then this call cannot =

>> be terminated with CHLD=3D1X, but you would have to use ATH (or =

>> possible CHUP).
> =

> Yes, so this is the case that we do need to take care of in the core.
> Most
> modems let us get away with sending release_specific up to this point.
> =


For the STE modem, calls in state DIALING and ALERTING will have to be =

terminated with ATH or AT+CHUP, AT+CHLD=3D1x does not work.
This means that the current implementation, using release_specific =

(and thus AT+CHLD=3D1x) will not work. =


>>> What I have been considering to take care of this case is to add
>>> end_all and end_all_active callbacks.  According to 27.007/22.030
>>> ATH should end all calls (active + held) except waiting calls, while
>>> +CHUP should only end the currently active call.  At least on one TI
>>> modem I tried this works as expected.  Do your modems implement the
>>> same behavior?
>> =

>> No, I don't think so. I think ATH will only terminate one call.
>> In order to terminate all calls you would probably need to do
>> something like: AT+CHLD=3D0;H But I'm not sure this works in all
>> possible scenarios either...
> =

> Can you check the behavior of ATH vs CHUP on STE modems?  We need to
> send the =

> right one here or both HELD and ACTIVE/DIALING/ALERTING will be
> terminated. =

> If using CHUP and ATH doesn't work out we'll have to come up with
> another =

> solution.

For the STE modem, ATH will only terminate the active call, =

not the held call. (TC 9). For more information about ATH and AT+CHUP,
please see the table above.

BR/Sjur

--===============4173610134806961682==--

