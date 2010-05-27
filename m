Content-Type: multipart/mixed; boundary="===============7978537419548401406=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH]enable-modem.c
Date: Thu, 27 May 2010 19:53:13 +0200
Message-ID: <1274982793.4706.55.camel@aeonflux.t-mobile.de>
In-Reply-To: <24A9345B397CD24AA76A4E82E237956531ECF3AD4F@XCHTS.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7978537419548401406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

> here is the first simple example in c for enabling modem. This is my firs=
t time using glib, dbus and git so I hope not to have done too many mistake=
s... If you find it useful I can continue submitting the others I have,
>
> test/enable-modem.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> 1 files changed, 116 insertions(+), 0 deletions(-)
> =

> diff --git a/test/enable-modem.c b/test/enable-modem.c
> new file mode 100644
> index 0000000..610b933
> --- /dev/null
> +++ b/test/enable-modem.c
> @@ -0,0 +1,116 @@
> +/*
> + * enable-modem.c
> + *
> + *  Created on: 25/mag/2010
> + *  Author: Daniele Palmas <daniele.palmas@telit.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include "dbus/dbus-glib.h"

so we have a strict no gobject and no dbus-glib policy within the oFono
source code. I would prefer if you re-write it just using the low-level
libdbus. I know that dictionary parsing can be tricky, but it is not
that complicated. Check the connman/client/main.c for some simple
example on just to use libdbus.

Regards

Marcel



--===============7978537419548401406==--

