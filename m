Content-Type: multipart/mixed; boundary="===============6628058576703556524=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [RFC PATCH 3/3] huawei: Set property "AlwaysOnline" for CDMA
 modems
Date: Thu, 28 Mar 2013 11:34:52 -0400
Message-ID: <20130328153452.GJ29445@alittletooquiet.net>
In-Reply-To: <515459B2.5020801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6628058576703556524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the quick reply.

On Thu, Mar 28, 2013 at 09:54:42AM -0500, Denis Kenzior wrote:
> On 03/28/2013 09:22 AM, Forest Bond wrote:
> >From: Forest Bond<forest.bond@rapidrollout.com>
> >
> >---
> >  plugins/huawei.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> >diff --git a/plugins/huawei.c b/plugins/huawei.c
> >index 5d8875a..0621d5b 100644
> >--- a/plugins/huawei.c
> >+++ b/plugins/huawei.c
> >@@ -377,6 +377,9 @@ static void cfun_offline(gboolean ok, GAtResult *res=
ult, gpointer user_data)
> >  		return;
> >  	}
> >
> >+	if (data->have_gsm =3D=3D FALSE&&  data->have_cdma =3D=3D TRUE)
> >+		ofono_modem_set_boolean(modem, "AlwaysOnline", TRUE);
> >+
> >  	ofono_modem_set_powered(modem, TRUE);
> >  }
> >
> =

> Things don't seem to be this simple.  The Huawei driver sets the
> modem offline as part of the init procedure (grep for
> 'offline_command').  So once we enable the device, it is put into
> radio off mode.  With the changes you're proposing there will be no
> way to get it online ;)

Okay, I see that now.  I only have a Huawei GSM device and a Sierra Wireless
CDMA device to test with.

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============6628058576703556524==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxGVVl4d0FDZ2tRUk80ZlFRZHY1QXgvbGdDZUlMZHdabTVx
dmJVTEZaZEkrb2hVbkxLdQo3TWtBb0tCZ2NjM2lyU0R1a09DRjZqR0tucGdoTG9FNQo9YTZ0Rgot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============6628058576703556524==--

