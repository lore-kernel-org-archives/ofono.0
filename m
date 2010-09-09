Content-Type: multipart/mixed; boundary="===============4054929193394242923=="
MIME-Version: 1.0
From: Berthier, Emmanuel <emmanuel.berthier@intel.com>
Subject: RE: Ofono and BT interaction
Date: Thu, 09 Sep 2010 17:49:07 +0100
Message-ID: <2A84145621092446B6659B8A0F28E26F46D581ED94@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4C88EE76.6020002@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4054929193394242923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

It's a good solution for ofono clients, but ofono will still dialogue with =
BT Modem (init), which is not very desirable.

Emmanuel.

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Thursday, September 09, 2010 4:26 PM
To: ofono(a)ofono.org
Cc: Berthier, Emmanuel
Subject: Re: Ofono and BT interaction

Hi Emmanuel,

On 09/09/2010 08:19 AM, Berthier, Emmanuel wrote:
> After pairing a Handset BT device with my Meego Handset board, ofono
> sees a new modem called /hfp/XXXXXX and can start a voice call on it.
> =

> It is an interesting feature from a Netbook perspective, but could be
> very confusing from a Handset perspective.
> =

>  =

> =

> I would prefer to remove BT devices from ofono modem list.
> =

>  =

> =

> What's the best solution?
> =

> - disable BT modem client profile?
> =

> - disable ofono HFP modem support?
> =


Would filtering by Modem type be enough? E.g. oFono could expose a
string Type property on the Modem Interface.  Possible values might be
'gsm', 'cdma', 'hfp', etc.

Regards,
-Denis
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


--===============4054929193394242923==--

