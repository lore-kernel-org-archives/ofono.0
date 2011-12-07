Content-Type: multipart/mixed; boundary="===============3713799118304198715=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 7/9] network: Add CPHS SPN fallback
Date: Wed, 07 Dec 2011 11:23:40 +0200
Message-ID: <4EDF309C.2050107@intel.com>
In-Reply-To: <4ED952A0.6000903@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3713799118304198715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 12/03/2011 12:35 AM, Denis Kenzior wrote:
> Actually I don't like this approach.  There are some interactions with
> the SIM refresh logic triggered by sim_spn_changed and this approach
> makes it very hard to puzzle out whether all cases are covered properly.
>   Also, the preference is always towards clearer, more readable code,
> even if at the expense of being more verbose.  Given how tiny
> sim_spn_read_cb is now, I'd rather you handle the CPHS variants separatel=
y.
>
> You are also not taking care of the CAT/SAT Refresh cases for the CPHS
> variants.
>
> Thinking more about it, the way I'd try to do this is to look up the
> necessary bits in the CPHS Information Service Table (CPHS 4.2 Section
> B.3.1.1).  Then only read CPHS SPN if the service is active / allocated.
>   Only read the short form if CPHS SPN is not available and the short SPN=
 is.

Thanks for the review and ideas here. Handling CPHS variants separately wou=
ld be =

cleaner and makes sense. Checking the CPHS Information Service Table will h=
elp =

to make the logic simpler too, I will take this approach. Also will check =

CAT/SAT Refresh cases for CPHS variants.

I will rework and prepare another patch.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============3713799118304198715==--

