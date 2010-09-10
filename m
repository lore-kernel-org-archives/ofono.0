Content-Type: multipart/mixed; boundary="===============6049501862892978538=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Check if ussd is busy when doing ss
Date: Fri, 10 Sep 2010 16:27:06 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A6EF9B4@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C88EA21.3020302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6049501862892978538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Thursday, September 09, 2010 10:07 PM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH] Check if ussd is busy when doing ss
>
>Hi Yang,
>
>On 09/05/2010 09:19 PM, Yang Gu wrote:
>> It's still not clear how ss and ussd interfere with each other. Current
>> decision is each ss (call-barring, call-forwarding, etc.) has
>> interference with ussd, but there is no interference within these ss.
>> That is, call-barring has interference with ussd, but call-barring has
>> no interference with call-forwarding.
>
>Patch has been applied, but I broke it up into four patches.
>
>Are you planning to take care of cb_ss_control, cb_ss_password,
>cf_ss_control and cs_ss_control busy conditions separately?
>

I'm not following your question. We already check if ussd is busy at the be=
ginning of ussd_initiate(), so these functions are ok with necessary checks=
. =

On the other hand, I think we need also check if either of these supplement=
ary services (call barring, call forwarding and call settings) is busy when=
 doing a real unstructured supplementary service (ussd_initiate(),ussd_resp=
ond(), etc.). =



Regards,
-Yang

--===============6049501862892978538==--

