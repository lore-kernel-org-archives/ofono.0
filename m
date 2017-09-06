Content-Type: multipart/mixed; boundary="===============8496431837793838649=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: report failure in case of invalid pin type
Date: Wed, 06 Sep 2017 10:35:27 -0500
Message-ID: <87588c10-871a-661a-4ecd-9974ad5e4631@gmail.com>
In-Reply-To: <7c7b8ac1-7d43-81a9-9634-e894815e0d9f@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8496431837793838649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 09/06/2017 03:31 AM, Christophe Ronco wrote:
> Hi Denis,
> =

> I wasn't able to reproduce yesterday.
>  From traces I kept, with problematic SIM card, I had this trace when =

> problem appeared:
> ../git/drivers/qmimodem/sim.c:get_card_status() info1->app_state:0x6: =

> OFONO_SIM_PASSWORD_INVALID
> =

> I had a look at QMI lib and app_state to 0x6 means =

> QMI_UIM_CARD_APPLICATION_STATE_ILLEGAL. Other unhandled states are :

This would probably mean that the SIM card is not inserted properly. =

One way to handle this would be to mark the SIM as not inserted...

>   - QMI_UIM_CARD_APPLICATION_STATE_UNKNOWN

No idea what we can do here, same as above?

>   - QMI_UIM_CARD_APPLICATION_STATE_DETECTED

Sounds like a transient state and we should retry

>   - QMI_UIM_CARD_APPLICATION_STATE_PIN1_BLOCKED

Doesn't this mean PUK1 entry is required?

> =

> With current driver code, all these states will lead to =

> OFONO_SIM_PASSWORD_INVALID. I don't know if a retry will help if we have =

> any of these states. It would be easy to make a retry for these states =

> as this is already implemented for =

> QMI_UIM_CARD_APPLICATION_STATE_CHECK_PERSONALIZATION_STATE state.

We do have a query_facility_lock sim atom driver method.  Perhaps this =

needs to be implemented for QMI?  If the driver doesn't handle this, =

then there's no sense in even trying devices which might be locked...

> =

> Do you want me to change the patch to implement that?
> =


Sure, patches are always welcome

> On my side, my concern is more: what "PinRequired" property (in =

> SimManager properties) should be if we fail to get PIN state (in QMI =

> driver or any other driver (with AT+CPIN? replying ERROR for example))? =

> I think that with current code it will be "none" and I would prefer =

> something like "unknown", "error" or "invalid" to distinguish a SIM with =

> entered or disabled PIN from a SIM where driver is not able to get PIN =

> state. What do you think?

AT modem drivers that use at_util_sim_state_query* set the SIM as =

inserted only if the CPIN query succeeds.  Otherwise the SIM is marked =

as not present and PinRequired property isn't even used.

> =

> Best Regards,
> =

> Christophe Ronco
> =


Regards,
-Denis

--===============8496431837793838649==--

