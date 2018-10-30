Content-Type: multipart/mixed; boundary="===============2061543209477605632=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/6] Driver registration rework
Date: Tue, 30 Oct 2018 09:42:17 -0500
Message-ID: <4174d628-cd62-dd5d-d147-8ba5e1f2167b@gmail.com>
In-Reply-To: <75f7b027-1d32-84ab-4e35-1e96f296316c@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2061543209477605632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Sort of.=C2=A0 They're still drivers and can be removed at will from the =

>> core.=C2=A0 The only thing that having them in tree helps with is access=
 to =

>> some private headers.=C2=A0 And even these are not really that numerous.
>>
> =

> Essentially all the drivers send AT commands, QMI commands, etc. which =

> involves using core code.=C2=A0 These drivers cannot be built externally =
from =

> ofono.=C2=A0 Or am I misunderstanding what's being exported from ofono so=
mehow?
> =


I'm not sure I'm understanding you correctly.  So from my Point of View =

(POV):

- Core is the core.  You can't take anything away from it.  The driver =

can be removed at configure time or even run time and nobody would know =

or care if their hardware was not reliant on that driver.
- There is no fundamental difference between an out-of-tree driver and a =

builtin.  There really isn't.  There are some conveniences that the =

builtin drivers enjoy, but these are easily replaced if you live out of =

tree.  So if you really cared, yes you could take the qmi driver and =

build it out of tree no problem.  They're builtins for ease of maintenance.
- Drivers are not actually using any core code.  They use GAtChat, QMI, =

MBIM, etc.  But I don't consider that core code, its just helpers.

So to sum it up: I still don't know what you're saying above, but there =

is a clear demarcation line between what is core code and what is a =

driver.

>>> i) Add driver registration macros that lift registration with the core
>>> into init() (constructor) functions; this allows the drivers to
>>> automatically be registered at startup or on module load if they happen
>>> be part of a plugin
>>
>> Except this breaks our plugin whitelist / blacklist logic.=C2=A0 And als=
o =

>> makes it impossible to control the init / exit sequence which might be =

>> useful to have.
> =

> The drivers are independent from each other, as things currently stand, =

> so the init/exit sequence isn't important (as far as I can tell).=C2=A0 W=
ere =

> it to become important, that's manageable... for the attribute solution, =

> the priority can be tweaked if ordering is necessary.

Well it does allow you to turn off the atmodem and all related drivers =

completely for example.  Whether that is useful for atom drivers is =

somewhat arguable.  I don't remember using this capability, so if no one =

else objects I'm fine with converting atom drivers into a new world =

order.  But then this only buys you about 7-8 lines of savings per atom =

driver, so not really a big deal.

> =

> As for the blacklisting:=C2=A0 the plugins currently only register the =

> drivers and do nothing else.=C2=A0 The cost of registering a driver is lo=
w so =

> there's really no gain in blacklisting these plugins.=C2=A0 (Note that th=
is =

> concerns these 'modem driver' plugins only... there are some "real" =

> plugins, too... mbpi, udev, etc. that belong in plugins/ and where =

> blacklisting might make sense).

This is where I disagree.  We blacklist / whitelist individual modem =

drivers all the time for debug purposes.  So at the very least you need =

to preserve that ability.  The section() magic I mentioned earlier would =

allow you to do that.

> =

>>
>> If you really want to do this, then maybe we need to use the =

>> 'section()' magic for this.=C2=A0 Look into e.g. how iwd registers eap =

>> methods.
> =

> Yes, that was the next step.=C2=A0 I didn't want to rush there, though, g=
iven =

> the (sometimes) conservative nature of the project. :)
> =


So I'm okay with the general idea, I might object to some implementation =

details though.

>>
>> Still a question of how we handle atom driver registration...
> =

> Not sure what you are saying here.=C2=A0 Are you referring to the section =

> magic here?=C2=A0 If so, then the sections get mapped to symbols identify=
ing =

> the start and end of the driver array and this replaces the current =

> g_driver_list mechanism currently in use.
> =


No, I meant that one could blacklist the atmodem plugin for example and =

effectively disable all atmodem atom drivers.  So this ability would be =

lost with this approach.  But as stated above, I'm okay losing that if =

nobody else complains.

>>
>>>
>>> ii)=C2=A0 Move the 'modem driver' part of the modem plugins into the dr=
ivers/
>>> directory.
>>
>> I'm not sure drivers/ is really the right place.=C2=A0 At least it is we=
ird =

>> to me that gobi would live in drivers/qmimodem/.=C2=A0 Perhaps we need a =

>> place for modem drivers only.
> =

> drivers/ feels right, though I agree drivers/qmimodem might not be quite =

> right.=C2=A0 Point is, it's not a plugin so to at least get it out of plu=
gins/.
> =

> Is it worth my continuing with this?
> =


I would say yes.

Regards,
-Denis

--===============2061543209477605632==--

