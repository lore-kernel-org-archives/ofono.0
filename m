Content-Type: multipart/mixed; boundary="===============7352118880834739318=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Fri, 25 Feb 2011 11:07:06 -0600
Message-ID: <4D67E1BA.90109@gmail.com>
In-Reply-To: <1298639971.18254.15.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7352118880834739318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/25/2011 07:19 AM, Jussi Kangas wrote:
> Hi,
> =

> On Thu, 2011-02-24 at 22:17 +0200, Denis Kenzior wrote: =

> =

>> We have to check for the PUK2 case above since we might be in PUK2
>> required state already.  If we fail to unlock the PUK2, then
>>       pin_type =3D puk2pin(pin_type);
>> will never be executed.
>>
>> And I'm fine with your suggestion of blacklisting PIN2 from
> LockedPins,
>> but lets handle this separately.
> =

> Yes let's handle that as separate issue if at all. What I was trying to =

> say was that there was no situation in my testings where PUK2 would be =

> required in this part of code. If PUK2 is required pin_type is still
> PIN2 here. Situation you describe has to happen with other modems.
>

Looking at the code there might be possibilities when pin_type is in
fact PUK2.  The puk2pin code is executed only if pin_type does not match
sim->pin_type.  So if you're already in PUK2 state, and fail to unlock
again, you need to check against PUK2, not PIN2.

>> Again, my point here is that you have this code at the bottom of the
>> function:
>>
>>         if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
>>                 sim_initialize_after_pin(sim);
>>
>> If you want the SIM initialization to proceed then you need to add a
>> check for SIM PIN2/PUK2.
> =

> You are writing about adding PIN2 and PUK2 to this check? I rechecked =

> my AT command API specification and PIN2 and PUK2 cannot be required in
> startup. (Speculation about bug in my previous mail was wrong) And if
> PIN2 or PUK2 is required in other time there is no need for
> sim_initialization. You must be writing about situation where oFono is
> run workstation environment and restarted without booting the modem? Ok,
> I'll change that but I think I'll add a check to prevent sim
> initialization in sim state READY situation. =

> =

> What is your general opinion about making amends in oFono code to enable
> nice working in workstation? My previous hotswap patch does not work if
> you disable modem without restarting oFono. It lacks initialization of
> have_sim parameter in init_sim_reporting method. =

> =


We need to make every reasonable effort to make oFono work in these
cases.  We can't assume that the driver can reset the modem properly
when powering up.  And in fact most USB data sticks on the market do not
support modem resets short of pulling the hardware.  If the modem
firmware is buggy, then there's obviously nothing we can do.

Regards,
-Denis

--===============7352118880834739318==--

