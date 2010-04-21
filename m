Content-Type: multipart/mixed; boundary="===============1550887150381105007=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 05/17] Add parser for service record objects
Date: Wed, 21 Apr 2010 13:06:01 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CCC0487@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201004201655.53317.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1550887150381105007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,



>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Wednesday, April 21, 2010 5:56 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 05/17] Add parser for service record objects
>
>Hi Yang,
>
>> +	sr->serv_rec =3D g_try_malloc(sr->len);
>> +	if (sr->serv_rec =3D=3D NULL)
>> +		return FALSE;
>
>I suggest not trying to allocate 0 bytes.

The service record field is either meaningful value or "00", so it will nev=
er allocate 0 byte. Other patches are modified following this comment.

>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

Regards,
-Yang

--===============1550887150381105007==--

