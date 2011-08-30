Content-Type: multipart/mixed; boundary="===============0852855564389067027=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv4 3/3] Mobile broadband provider info plugin
Date: Tue, 30 Aug 2011 15:57:54 +0300
Message-ID: <4E5CDE52.8030507@intel.com>
In-Reply-To: <4E544E27.3030204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0852855564389067027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 08/24/2011 04:04 AM, Denis Kenzior wrote:
> However, I'm still wondering whether setting data->match_found is
> enough.  Here's the example I'm thinking of:
>
> <provider>
> 	<name>Major Operator</name>
> 	<network-id mcc=3D"555" mnc=3D"55"/>
> 	<apn>...</apn>
> </provider>
>
> <provider>
> 	<name>MVNO running on Major Operator</name>
> 	<network-id mcc=3D"555" mnc=3D"55"/>
> 	<apn>...</apn>
> </provider>
>
> If the Major Operator provides MAX_APN apns, then wouldn't this cause us
> to return the APNs from Major Operator, even though this is a conflict
> and we might potentially want APNs from MVNO?
>
> If this is indeed such a conflicted case then we need to let the user
> decide, not return any results as they're potentially erroneous.

Thanks for the comments. Please take a look at the PATCHv5 on the list, whi=
ch =

addresses this and other issues too.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============0852855564389067027==--

