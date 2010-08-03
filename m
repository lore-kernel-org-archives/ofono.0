Content-Type: multipart/mixed; boundary="===============0045791076923161998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to get the SMS stored in SIM card
Date: Tue, 03 Aug 2010 09:34:20 -0500
Message-ID: <4C5828EC.1020605@gmail.com>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A1F666AAB7E@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0045791076923161998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

--===============0045791076923161998==--

