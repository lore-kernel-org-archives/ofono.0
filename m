Content-Type: multipart/mixed; boundary="===============5948694535158642755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono has too tight limits for SIM lock code lengths
Date: Thu, 20 Jan 2011 11:35:16 -0600
Message-ID: <4D387254.1050706@gmail.com>
In-Reply-To: <1295427884.3171.0.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5948694535158642755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 01/19/2011 03:04 AM, Jussi Kangas wrote:
> Hi,
> =

> I've been testing SIM locks with Ofono and it looks to me that method
> is_valid_pin in src/common.c has somewhat too tight rules for PIN
> lenghts. SIM or subsidy lock codes can be longer than 8 digits (as
> dictated in 22.022 chapter 14)
> =


You might very well be correct.  The current assumptions are based on
11.11, but I'm not sure if USIMs or newer have relaxed these
restrictions.  Maybe others can chime in here.

> There are several ways to fix this. My current favourite is changing the
> is_valid_pin so that it takes the actual return value of
> sim_string_to_passwd instead of pin_type enumaration as parameter and
> checks with 16-digit limit the SIM locks.
> =

> Other option that comes to my mind would be separate a valid check
> method for SIM locks. =

> =

> As third option I suggest adding fifth value to pin_type enumeration and
> give that as a parameter for is_valid_pin to make it use different
> limits. It would require more specific code type recognition in calling
> function though. =


The first option sounds reasonable to me as a first attempt.  Care to
submit a proposal?

Regards,
-Denis

--===============5948694535158642755==--

