Content-Type: multipart/mixed; boundary="===============2569102150490409103=="
MIME-Version: 1.0
From: Li, Li L <li.l.li@intel.com>
Subject: RE: How to get the SMS stored in SIM card
Date: Tue, 07 Sep 2010 09:56:42 +0800
Message-ID: <F2E9EB7348B8264F86B6AB8151CE2D7928045C89E5@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <4C5828EC.1020605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2569102150490409103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
  I have question about "The default SMS driver programs the modem to repor=
t SMS PDUs directly to the core". I want to know how to deal with the recei=
ved sms by ofono core? Where to save the sms? =


BR
Lily



 =

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Denis Kenzior
Sent: Tuesday, August 03, 2010 10:34 PM
To: ofono(a)ofono.org
Cc: Huang, Ye
Subject: Re: How to get the SMS stored in SIM card

Hi Ye,

On 08/03/2010 04:37 AM, Huang, Ye wrote:
> Hi
> =

>  =

> =

> The SMS we receive is class 1, right? Where to find the SMS we receive
> which store in SIM through ofono API? Thanks.
> =


oFono reports both Class 0 and un-classified / class 1 SMS messages.
oFono does not store SMS messages on the SIM or ME and does not handle
sim full conditions.

The default SMS driver programs the modem to report SMS PDUs directly to
the core.  If such a feature is unavailable on the particular modem,
then SMS messages are routed to SIM/ME storage, delivered to the core
and deleted.

You will not find any SMS messages on the SIM/ME if oFono is running
properly.

Regards,
-Denis
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============2569102150490409103==--

