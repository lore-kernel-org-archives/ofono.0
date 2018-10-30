Content-Type: multipart/mixed; boundary="===============0205724933777275695=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 0/6] Driver registration rework
Date: Tue, 30 Oct 2018 14:07:15 +0100
Message-ID: <75f7b027-1d32-84ab-4e35-1e96f296316c@norrbonn.se>
In-Reply-To: <7299df44-c133-1021-82b0-1100eec25915@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0205724933777275695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29/10/2018 21:26, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 10/26/2018 04:54 AM, Jonas Bonn wrote:
>> Hi Denis,
>>
>> Since I don't know if you'd even be interested in a series like this,
>> here's a draft that touches just a few places to give you an idea of
>> where this would take us... take a look and let me know what you think.
>>
>> /Jonas
>>
>> ******
>>
>> ofono has historically had a system in place whereby modems are
>> encapsulated as 'plugins', the idea being that these could be loosely
>> coupled to the core and added/removed flexibly as requirements changed.
>> Theoretically, the plugin would register a set of new drivers (atoms)
>> with the core and then call ofono_modem_register(...) after having
>> configured the modem object appropriately (device node, etc).=C2=A0 In
>> practice, however, this does not work well and the modem plugins don't
>> really follow this model.
> =

> Yeah it is a bit of a historical weirdness.=C2=A0 We put the atom drivers =

> into drivers/* and the modem drivers went into plugins/ along with =

> actual plugins.=C2=A0 Maybe we should fix that...
> =

>>
>> - drivers (atoms) use a lot of core functionality and cannot be built
>> externally using only the exported ofono headers.=C2=A0 As such, the
>> drivers really need to be part of core ofono, irregardless of whether
>> they are packed into separate modules (plugins) or linked into one
>> monolithici mage
> =

> Sort of.=C2=A0 They're still drivers and can be removed at will from the =

> core.=C2=A0 The only thing that having them in tree helps with is access =
to =

> some private headers.=C2=A0 And even these are not really that numerous.
>

Essentially all the drivers send AT commands, QMI commands, etc. which =

involves using core code.  These drivers cannot be built externally from =

ofono.  Or am I misunderstanding what's being exported from ofono somehow?


>>
>> - ofono no longer provides the ability to built the plugins in the
>> source tree as external libs; they are all linked into one monolithic
>> image by default with no option to change this
> =

> You can in theory do this, but not for in-tree plugins/drivers.=C2=A0 Wha=
t =

> would be the point anyway?

Right.  I was just stating a fact... ;)

> =

>>
>> - the modem 'plugins' are 99% modem driver and 1% plugin; the plugin bit
>> just takes care of registering the modem driver with the core and does
>> nothing else
> =

> True.=C2=A0 As I said, the modem drivers should probably be in a separate =

> place.=C2=A0 I was never fully happy with how this got setup, but then th=
is =

> isn't that big of an issue in my mind.
> =

>>
>> - udevng takes care of setting up the modem objects and binding them
>> with their drivers
>>
>> This patch series tries to addres this in the following way:
>>
>> i) Add driver registration macros that lift registration with the core
>> into init() (constructor) functions; this allows the drivers to
>> automatically be registered at startup or on module load if they happen
>> be part of a plugin
> =

> Except this breaks our plugin whitelist / blacklist logic.=C2=A0 And also =

> makes it impossible to control the init / exit sequence which might be =

> useful to have.

The drivers are independent from each other, as things currently stand, =

so the init/exit sequence isn't important (as far as I can tell).  Were =

it to become important, that's manageable... for the attribute solution, =

the priority can be tweaked if ordering is necessary.

As for the blacklisting:  the plugins currently only register the =

drivers and do nothing else.  The cost of registering a driver is low so =

there's really no gain in blacklisting these plugins.  (Note that this =

concerns these 'modem driver' plugins only... there are some "real" =

plugins, too... mbpi, udev, etc. that belong in plugins/ and where =

blacklisting might make sense).

> =

> If you really want to do this, then maybe we need to use the 'section()' =

> magic for this.=C2=A0 Look into e.g. how iwd registers eap methods.

Yes, that was the next step.  I didn't want to rush there, though, given =

the (sometimes) conservative nature of the project. :)

> =

> Still a question of how we handle atom driver registration...

Not sure what you are saying here.  Are you referring to the section =

magic here?  If so, then the sections get mapped to symbols identifying =

the start and end of the driver array and this replaces the current =

g_driver_list mechanism currently in use.

> =

>>
>> ii)=C2=A0 Move the 'modem driver' part of the modem plugins into the dri=
vers/
>> directory.
> =

> I'm not sure drivers/ is really the right place.=C2=A0 At least it is wei=
rd =

> to me that gobi would live in drivers/qmimodem/.=C2=A0 Perhaps we need a =

> place for modem drivers only.

drivers/ feels right, though I agree drivers/qmimodem might not be quite =

right.  Point is, it's not a plugin so to at least get it out of plugins/.

Is it worth my continuing with this?

/Jonas

> =

>>
>> iii)=C2=A0 If the plugins are doing nothing other than registering the m=
odem
>> driver, drop it altogether.
>>
>> Jonas Bonn (6):
>> =C2=A0=C2=A0 include: add macros for declaring drivers
>> =C2=A0=C2=A0 qmimodem: simplify driver registration
>> =C2=A0=C2=A0 gobi: modem driver cannot be a plugin
>> =C2=A0=C2=A0 atmodem: add missing headers to atutil.h
>> =C2=A0=C2=A0 telitmodem: simplify driver registration
>> =C2=A0=C2=A0 telitmodem: modem driver is not a plugin
>>
>> =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++----
>> =C2=A0 drivers/atmodem/atutil.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>> =C2=A0 {plugins =3D> drivers/qmimodem}/gobi.c=C2=A0=C2=A0=C2=A0 | 13 +--=
----
>> =C2=A0 drivers/qmimodem/gprs-context.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 10 +----
>> =C2=A0 drivers/qmimodem/location-reporting.c=C2=A0=C2=A0 | 10 +----
>> =C2=A0 drivers/qmimodem/qmimodem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 --
>> =C2=A0 drivers/qmimodem/qmimodem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ---
>> =C2=A0 drivers/telitmodem/gprs-context-ncm.c=C2=A0=C2=A0 | 15 +-------
>> =C2=A0 drivers/telitmodem/location-reporting.c | 16 ++------
>> =C2=A0 {plugins =3D> drivers/telitmodem}/telit.c | 15 +-------
>> =C2=A0 drivers/telitmodem/telitmodem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 51 -------------------------
>> =C2=A0 drivers/telitmodem/telitmodem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 27 -------------
>> =C2=A0 include/gprs-context.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++
>> =C2=A0 include/location-reporting.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++
>> =C2=A0 include/modem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++
>> =C2=A0 15 files changed, 47 insertions(+), 167 deletions(-)
>> =C2=A0 rename {plugins =3D> drivers/qmimodem}/gobi.c (97%)
>> =C2=A0 rename {plugins =3D> drivers/telitmodem}/telit.c (97%)
>> =C2=A0 delete mode 100644 drivers/telitmodem/telitmodem.c
>> =C2=A0 delete mode 100644 drivers/telitmodem/telitmodem.h
>>
> =

> Regards,
> -Denis

--===============0205724933777275695==--

