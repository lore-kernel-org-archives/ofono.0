Content-Type: multipart/mixed; boundary="===============4872698339155927895=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/6] emulator: Add ofono_emulator framework
Date: Wed, 14 Jul 2010 09:10:53 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F7EE603@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C3CA8BE.4010403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4872698339155927895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> +#define OFONO_EMULATOR_INTERFACE "org.ofono.Emulator"
> =

> So my suggestion is to keep it simple and not include the D-Bus
> interface for the emulator at all for now.

That's fine. Will remove them.

>> +
>> +#include <ofono/types.h>
>> +
>> +struct ofono_emulator;
>> +
>> +enum ofono_emulator_type {
>> +	OFONO_EMULATOR_TYPE_NONE,
> =

> Type NONE seems to be useless :)
> =

>> +	OFONO_EMULATOR_TYPE_DUN,
>> +};
>> +
>> +struct ofono_emulator_driver {
>> +	const char *name;
>> +	enum ofono_emulator_type type;
>> +	int (*probe)(struct ofono_emulator *e);
>> +	void (*remove)(struct ofono_emulator *e);
>> +	int (*enable)(struct ofono_emulator *e, int fd);
>> +	int (*disable)(struct ofono_emulator *e);
>> +};
> =

> For the emulator we really don't need a driver, see below...

My original idea is that we need support DUN/HFPAG/SPP types of emulators. =
So we need a good framework to support it. Remember we could have both DUN/=
HFPAG atoms co-exist at the same time.

Your idea is better. It might work.

>> +
>> +const char *ofono_emulator_get_path(struct ofono_emulator *e);
>> +void ofono_emulator_set_data(struct ofono_emulator *e, void
>> *user_data); +void *ofono_emulator_get_data(struct ofono_emulator
>> *e); +
> =

> If there's no driver, then these are not required...
> =

>> +struct ofono_emulator *ofono_emulator_create(struct ofono_modem
>> *modem, +					struct
> ofono_emulator_driver *driver);
> =

> So I think we should simply do it like this:
> =

> struct ofono_emulator *ofono_emulator_create(struct ofono_modem
> *modem, enum ofono_emulator_type type, int fd);
> =

> Once we have the fd we really don't need anything else.  If the fd
> goes away we can safely remove the atom.  If the modem is powered
> down, we can safely shut down the connection.
> =

>> +void ofono_emulator_remove(struct ofono_emulator *e);
>> +
> =

> This might or might not be necessary...
> =

>> +int ofono_emulator_driver_register(const struct
> ofono_emulator_driver *driver);
>> +void ofono_emulator_driver_unregister(
>> +				const struct
> ofono_emulator_driver *driver);
>> +
> =

> These won't be necessary...
> =

> We then treat the emulator atom the same as any atom.  When
> the modem is
> powered off the atom is removed.  The bluetooth dun plugin can create
> look at the list of modems, establish the state watch (e.g. off/on
> pre_sim/offline/online) and register the DUN atom appropriately (most
> likely when the modem is turned on)
>
> It will be up to the plugin to figure out which Bluetooth adapter to
> register on (perhaps always the default one) and which modems to
> expose (maybe a configuration file?) =


I grabed code from obex to register&start DUN GW service when we parse adap=
ter properties. From patch 6/6, you can see my current implementation is to=
 find the first powered modem that having GRPS atom. Load settings from mod=
em.conf could be another option. But what if the modem is detected from ude=
v? It could be huawei0, huawei1 or huawei<N>.
 =

> Regards,
> -Denis



Regards,
Zhenhua


--===============4872698339155927895==--

