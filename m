Content-Type: multipart/mixed; boundary="===============2919350376628196711=="
MIME-Version: 1.0
From: Reinhard Speyerer <rspmn@arcor.de>
Subject: Re: [PATCH v2 1/3] qmi: add LTE atom driver
Date: Sun, 04 Mar 2018 21:02:01 +0100
Message-ID: <20180304200200.dpjwhk2mekit3xbz@arcor.de>
In-Reply-To: <0bb0e70b-cb10-3828-73da-86442dbf1051@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2919350376628196711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 10:36:05AM -0600, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 03/02/2018 09:12 AM, Jonas Bonn wrote:
> > This patch adds an LTE atom for QMI modems.
> > =

> > This atom sets the APN that the LTE default bearer should use when
> > establishing its PDP context.  This APN needs to be set on the 'default'
> > profile so the atom queries which profile is the default and resets
> > it before allowing the APN to be set.
> > =

> > Once configured, the default profile settings are used when the
> > modem connects to the network; for this reason, the LTE atom needs
> > to be instantiated in post_sim, before the modem is set online.
> > ---
> >   Makefile.am                 |   1 +
> >   drivers/qmimodem/lte.c      | 266 +++++++++++++++++++++++++++++++++++=
+++++++++
> >   drivers/qmimodem/qmimodem.c |   2 +
> >   drivers/qmimodem/qmimodem.h |   3 +
> >   4 files changed, 272 insertions(+)
> >   create mode 100644 drivers/qmimodem/lte.c
> =

> So this looks good to me.  Since Reinhard has provided invaluable insight
> into how QMI works in the past and seems to have 'insider' knowledge, may=
be
> we can get him to also comment on whether the approach is correct (e.g.
> whether querying / setting the default profile is equivalent to setting t=
he
> default LTE attach parameters) or if there's another QMI command that sho=
uld
> be used.

Hi Denis,

unfortunately the assumption that the profile number returned from
WDSGetDefaultProfileNumber is used for handling the default LTE attach
parameters does not hold in all cases:

1. Huawei ME909u devices are known to use <cid>/profile number 16 for
   LTE attach although WDSGetDefaultProfileNumber returns 1.

2. Some devices like SIMCom SIM7230E will still use their "default default
   profile number" even if WDSSetDefaultProfileNumber has been used to
   set it to different value (which is also reported as changed by
   WDSGetDefaultProfileNumber).

Some older devices like Sierra Wireless MC77xx do not implement
WDSGetLTEAttachParameters.

Since I only have to support a fixed number of QMI devices I still use
AT commands and a fixed <cid> (16 for the ME909u, 1 otherwise) to handle
the default LTE attach parameters. An approach like this may not be
suitable for a general framework like Ofono.

Regards,
Reinhard

--===============2919350376628196711==--

