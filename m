Content-Type: multipart/mixed; boundary="===============6040559350651870463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] qmi: add LTE atom driver
Date: Mon, 05 Mar 2018 11:39:39 -0600
Message-ID: <4ccf0385-d534-c05e-856c-8c7024e7e6f7@gmail.com>
In-Reply-To: <20180304200200.dpjwhk2mekit3xbz@arcor.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6040559350651870463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Reinhard,

>> So this looks good to me.  Since Reinhard has provided invaluable insigh=
t >> into how QMI works in the past and seems to have 'insider' =

knowledge, maybe
>> we can get him to also comment on whether the approach is correct (e.g.
>> whether querying / setting the default profile is equivalent to setting =
the
>> default LTE attach parameters) or if there's another QMI command that sh=
ould
>> be used.
> =

> Hi Denis,
> =

> unfortunately the assumption that the profile number returned from
> WDSGetDefaultProfileNumber is used for handling the default LTE attach
> parameters does not hold in all cases:
> =

> 1. Huawei ME909u devices are known to use <cid>/profile number 16 for
>     LTE attach although WDSGetDefaultProfileNumber returns 1.
> =

> 2. Some devices like SIMCom SIM7230E will still use their "default default
>     profile number" even if WDSSetDefaultProfileNumber has been used to
>     set it to different value (which is also reported as changed by
>     WDSGetDefaultProfileNumber).
> =

> Some older devices like Sierra Wireless MC77xx do not implement
> WDSGetLTEAttachParameters.

Okay, so it sounds like we have some vendor quirks to take care of.

> =

> Since I only have to support a fixed number of QMI devices I still use
> AT commands and a fixed <cid> (16 for the ME909u, 1 otherwise) to handle
> the default LTE attach parameters. An approach like this may not be
> suitable for a general framework like Ofono.
> =


In theory there's nothing preventing us from using AT commands to =

implement the lte atom for QMI based devices.  You can mix and match =

atom drivers from different driver trees fairly easily.

Another alternative is to introduce vendor quirks for QMI, similar to =

how we use enumerations defined in drivers/atmodem/vendor.h.

Regards,
-Denis

--===============6040559350651870463==--

