Content-Type: multipart/mixed; boundary="===============9166597123180583396=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] emulator: Add ofono_emulator framework
Date: Tue, 13 Jul 2010 12:56:14 -0500
Message-ID: <4C3CA8BE.4010403@gmail.com>
In-Reply-To: <1278308709-13908-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9166597123180583396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +#define OFONO_EMULATOR_INTERFACE "org.ofono.Emulator"

So my suggestion is to keep it simple and not include the D-Bus
interface for the emulator at all for now.

> +
> +#include <ofono/types.h>
> +
> +struct ofono_emulator;
> +
> +enum ofono_emulator_type {
> +	OFONO_EMULATOR_TYPE_NONE,

Type NONE seems to be useless :)

> +	OFONO_EMULATOR_TYPE_DUN,
> +};
> +
> +struct ofono_emulator_driver {
> +	const char *name;
> +	enum ofono_emulator_type type;
> +	int (*probe)(struct ofono_emulator *e);
> +	void (*remove)(struct ofono_emulator *e);
> +	int (*enable)(struct ofono_emulator *e, int fd);
> +	int (*disable)(struct ofono_emulator *e);
> +};

For the emulator we really don't need a driver, see below...

> +
> +const char *ofono_emulator_get_path(struct ofono_emulator *e);
> +void ofono_emulator_set_data(struct ofono_emulator *e, void *user_data);
> +void *ofono_emulator_get_data(struct ofono_emulator *e);
> +

If there's no driver, then these are not required...

> +struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
> +					struct ofono_emulator_driver *driver);

So I think we should simply do it like this:

struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
enum ofono_emulator_type type, int fd);

Once we have the fd we really don't need anything else.  If the fd goes
away we can safely remove the atom.  If the modem is powered down, we
can safely shut down the connection.

> +void ofono_emulator_remove(struct ofono_emulator *e);
> +

This might or might not be necessary...

> +int ofono_emulator_driver_register(const struct ofono_emulator_driver *d=
river);
> +void ofono_emulator_driver_unregister(
> +				const struct ofono_emulator_driver *driver);
> +

These won't be necessary...

We then treat the emulator atom the same as any atom.  When the modem is
powered off the atom is removed.  The bluetooth dun plugin can create
look at the list of modems, establish the state watch (e.g. off/on
pre_sim/offline/online) and register the DUN atom appropriately (most
likely when the modem is turned on)

It will be up to the plugin to figure out which Bluetooth adapter to
register on (perhaps always the default one) and which modems to expose
(maybe a configuration file?)

Regards,
-Denis

--===============9166597123180583396==--

