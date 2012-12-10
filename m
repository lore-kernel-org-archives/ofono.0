Content-Type: multipart/mixed; boundary="===============1957562066650105698=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Mon, 10 Dec 2012 11:52:15 +0100
Message-ID: <50C5BEDF.8040709@hale.at>
In-Reply-To: <50C1F5E8.2030803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1957562066650105698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas & Denis,

On 07/12/12 14:58, Denis Kenzior wrote:
> Hi Jonas,
>
> On 12/07/2012 12:22 AM, Jonas Bonn wrote:
>> Hi Denis,
>>
>> On Tue, 2012-12-04 at 23:55 -0600, Denis Kenzior wrote:
>>> Hi Jonas,
>>>
>>> On 12/04/2012 09:46 AM, Jonas Bonn wrote:
>>>> In offline state where CFUN=3D4, the Telit HE910 also powers down the =

>>>> SIM
>>>> card so AT commands that query the SIM will fail.  These failures =

>>>> result
>>>> in ofono not getting to POST_SIM state where it will export the GPRS
>>>> feature.

I suppose the failing of AT+CMER results in the missing of the GPRS atom.
AT+CMER fails because of the SIM being busy and in consequence the =

network registration atom is removed - see Ming Li Wu's problem (Telit =

HE910: CMER command problem).

I also tried the HE910 and had the same problem. In case a PIN is =

required, the following solves the problem:

In /drivers/atmodem/sim.c, at_qss_notify()
case 2:    /* PIN unlocked */
has to be changed to
case 3:    /* SIM INSERTED and READY */


After the PIN was entered, we wait until the modem states that the SIM =

is ready, i.e. #QSS: 3.


I haven't found a proper way to do this in case there is no PIN required.
We should only get to "post sim state" if we received #QSS: 3


>>
>>>
>>> Does the HE910 have a proper CFUN mode where it does not turn off the
>>> SIM?  You are making some nasty hacks because of it, and the other =

>>> Telit
>>> devices support this just fine.
>>
>> No, the HE910 supports CFUN modes 0,1,4,5,7 where:
>> 1: online
>> 4: offline (airplane) mode with SIM powered off
>> 0,5,7: online w/ power saving modes; SMS and phone calls are active in
>> these modes, but AT command handling seems to be turned off
>>
>> See Telit Modules Software User Guide, 1vv0300784 rev 11, 2012-09-20,
>> section 3.6 (page 105) for a description of these modes.
>>
>
> I read the description of CFUN in that document and got lost rather =

> quickly.  The bottom line is that oFono does not use any serial =

> signaling, so all of these DTR and RTS conditions do not apply.  If =

> the Telit modems do not support radio off with SIM on, then you need =

> to structure the driver differently, most likely removing the 'online' =

> method implementation would do what you want, and use only =

> enable/disable.  In theory that should work putting the modem online =

> as soon as the sim is in the ready state.
>
> Better yet, ask Telit to fix their firmware and document what the =

> <rst> parameter to CFUN actually means.

Is it really unusual for a modem to deactivate the SIM in flight mode? I =

had a look at some mobile phones and they seem to deactivate the SIM in =

flight mode.


Regards,
Christopher

--
Scanned by MailScanner.


--===============1957562066650105698==--

