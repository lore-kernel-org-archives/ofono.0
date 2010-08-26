Content-Type: multipart/mixed; boundary="===============3057939611894200515=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 10:23:16 -0500
Message-ID: <4C7686E4.5040007@gmail.com>
In-Reply-To: <1282827161-8351-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3057939611894200515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 07:52 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Enable or disable Fixed Dialing Numbers feature on SIM card.
> =

> If enabled, calls can be dialled or SMSs sent only to numbers listed on
> special FDN phonebook on the SIM card.

FDN has serious implications for the rest of the system, particularly on
SMS atom and Sim Toolkit.  oFono will either have to support the entire
thing properly or use a 'limited' FDN mode (e.g. if FDN is enabled, we
only permit emergency calls.)

We have really not made our mind what makes sense here yet.

Regards,
-Denis

--===============3057939611894200515==--

