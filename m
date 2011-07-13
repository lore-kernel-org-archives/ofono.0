Content-Type: multipart/mixed; boundary="===============1240747537191476653=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Wed, 13 Jul 2011 08:18:48 -0500
Message-ID: <4E1D9B38.3000206@gmail.com>
In-Reply-To: <4E1D764F.5000707@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1240747537191476653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 07/13/2011 05:41 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 07/08/2011 09:23 PM, Denis Kenzior wrote:
>> What I wonder is what is the overhead of the XML parser right now (e.g.
>> how long it takes on reasonable embedded hardware).  If this takes a
>> while, then it might be better to pre-parse the mobile-provider-info db
>> during plugin initialization and not every time gprs_provision is
>> called.  Otherwise we run the risk of hanging the daemon while the
>> provision settings are being looked up.
> =

> I have tested on N900 (MeeGo 1.2 Community Edition on microSDHC class 4
> card), it takes 0.1 second to load and parse the mobile-provider-info
> database (154KB).
> =

> Is this a reasonable time or should we go with pre-parsing?

My rule of thumb is less than 300 ms is not really noticeable to the
user and anything up to 1 second is OK.  So in this case I'd say we
should be fine parsing on demand.

If we ever encounter performance problems we can revisit this decision.

Regards,
-Denis

--===============1240747537191476653==--

