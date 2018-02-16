Content-Type: multipart/mixed; boundary="===============6207491817173742720=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] add syspath property to modem properties
Date: Fri, 16 Feb 2018 12:19:56 -0600
Message-ID: <8bc19fa5-e343-143a-69e4-a76496374106@gmail.com>
In-Reply-To: <cf9c2920-afde-36f0-6f8c-03bf8c4e45ed@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6207491817173742720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

No top posting please.

On 02/16/2018 09:40 AM, Christophe Ronco wrote:
> Hi Denis,
> =

> I didn't think this patch could be something used on Upstream Ofono.
> If it is, I also have remarks on my own patch:
>  =C2=A0- shouldn't it be two patches (one for plugin directory, another f=
or =

> src directory)?

yes, all the normal patch submission guidelines apply.  You should also =

include a doc patch.

>  =C2=A0- what is an acceptable name for the new DBUS property (currently =
it =

> is ModemSyspath):
>  =C2=A0=C2=A0 - ModemSysPath?
>  =C2=A0=C2=A0 - ModemSystemPath?
>  =C2=A0=C2=A0 - SystemPath?

Since you want to put it on the .Modem interface the 'Modem' prefix is =

redundant.  SystemPath should be okay, or maybe SysfsPath

>  =C2=A0- what about modems that don't come from udevng plugin? Property i=
s =

> not set for these modems, is it ok? Do we want a generic property name =

> to be able to also modify these plugins to give an information about =

> hardware identification (something like: HardwareId, HardwarePath)? Or =

> maybe SystemPath is also ok for these modems.

Or simply mark this property [optional] and be done with it.

Go ahead and resubmit and lets see what feedback we get.

Regards,
-Denis

--===============6207491817173742720==--

