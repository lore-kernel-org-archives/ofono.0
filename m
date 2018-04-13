Content-Type: multipart/mixed; boundary="===============3445810182890692416=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] qmimodem: report failure in case of invalid pin type
Date: Fri, 13 Apr 2018 15:55:27 +0200
Message-ID: <b661d335-c59e-73a4-f6d5-640f8f9c2a5e@kerlink.fr>
In-Reply-To: <87588c10-871a-661a-4ecd-9974ad5e4631@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3445810182890692416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

I didn't work on that because I wasn't able to reproduce anymore (and I =

am still not able to reproduce on my desk).
But I also receive logs from gateways on field when some problems are =

discovered.
So I am able to say that this problem has been reported on some modems =

(let's say 1 out of 1000). Even on these modems, this happens only from =

time to time.
On Ofono version deployed on field, I still have the first version of =

patch sent in this thread (adding a string corresponding to =

OFONO_SIM_PASSWORD_INVALID). So, hopefully, I don't have a crash of =

Ofono when problem happens and other modem (there are 2 modems on each =

deployed gateway) can work normally.

I am pretty sure that the root cause is an hardware problem in the SIM =

connector. I say that because I have other boards where SIM detection =

sometimes fails and this always comes from a SIM connector soldering =

problem. Our SIM connector is definitely not bullet proof.

I have no debug on these boards, so I can't say what is the precise =

answer to QMI_UIM_GET_CARD_STATUS command.
My point is that this problem do not exist only with an exotic SIM on my =

desk and Ofono should not crash when it occurs.

On 09/06/2017 05:35 PM, Denis Kenzior wrote:
> Hi Christophe,
>
> On 09/06/2017 03:31 AM, Christophe Ronco wrote:
>> Hi Denis,
>>
>> I wasn't able to reproduce yesterday.
>> =C2=A0From traces I kept, with problematic SIM card, I had this trace wh=
en =

>> problem appeared:
>> ../git/drivers/qmimodem/sim.c:get_card_status() info1->app_state:0x6: =

>> OFONO_SIM_PASSWORD_INVALID
>>
>> I had a look at QMI lib and app_state to 0x6 means =

>> QMI_UIM_CARD_APPLICATION_STATE_ILLEGAL. Other unhandled states are :
>
> This would probably mean that the SIM card is not inserted properly. =

> One way to handle this would be to mark the SIM as not inserted...
We just said during driver probe that SIM was inserted. We could say =

that finally it is not.
>
>> =C2=A0 - QMI_UIM_CARD_APPLICATION_STATE_UNKNOWN
>
> No idea what we can do here, same as above?
>
>> =C2=A0 - QMI_UIM_CARD_APPLICATION_STATE_DETECTED
>
> Sounds like a transient state and we should retry
>
>> =C2=A0 - QMI_UIM_CARD_APPLICATION_STATE_PIN1_BLOCKED
>
> Doesn't this mean PUK1 entry is required?
I assume answer is no. There is another state to say that: =

QMI_UIM_CARD_APPLICATION_STATE_PUK1_OR_UPIN_PUK_REQUIRED
>
>>
>> With current driver code, all these states will lead to =

>> OFONO_SIM_PASSWORD_INVALID. I don't know if a retry will help if we =

>> have any of these states. It would be easy to make a retry for these =

>> states as this is already implemented for =

>> QMI_UIM_CARD_APPLICATION_STATE_CHECK_PERSONALIZATION_STATE state.
>
> We do have a query_facility_lock sim atom driver method.=C2=A0 Perhaps th=
is =

> needs to be implemented for QMI?=C2=A0 If the driver doesn't handle this, =

> then there's no sense in even trying devices which might be locked...
>
>>
>> Do you want me to change the patch to implement that?
>>
>
> Sure, patches are always welcome
>
>> On my side, my concern is more: what "PinRequired" property (in =

>> SimManager properties) should be if we fail to get PIN state (in QMI =

>> driver or any other driver (with AT+CPIN? replying ERROR for =

>> example))? I think that with current code it will be "none" and I =

>> would prefer something like "unknown", "error" or "invalid" to =

>> distinguish a SIM with entered or disabled PIN from a SIM where =

>> driver is not able to get PIN state. What do you think?
>
> AT modem drivers that use at_util_sim_state_query* set the SIM as =

> inserted only if the CPIN query succeeds.=C2=A0 Otherwise the SIM is mark=
ed =

> as not present and PinRequired property isn't even used.
I had a look at two cases (I just read code, I didn't try anything so I =

might be wrong...):
1) Telit: SIM insertion detected in plugin through #QSS notifications.
2) Huawei: SIM insertion detected in plugin with answer to AT^SYSINFO AT =

command.
If we have a AT+CPIN that fails with a SIM detected, I think (once =

again, that's just code reading, I have not tried) SIM will be marked =

present and PinRequired will be "none".
But maybe, in real life, it never happens to have #QSS or AT^SYSINFO =

saying that SIM is inserted and AT+CPIN returning ERROR.

I will send patches to :
1) implement a retry for all PIN states described above and report =

failure when retries fail
2) say that SIM is not inserted when we fail to retrieve PIN status

Best Regards,

Christophe Ronco


--===============3445810182890692416==--

