Content-Type: multipart/mixed; boundary="===============3280233964218451627=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Read EF-SPDI and use it for SPN display.
Date: Mon, 22 Jun 2009 13:23:07 -0500
Message-ID: <200906221323.07667.denkenz@gmail.com>
In-Reply-To: <1245548448-6757-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3280233964218451627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>When the operator is one of those listed in EF-SPDI then we need to
>treat it like a HPLMN in deciding whether the SPN or PLMN name should
>be displayed.

Patch has been applied.  I fixed a couple minor style issues.  Thanks.

>---
>I was also going to try implementing the semantics described in EF-PNN /
>EF-OPL but I have not found evidence that it's not already handled by the
>modem in the responses to +COPN (i.e. it may already be taking care to
>substitute the network names?  is this specified somewhere or would this
>be very unlikely?)

Unfortunately +COPN is based on the operator list stored in the modem itsel=
f.  =

This generally means this list is pretty much garbage after a few years.  =

Check 22.101 Appending A, Section A.3.  Basically the +COPS=3D? lists the =

operator names stored in the ME, +COPS? is likely to report the NITZ name o=
nce =

it arrives.  The SIM EFpnn and EFopl is not queried unless you use vendor =

extensions.

For us the strategy should probably be:
- If EFpnn / EFopl exists on the SIM, read and cache
- If EFpnn / EFopl exists on the SIM and cache already exists, delay updati=
ng =

cache until later
- If EFpnn / EFopl cache name exists, use that name
- Otherwise use COPS name.

There's also the possibility of including our own database of mcc/mnc =

identifiers along with operator name and operator country.  This would prob=
ably =

have higher precedence over the COPS name.

Regards,
-Denis

--===============3280233964218451627==--

