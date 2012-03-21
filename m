Content-Type: multipart/mixed; boundary="===============8074020593227884225=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 05/12] call-forwarding: Minor cleanup of
 set_query_cf_callback
Date: Wed, 21 Mar 2012 13:47:26 +0200
Message-ID: <4F69BFCE.2010008@intel.com>
In-Reply-To: <4F6918C4.70803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8074020593227884225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 03/21/2012 01:54 AM, Denis Kenzior wrote:
>> -	if (cf->query_next =3D=3D cf->query_end) {
>> -		reply =3D dbus_message_new_method_return(cf->pending);
>> -		__ofono_dbus_pending_reply(&cf->pending, reply);
>> -	}
>> -
>
> Actually this part is here on purpose, we want to generate a reply
> before we generate a signal for PropertyChanged.

Thanks for the help here, it really missed my attention.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============8074020593227884225==--

