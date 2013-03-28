Content-Type: multipart/mixed; boundary="===============8137772201881192292=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [RFC PATCH 2/3] modem: Support modem property "AlwaysOnline"
Date: Thu, 28 Mar 2013 12:33:46 -0400
Message-ID: <20130328163346.GL29445@alittletooquiet.net>
In-Reply-To: <51546A52.70405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8137772201881192292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Mar 28, 2013 at 11:05:38AM -0500, Denis Kenzior wrote:
> On 03/28/2013 10:36 AM, Forest Bond wrote:
> >On Thu, Mar 28, 2013 at 09:55:25AM -0500, Denis Kenzior wrote:
> >>On 03/28/2013 09:22 AM, Forest Bond wrote:
> >>>From: Forest Bond<forest.bond@rapidrollout.com>
> >>>
> >>>---
> >>>  src/modem.c |   15 +++++++++++++--
> >>>  1 files changed, 13 insertions(+), 2 deletions(-)
> >>>
> >>
> >>I would actually be okay with this as an interim solution, but see
> >>my comments to patch 3.
> >
> >Great, glad to hear it.
> >
> >Quick question:  Once this change is in place, set_online is not called =
for CDMA
> >devices.  Should I kill the CDMA-only code paths there?
> =

> I don't recall off hand which code paths these are.  Can you elaborate?

Sorry, I guess I was thinking of the sierra plugin.  In the huawei plugin t=
he
only candidate for removal would be this chunk in rfswitch_support:

if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE) {
	data->offline_command =3D "AT+CFUN=3D5";
	goto done;
}

But I guess we might as well leave that.

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============8137772201881192292==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxGVWNPb0FDZ2tRUk80ZlFRZHY1QXc3b1FDZ2xHQ2gxcEg4
dFVIM1VQd08ySEFrMjBibQpIY0lBbjBUSG5vRktxN2E2aDRFSjVKczUrLzdMSjV3SAo9T0IzYQot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8137772201881192292==--

