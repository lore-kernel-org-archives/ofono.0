Content-Type: multipart/mixed; boundary="===============6399119928213927462=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/6] Driver registration rework
Date: Mon, 29 Oct 2018 15:26:31 -0500
Message-ID: <7299df44-c133-1021-82b0-1100eec25915@gmail.com>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6399119928213927462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/26/2018 04:54 AM, Jonas Bonn wrote:
> Hi Denis,
> =

> Since I don't know if you'd even be interested in a series like this,
> here's a draft that touches just a few places to give you an idea of
> where this would take us... take a look and let me know what you think.
> =

> /Jonas
> =

> ******
> =

> ofono has historically had a system in place whereby modems are
> encapsulated as 'plugins', the idea being that these could be loosely
> coupled to the core and added/removed flexibly as requirements changed.
> Theoretically, the plugin would register a set of new drivers (atoms)
> with the core and then call ofono_modem_register(...) after having
> configured the modem object appropriately (device node, etc).  In
> practice, however, this does not work well and the modem plugins don't
> really follow this model.

Yeah it is a bit of a historical weirdness.  We put the atom drivers =

into drivers/* and the modem drivers went into plugins/ along with =

actual plugins.  Maybe we should fix that...

> =

> - drivers (atoms) use a lot of core functionality and cannot be built
> externally using only the exported ofono headers.  As such, the
> drivers really need to be part of core ofono, irregardless of whether
> they are packed into separate modules (plugins) or linked into one
> monolithici mage

Sort of.  They're still drivers and can be removed at will from the =

core.  The only thing that having them in tree helps with is access to =

some private headers.  And even these are not really that numerous.

> =

> - ofono no longer provides the ability to built the plugins in the
> source tree as external libs; they are all linked into one monolithic
> image by default with no option to change this

You can in theory do this, but not for in-tree plugins/drivers.  What =

would be the point anyway?

> =

> - the modem 'plugins' are 99% modem driver and 1% plugin; the plugin bit
> just takes care of registering the modem driver with the core and does
> nothing else

True.  As I said, the modem drivers should probably be in a separate =

place.  I was never fully happy with how this got setup, but then this =

isn't that big of an issue in my mind.

> =

> - udevng takes care of setting up the modem objects and binding them
> with their drivers
> =

> This patch series tries to addres this in the following way:
> =

> i) Add driver registration macros that lift registration with the core
> into init() (constructor) functions; this allows the drivers to
> automatically be registered at startup or on module load if they happen
> be part of a plugin

Except this breaks our plugin whitelist / blacklist logic.  And also =

makes it impossible to control the init / exit sequence which might be =

useful to have.

If you really want to do this, then maybe we need to use the 'section()' =

magic for this.  Look into e.g. how iwd registers eap methods.

Still a question of how we handle atom driver registration...

> =

> ii)  Move the 'modem driver' part of the modem plugins into the drivers/
> directory.

I'm not sure drivers/ is really the right place.  At least it is weird =

to me that gobi would live in drivers/qmimodem/.  Perhaps we need a =

place for modem drivers only.

> =

> iii)  If the plugins are doing nothing other than registering the modem
> driver, drop it altogether.
> =

> Jonas Bonn (6):
>    include: add macros for declaring drivers
>    qmimodem: simplify driver registration
>    gobi: modem driver cannot be a plugin
>    atmodem: add missing headers to atutil.h
>    telitmodem: simplify driver registration
>    telitmodem: modem driver is not a plugin
> =

>   Makefile.am                             | 12 ++----
>   drivers/atmodem/atutil.h                |  3 ++
>   {plugins =3D> drivers/qmimodem}/gobi.c    | 13 +------
>   drivers/qmimodem/gprs-context.c         | 10 +----
>   drivers/qmimodem/location-reporting.c   | 10 +----
>   drivers/qmimodem/qmimodem.c             |  4 --
>   drivers/qmimodem/qmimodem.h             |  6 ---
>   drivers/telitmodem/gprs-context-ncm.c   | 15 +-------
>   drivers/telitmodem/location-reporting.c | 16 ++------
>   {plugins =3D> drivers/telitmodem}/telit.c | 15 +-------
>   drivers/telitmodem/telitmodem.c         | 51 -------------------------
>   drivers/telitmodem/telitmodem.h         | 27 -------------
>   include/gprs-context.h                  | 11 ++++++
>   include/location-reporting.h            | 10 +++++
>   include/modem.h                         | 11 ++++++
>   15 files changed, 47 insertions(+), 167 deletions(-)
>   rename {plugins =3D> drivers/qmimodem}/gobi.c (97%)
>   rename {plugins =3D> drivers/telitmodem}/telit.c (97%)
>   delete mode 100644 drivers/telitmodem/telitmodem.c
>   delete mode 100644 drivers/telitmodem/telitmodem.h
> =


Regards,
-Denis

--===============6399119928213927462==--

