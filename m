Content-Type: multipart/mixed; boundary="===============3796623601372708623=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Tue, 05 Mar 2013 17:15:39 -0500
Message-ID: <20130305221538.GL11149@alittletooquiet.net>
In-Reply-To: <87obexo710.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3796623601372708623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B8rn,

On Tue, Mar 05, 2013 at 10:45:15PM +0100, Bj=C3=B8rn Mork wrote:
> Forest Bond <forest@alittletooquiet.net> writes:
> =

> > Anyway, I notice that one of the ports appears to be QCDM.  It appears =
that QCDM
> > support is partially implemented in oFono?  But I don't know QCDM at al=
l.  Can
> > we use it to do netreg?
> =

> What kind of Sierra device is this?  And what vid is it using?

Well, I'm really after a few devices:

* Sierra Wireless USB 598 (Sprint/Telus branded)
* Sierra Wireless MC5728V (Feeney Wireless Skyus 3G)

The 598 has VID 0025.  I think the Skyus 3G does, too (at least in some
configurations), but I don't have one in front of me to check.  In any case=
 it
is a very similar part to the 598.  All I have to test with right now is a =
Telus
demo device (with no service :/) as my other parts were returned to their
respective owners some time ago.

> I ask because I have only seen QCDM ports active on Sierra devices
> in firmware modes with rmnet/qmi_wwan interfaces.  In which case you
> should have QMI support.

I couldn't get qmicli to do anything with any of the ports, but test-qcdm (=
from
the ModemManager source tree) seems to like talking to the last port.

> > If not, I could probably implement (partial) CnS support at some point.=
  I'm
> > just not sure I will have time to do it right away.
> =

> And those modes do not have any CnS ports.

These parts definitely have CnS ports.  We've used CnS for an unrelated pro=
ject
with all of these devices.

In all, I think the ports are as follows:

1. AT commands
2. CnS
3. NMEA 0183 (GPS)
4. QCDM

WRT #3, I remember seeing what looked like NMEA a while back using a Sprint
part.  WRT #4 I've only ever tested the Telus part.

What do you think?

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============3796623601372708623==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxFMmJvb0FDZ2tRUk80ZlFRZHY1QXh0L0FDZzIwcWtGWWNj
RkJtT2pSUENMQllFOG5idwo1SklBb0o3ZmEzR3I1TW1yZDU5RXd2S2d5Q29nTGdyVwo9VEZhRgot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3796623601372708623==--

