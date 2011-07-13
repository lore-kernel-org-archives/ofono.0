Content-Type: multipart/mixed; boundary="===============7182554096812942359=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Wed, 13 Jul 2011 13:41:19 +0300
Message-ID: <4E1D764F.5000707@intel.com>
In-Reply-To: <4E174B26.3080004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7182554096812942359==
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

I have tested on N900 (MeeGo 1.2 Community Edition on microSDHC class 4 car=
d), =

it takes 0.1 second to load and parse the mobile-provider-info database (15=
4KB).

Is this a reasonable time or should we go with pre-parsing?

Regards,
Oleg

-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============7182554096812942359==--

