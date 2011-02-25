Content-Type: multipart/mixed; boundary="===============3661752265376484774=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Fri, 25 Feb 2011 15:19:31 +0200
Message-ID: <1298639971.18254.15.camel@jussi-desktop>
In-Reply-To: <4D66BCEA.2090307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3661752265376484774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2011-02-24 at 22:17 +0200, Denis Kenzior wrote: =


> We have to check for the PUK2 case above since we might be in PUK2
> required state already.  If we fail to unlock the PUK2, then
>       pin_type =3D puk2pin(pin_type);
> will never be executed.
> =

> And I'm fine with your suggestion of blacklisting PIN2 from
LockedPins,
> but lets handle this separately.

Yes let's handle that as separate issue if at all. What I was trying to =

say was that there was no situation in my testings where PUK2 would be =

required in this part of code. If PUK2 is required pin_type is still
PIN2 here. Situation you describe has to happen with other modems.

> Again, my point here is that you have this code at the bottom of the
> function:
> =

>         if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
>                 sim_initialize_after_pin(sim);
> =

> If you want the SIM initialization to proceed then you need to add a
> check for SIM PIN2/PUK2.

You are writing about adding PIN2 and PUK2 to this check? I rechecked =

my AT command API specification and PIN2 and PUK2 cannot be required in
startup. (Speculation about bug in my previous mail was wrong) And if
PIN2 or PUK2 is required in other time there is no need for
sim_initialization. You must be writing about situation where oFono is
run workstation environment and restarted without booting the modem? Ok,
I'll change that but I think I'll add a check to prevent sim
initialization in sim state READY situation. =


What is your general opinion about making amends in oFono code to enable
nice working in workstation? My previous hotswap patch does not work if
you disable modem without restarting oFono. It lacks initialization of
have_sim parameter in init_sim_reporting method. =


Br,
-Jussi


--===============3661752265376484774==--

