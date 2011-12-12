Content-Type: multipart/mixed; boundary="===============1050197501010377440=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/3] n950: Add modem plugin for the N950
Date: Mon, 12 Dec 2011 11:52:34 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E083BF3@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <1323689984-24866-2-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1050197501010377440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of marko.saukko(a)gmail.com
> Sent: Monday, December 12, 2011 12:40 PM
> To: ofono(a)ofono.org
> Subject: [PATCH 1/3] n950: Add modem plugin for the N950
> =

> From: Aki Niemi <aki.niemi@nokia.com>
> =

> ---
>  Makefile.am          |    3 +
>  plugins/n900.c       |   12 +-
>  plugins/n950.c       |  563
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/nokia-gpio.c |  105 ++++------
>  plugins/nokia-gpio.h |   38 +++-
>  5 files changed, 651 insertions(+), 70 deletions(-)  create mode 100644
> plugins/n950.c
> =


I would say that this patch doesn't add N950 plugin, but first rename some =
nokia gpio function, update N900 plugin and then introduce the N950.

So I would propose to split this patches in multiple:
 - a first one which modify nokia gpio APIs,
 - a second one that modify the N900 to reflect the changes
 - a third one that introduce the N950, wich may include your third patch t=
hat disable the CBS
 - a fourth one that include the N950 plugin in the makefile.

Regards,

Bertrand.
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


--===============1050197501010377440==--

