Content-Type: multipart/mixed; boundary="===============8699073753702815974=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Mon, 11 Jul 2011 10:47:04 +0300
Message-ID: <4E1AAA78.2010203@intel.com>
In-Reply-To: <4E174B26.3080004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8699073753702815974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 07/08/2011 09:23 PM, Denis Kenzior wrote:
> What I wonder is what is the overhead of the XML parser right now (e.g.
> how long it takes on reasonable embedded hardware).  If this takes a
> while, then it might be better to pre-parse the mobile-provider-info db
> during plugin initialization and not every time gprs_provision is
> called.  Otherwise we run the risk of hanging the daemon while the
> provision settings are being looked up.

Thanks for the input. Yes, this might be the problem. I could try to =

test with N900 in order to get the idea of how long the parsing can =

take. Pre-parsing might be a good idea anyway, I will try to check how =

feasible it is.

Regards,
Oleg
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki =

Business Identity Code: 0357606 - 4 =

Domiciled in Helsinki =


This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8699073753702815974==--

