Content-Type: multipart/mixed; boundary="===============2379545725775927090=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono and BT interaction
Date: Thu, 09 Sep 2010 09:25:58 -0500
Message-ID: <4C88EE76.6020002@gmail.com>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46D581ECC2@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2379545725775927090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

> What=E2=80=99s the best solution?
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

--===============2379545725775927090==--

