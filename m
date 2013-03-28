Content-Type: multipart/mixed; boundary="===============5879082474367111778=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [RFC PATCH 2/3] modem: Support modem property "AlwaysOnline"
Date: Thu, 28 Mar 2013 11:36:35 -0400
Message-ID: <20130328153635.GK29445@alittletooquiet.net>
In-Reply-To: <515459DD.1070203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5879082474367111778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Mar 28, 2013 at 09:55:25AM -0500, Denis Kenzior wrote:
> Hi Forest,
> =

> On 03/28/2013 09:22 AM, Forest Bond wrote:
> >From: Forest Bond<forest.bond@rapidrollout.com>
> >
> >---
> >  src/modem.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> >
> =

> I would actually be okay with this as an interim solution, but see
> my comments to patch 3.

Great, glad to hear it.

Quick question:  Once this change is in place, set_online is not called for=
 CDMA
devices.  Should I kill the CDMA-only code paths there?

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============5879082474367111778==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxGVVk0TUFDZ2tRUk80ZlFRZHY1QXpPc1FDZ3JzMUdZMTgz
SWp0VlBWTFdDdEt1MDF3UwpnVWtBb014dEpMSXJzVy9kTThtMWRxdWswQlM3MEFvWAo9YXFqcwot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============5879082474367111778==--

