Content-Type: multipart/mixed; boundary="===============4538833559962671988=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Check if ussd is busy when doing ss
Date: Tue, 14 Sep 2010 17:51:23 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A79D376@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTinwe6A-=zWg0-_D9zRoYw5QdQ6i3198vpToc+e0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4538833559962671988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =



>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Pekka Pessi
>Sent: Monday, September 13, 2010 9:19 PM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH] Check if ussd is busy when doing ss
>
>Hi Yang,
>
>2010/9/6 Yang Gu <yang.gu@intel.com>:
>> It's still not clear how ss and ussd interfere with each other. Current
>> decision is each ss (call-barring, call-forwarding, etc.) has
>> interference with ussd, but there is no interference within these ss.
>> That is, call-barring has interference with ussd, but call-barring has
>> no interference with call-forwarding.
>
>There is only one signaling channel for the supplementary services.
>Only one supplementary service operation can be active at a time. (Or
>two, network can initiate ussd notify or request while
>mobile-originated ussd is pending.)

Thank you for the info. When you say only one MO ss operation can be active=
 at a time, do you mean modem will serialize them or oFono needs always to =
take care, or it's hardware specific?


Regards,
-Yang

--===============4538833559962671988==--

