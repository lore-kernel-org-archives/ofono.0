Content-Type: multipart/mixed; boundary="===============8123503112570312456=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Thu, 24 Feb 2011 14:17:46 -0600
Message-ID: <4D66BCEA.2090307@gmail.com>
In-Reply-To: <1298474674.26475.79.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8123503112570312456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/23/2011 09:24 AM, Jussi Kangas wrote:
> Hi,
> =

> On Wed, 2011-02-23 at 08:15 +0200, Denis Kenzior wrote:
>>>  =

>>> -	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
>>> -			sim->state =3D=3D OFONO_SIM_STATE_READY) {
>>> +	if ((pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
>>> +			sim->state =3D=3D OFONO_SIM_STATE_READY) &&
>>> +				(pin_type !=3D OFONO_SIM_PASSWORD_SIM_PIN2)) {
>>
>> I don't see how this can work.  You need to check for pin_type !=3D NONE,
>> PIN2 and PUK2 AND state =3D=3D READY here.  This also only covers the ca=
se
>> of the PIN2 or PUK2 being triggered when call-meter is active.  You do
>> not take care of the case where PIN2 or PUK2 are already required during
>> sim initialization.
> =

> Hmm. It seems to work here. If I try reset call meter with wrong
> password I get pin_type OFONO_SIM_PASSWORD_SIM_PIN2 and
> OFONO_SIM_STATE_READY. APIs stay up and SIM manager shows pin2 locked
> and pin2 required. (Which is kinda wrong I admit, u cannot unlock the
> pin2, pin2 should always be visible in LockedPins or not at all, I would
> prefer the later. However it is showed as it is showed and it was
> working that way already before this patch). If I run same case three
> times I get same values but API shows that puk2 is required and all
> API:s stay up. If I run the case with correct password it does not come
> to this code at all all. =


What I'm saying here is that it would be safer to do it like this:

switch (pin_type) {
case OFONO_SIM_PASSWORD_NONE:
case OFONO_SIM_PASSWORD_SIM_PIN2:
case OFONO_SIM_PASSWORD_SIM_PUK2:
	break;
default:
	if (sim->state =3D=3D OFONO_SIM_STATE_READY)
		...
}

We have to check for the PUK2 case above since we might be in PUK2
required state already.  If we fail to unlock the PUK2, then
	pin_type =3D puk2pin(pin_type);
will never be executed.

And I'm fine with your suggestion of blacklisting PIN2 from LockedPins,
but lets handle this separately.

> =

> PIN2 cannot be required in startup. It is only required if u do
> something with certain features like fdn or call meter. PUK2 can be
> blocked in startup all right but it does not matter from startup point
> of view. If I start the oFono with PIN2 blocked I get pin_type
> OFONO_SIM_PASSWORD_SIM_PIN2 and OFONO_SIM_STATE_INSERTED states and API
> shows pin2 locked and puk2 required as required. (does not seem work if
> I boot up the modem and not just oFono though. Looks like modem bug
> where it does not read voluntarily PIN2 state.)
> =


Again, my point here is that you have this code at the bottom of the
function:

        if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
                sim_initialize_after_pin(sim);

If you want the SIM initialization to proceed then you need to add a
check for SIM PIN2/PUK2.

Regards,
-Denis

--===============8123503112570312456==--

