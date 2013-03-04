Content-Type: multipart/mixed; boundary="===============3293754652606718360=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Mon, 04 Mar 2013 11:48:36 -0500
Message-ID: <20130304164836.GI11149@alittletooquiet.net>
In-Reply-To: <50E0F9B5.20906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3293754652606718360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sun, Dec 30, 2012 at 08:34:29PM -0600, Denis Kenzior wrote:
> >-	ofono_netreg_create(modem, 0, "atmodem", data->modem);
> >+	if (data->have_gsm =3D=3D TRUE) {
> >+		ofono_netreg_create(modem, 0, "atmodem", data->modem);
> >+	} else if (data->have_cdma =3D=3D TRUE) {
> >+		/*
> >+		 * Once we have CnS protocol support, we should be able to do
> >+		 * netreg that way instead of using the same port for both.
> >+		 */
> >+		ofono_cdma_netreg_create(modem, 0, "sierramodem", data->modem);
> >+		ofono_cdma_connman_create(modem, OFONO_VENDOR_SIERRA,
> >+						"cdmamodem", data->modem);
> >+	}
> =

> Ah I see what you're doing now.  This is really not going to work
> too well if you have just one AT port available...

I'm looking to pick this series back up now.  I understand the implementati=
on is
not ideal, but it at least provides for basic connectivity until we have su=
pport
for the CnS protocol.  Will you accept the full series if I address the oth=
er
issues with the code that you mentioned?

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============3293754652606718360==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxFMDBHUUFDZ2tRUk80ZlFRZHY1QXdJSndDZEdoRStjUTFp
aWdOR2NudlhoVGpIcm5sVApFRjhBbmluekI0c0ZCME9vcHVhSGlmNUF2VXVmZDMrcAo9Q2ZMbwot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3293754652606718360==--

