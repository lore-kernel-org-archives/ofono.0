Content-Type: multipart/mixed; boundary="===============6156249124742686383=="
MIME-Version: 1.0
From: Reinhard Speyerer <rspmn@arcor.de>
Subject: Re: connmand[186]: Online check failed but running dhclient manually
 fixes this issue
Date: Mon, 11 Dec 2017 13:48:12 +0100
Message-ID: <20171211124812.zoa7255sm255fzrd@arcor.de>
In-Reply-To: <28b08f67-b161-56f0-76e3-0621a1a49687@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6156249124742686383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 07:51:50AM +0100, Jonas Bonn wrote:
> On 12/11/2017 07:37 AM, Sean Nyekj=C3=A6r wrote:
> > Hi
> > Sorry if i'm reposting.
> > =

> > I'm also having this issue with the Quectel EC20 (and maybe EC21).
> =

> The EC21 is "raw ip" only so shouldn't be affected by this.=C2=A0 I've go=
t one
> and I've never seen this issue in any case.
> =

> /Jonas
> =


Hi all,

AFAIK the problem only affects devices with MDM9x15 and MDM9x25 chipsets
(e.g. Sierra Wireless MC73xx, SIMcom SIM7100x/SIM7230, Telit LE910 and the
Quectel EC20 mentioned above) when using the QMI interface in Ethernet mode
or when using a CDC ECM interface which internally uses the f_rmnet gadget
(e.g. Cinterion PLS8).

When switching the QMI interface to raw IP mode the use of a dummy DHCP
request to pass IP4 traffic through is no longer required for these devices.

Raw IP mode also has to be used for them to make dualstack work.
Please refer to this (long) thread
https://mail.gnome.org/archives/networkmanager-list/2015-November/msg00075.=
html
for details.

Regards,
Reinhard

> =

> > =

> > Any known fixes or workarounds i could try? Is the problem in connman o=
r ofono?
> > =

> > /Sean
> > =

> > On 6 September 2017 at 17:40, Denis Kenzior <denkenz@gmail.com> wrote:
> > > Hi Daniel,
> > > > > =

> > > > > If this is true, then falling back to DHCP would seem to be requi=
red
> > > > > for many Qualcomm based devices.  This seems to be a recently
> > > > > introduced 'bug' as older QMI devices did not need this workaroun=
d.
> > > > =

> > > > Do you think we should try to figure out which Qualcomm device is
> > > > misbehaving or should the feature just be reverted?
> > > =

> > > It would seem that this only affects devices introduced in the last s=
everal
> > > years.  The QMI code is from 2012, and the devices Marcel tested this=
 with
> > > worked fine.
> > > =

> > > Perhaps we should have plugins/udevng.c maintain a database of all the
> > > 'dhcp-required' devices and set this property accordingly.  Running D=
HCP
> > > takes time, so if it can be avoided, you get online a bit faster...
> > > =

> > > > The other option is to add some fallback mechanism in ConnMan and p=
rint
> > > > a fat warning into the log. But I don't this idea.
> > > > =

> > > Sounds like a least preferred option to me as well.
> > > =

> > > Regards,
> > > -Denis
> > > =

> > > _______________________________________________
> > > connman mailing list
> > > connman(a)lists.01.org
> > > https://lists.01.org/mailman/listinfo/connman
> > _______________________________________________
> > connman mailing list
> > connman(a)lists.01.org
> > https://lists.01.org/mailman/listinfo/connman

--===============6156249124742686383==--

