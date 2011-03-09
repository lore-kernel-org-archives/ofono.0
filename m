Content-Type: multipart/mixed; boundary="===============6492503816781349723=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH 0/3] integration of kernel mux (n_gsm) and its line discipline
Date: Wed, 09 Mar 2011 16:45:50 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DB6@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6492503816781349723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Following set of patch adds support of the kernel mux (n_gsm) for the ifx m=
odem.
They were tested with the latest version of the kernel mux who is currently=
 under submission.

Following tests were performed (and pass):

	- PDP context activation/deactivation back-to-back (x15)
	- Enable/disable modem back-to-back (x10)
	- PDP context activation with wrong APN
	- Lost of network connection during PDP context activation
	- Lost of network connection with a PDP context activated

Regards,
Guillaume

---
 plugins/ifx.c |   83 ++++++++++++++++++++++++++++++++++++++++++++---------=
---
 drivers/ifxmodem/gprs-context.c |   95 +++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 169 insertions(+), 23 deletions(-)
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6492503816781349723==--

