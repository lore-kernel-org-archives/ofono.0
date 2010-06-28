Content-Type: multipart/mixed; boundary="===============2851159794872335734=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] mbm: use cpin? to check if SIM is missing
Date: Mon, 28 Jun 2010 22:39:02 +0200
Message-ID: <AANLkTilYOIv-J2SzZd531IdEAFbUuL1vDltcFm47bkUk@mail.gmail.com>
In-Reply-To: <1277749213-3499-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2851159794872335734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28 June 2010 20:20, Pekka Pessi <Pekka.Pessi@nokia.com> wrote:
> Use AT+CPIN? in case AT+CRSM=3D242 is not supported.

On the model where AT+CRSM works, AT+CPIN also works, so I propose to
use it always.  The firmware may cache information but when card is
extracted it notices.

Regards,
Andrew

--===============2851159794872335734==--

