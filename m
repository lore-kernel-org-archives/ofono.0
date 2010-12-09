Content-Type: multipart/mixed; boundary="===============0838342012663391349=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 11:49:25 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC03027A@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1291890453.4795.213.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0838342012663391349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


> so what about the cases when roaming is allowed or not? These needs to
> be taken into account and that is oFono's job. That is the reason why
> ConnMan follows the attach state. Since we don't wanna activate a
> context when roaming and data roaming is not allowed.

Ok, I see the concern. I'd propose making GPRS availability a separate prop=
erty from GPRS attach status. Availability can be decided on registration s=
tatus alone (i.e., does the network advertise GPRS and does the roaming che=
ck allow GPRS). Both GPRS attach and PDP context activation can in any case=
 fail for transient reasons, so ConnMan needs to have some logic to retry c=
ontext activation.

Br,

	MikaL

--===============0838342012663391349==--

