Content-Type: multipart/mixed; boundary="===============4247547030489967476=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Wed, 06 Mar 2013 08:36:20 -0500
Message-ID: <20130306133620.GA25181@alittletooquiet.net>
In-Reply-To: <87boawoocg.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4247547030489967476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B8rn,

On Wed, Mar 06, 2013 at 10:43:27AM +0100, Bj=C3=B8rn Mork wrote:
> Forest Bond <forest@alittletooquiet.net> writes:
> > On Tue, Mar 05, 2013 at 10:45:15PM +0100, Bj=C3=B8rn Mork wrote:
> >> Forest Bond <forest@alittletooquiet.net> writes:
> >> =

> >> > Anyway, I notice that one of the ports appears to be QCDM.  It appea=
rs that QCDM
> >> > support is partially implemented in oFono?  But I don't know QCDM at=
 all.  Can
> >> > we use it to do netreg?
> >> =

> >> What kind of Sierra device is this?  And what vid is it using?
> >
> > Well, I'm really after a few devices:
> >
> > * Sierra Wireless USB 598 (Sprint/Telus branded)
> > * Sierra Wireless MC5728V (Feeney Wireless Skyus 3G)
> >
> > The 598 has VID 0025.  I think the Skyus 3G does, too (at least in some
> > configurations), but I don't have one in front of me to check.  In any =
case it
> > is a very similar part to the 598.  All I have to test with right now i=
s a Telus
> > demo device (with no service :/) as my other parts were returned to the=
ir
> > respective owners some time ago.
> >
> >> I ask because I have only seen QCDM ports active on Sierra devices
> >> in firmware modes with rmnet/qmi_wwan interfaces.  In which case you
> >> should have QMI support.
> >
> > I couldn't get qmicli to do anything with any of the ports, but test-qc=
dm (from
> > the ModemManager source tree) seems to like talking to the last port.
> >
> >> > If not, I could probably implement (partial) CnS support at some poi=
nt.  I'm
> >> > just not sure I will have time to do it right away.
> >> =

> >> And those modes do not have any CnS ports.
> >
> > These parts definitely have CnS ports.  We've used CnS for an unrelated=
 project
> > with all of these devices.
> >
> > In all, I think the ports are as follows:
> >
> > 1. AT commands
> > 2. CnS
> > 3. NMEA 0183 (GPS)
> > 4. QCDM
> >
> > WRT #3, I remember seeing what looked like NMEA a while back using a Sp=
rint
> > part.  WRT #4 I've only ever tested the Telus part.
> >
> > What do you think?
> =

> Thanks.  I think you are right.  Learning something new every day.
> Until know I thought they had a clear split between "Qualcomm" and
> "Sierra" protocols, but these devices obviously do a mix.  Is the NMEA
> port Sierra style (enabled using the SetNmea control message) or
> Qualcomm style (enabled by writing "$GPS_START" to the port)?

Sierra style.  Passing nmea=3D1 to the sierra kernel module enables it.

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============4247547030489967476==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxFM1JsUUFDZ2tRUk80ZlFRZHY1QXk2MFFDZ3MwY290N00x
RC9GcWR2ajF6VVloQ25odgo1c1lBb0pOcDY4dkkvbkt1K2hoY0JINHhiY3JtV0d2Qwo9RVdyLwot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============4247547030489967476==--

