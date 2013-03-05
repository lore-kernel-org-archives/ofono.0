Content-Type: multipart/mixed; boundary="===============8871821369154666880=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Tue, 05 Mar 2013 14:36:19 -0500
Message-ID: <20130305193619.GK11149@alittletooquiet.net>
In-Reply-To: <51352849.9080506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8871821369154666880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Mar 04, 2013 at 05:03:37PM -0600, Denis Kenzior wrote:
> On 03/04/2013 10:48 AM, Forest Bond wrote:
> >On Sun, Dec 30, 2012 at 08:34:29PM -0600, Denis Kenzior wrote:
> >>>-	ofono_netreg_create(modem, 0, "atmodem", data->modem);
> >>>+	if (data->have_gsm =3D=3D TRUE) {
> >>>+		ofono_netreg_create(modem, 0, "atmodem", data->modem);
> >>>+	} else if (data->have_cdma =3D=3D TRUE) {
> >>>+		/*
> >>>+		 * Once we have CnS protocol support, we should be able to do
> >>>+		 * netreg that way instead of using the same port for both.
> >>>+		 */
> >>>+		ofono_cdma_netreg_create(modem, 0, "sierramodem", data->modem);
> >>>+		ofono_cdma_connman_create(modem, OFONO_VENDOR_SIERRA,
> >>>+						"cdmamodem", data->modem);
> >>>+	}
> >>
> >>Ah I see what you're doing now.  This is really not going to work
> >>too well if you have just one AT port available...
> >
> >I'm looking to pick this series back up now.  I understand the implement=
ation is
> >not ideal, but it at least provides for basic connectivity until we have=
 support
> >for the CnS protocol.  Will you accept the full series if I address the =
other
> >issues with the code that you mentioned?
> =

> If we accept something upstream we assume full responsibility for
> the code, and everything that entails, including future maintenance.
> Thus we do not have a habit of accepting functionality that is
> inherently broken.  So unless you can convince me otherwise, my
> answer is: "I'd rather not" ;)

Well I think the argument to make is that we ought to be able to gracefully
degrade to handle a device that we have limited support for.  We know how to
bring up a connection on this device.  I think users would prefer to have a
device that works with a limited feature set than one that doesn't work at =
all.

Anyway, I notice that one of the ports appears to be QCDM.  It appears that=
 QCDM
support is partially implemented in oFono?  But I don't know QCDM at all.  =
Can
we use it to do netreg?

If not, I could probably implement (partial) CnS support at some point.  I'm
just not sure I will have time to do it right away.

I assume a proper netreg implementation on one of these other ports would
address your primary concern?

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============8871821369154666880==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxFMlNUTUFDZ2tRUk80ZlFRZHY1QXpralFDZEdHNWRCZFN1
VlZ6Rm44NTVvNWViMGEwVQo1eThBbjJFK0s1NUhaU1dYR1RlSjkzR2N0Y0ZUQTRJTgo9Z3c3Ugot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8871821369154666880==--

