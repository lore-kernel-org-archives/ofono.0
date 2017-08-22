Content-Type: multipart/mixed; boundary="===============1502356377531476342=="
MIME-Version: 1.0
From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: APN provisioning with connman (and duplicate profiles in MBPI)
Date: Tue, 22 Aug 2017 08:50:08 +0200
Message-ID: <20170822065008.GY10106@login.tika.stderr.nl>
In-Reply-To: <4e497160-bfa8-1e3f-ba22-0b7aedd61bef@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1502356377531476342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> oFono creates a single sentinel context when automatic provisioning fails.
> This is an indication to the provisioning UI that the user should be
> helped/asked/guided in providing a valid context configuration (e.g. APN,
> etc)
I was running on a headless beagleboard, so no GUI/desktop environment
present. I was asssuming that connman would offer the UI necessary to
set up Ofono, but I now understand this is not the case.

> Correct.  A C-based command line UI (similar to e.g. connmanctl) is
> something that is on our TODO list but we haven't gotten around to it yet.
Ah, that would be useful indeed.

Might I suggest that the documentation could be improved in this area?
In particular by:
 - noting that oFono provides a service, and can be controlled through
   separate provisioning UIs.
 - noting that oFono detects modems automatically, tries to set up a
   context/APN (but might need manual provisioning) and that if it is
   set up correctly, a service appears in connman.
 - noting that there is no CLI tool to control oFono, but there are some
   helpful scripts in the source tree.

Had I known this, I think my journey would have been much shorter :-)

> > - When actually connecting from connman (or activating a context using
> >   the ofono test/activate-context script), the reported errors are very
> >   unclear. I only got a "Not implemented" error, which is very
> >   non-descriptive and, looking at the code, is returned in quite some
> >   different places. There's also nothing in the log to indicate what
> >   went wrong.
> >   The activation error in my case was due to a missing tun kernel
> >   module, I submitted a separate patch for that.
> =

> Missing tun support in the kernel is reported via ofono_error inside
> drivers/atmodem/gprs-context.c.  So you most definitely should be seeing
> something in the log about it.
There is indeed an error message in the source:

static int at_gprs_context_probe(struct ofono_gprs_context *gc, unsigned in=
t vendor, void *data)
...
                ofono_error("Missing support for TUN/TAP devices");

However, this error message occurs during the probe, e.g. when plugging
in the modem. At that time, it prevents context driver from being added.
When actually trying to activate the context, it fails without any
meaningful error message (`assign_context()` in `src/gprs.c` silently
fails since no context driver is available).

In any case, please also see the patch I submitted, which makes sure
that tun autoloading works (so all of this is only a problem when tun
support is completely disabled, not just when the module is not loaded
yet).

Gr.

Matthijs

--===============1502356377531476342==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRSWNCQUVC
Q0FBR0JRSlptOVFmQUFvSkVEZVlyeFdoVmxaWWM4RVAvMkZRWko2Yy9ta0tCVDI1WVhKSHVLS0kK
SkprYUxnTEFUZlBIbTF3U0tQQlgyejJXdG1OV0x6dzFZY0dHQU13dDY4QndhS3I5MFgvL1R1Nmtu
WDJEMzFCKwpFOThiUjhDRWZrS0F0NWdvQlIvakdlVjVxY0t2Ym1BYnEyVytvM0ZwRi91ZXZMTnR5
VHR1bWJxcFFBa0R6VS91CldYaEtqcThleUFUV05ucXlZV1puMVB6QlVOL3h4WDQzVzdNWnJWaUxo
RDFLYzl4U0RVR1c0NHZiNWl6cnMwdXoKeXVWQ0tVQmhRalBFWG9GUm91aUtOVzY0dFdmSWkrMENY
aGpVVkhGNGI0UEduUzVQYkNzMkpjMHA0SjBPSWk5SAp5cmt5SUlKYU5CL3h2eDNCRk5jUzgzaFpW
bjg1cVJCL3ZldlhRVFh5UCs2WlU0SGZDL1dBdjJyaDc3Q2d2eEMrCm1LV0plWGkyYms3bU1OT0JF
cmxuZlM5M3RNbkNYelVtOU1DbEk1aStDTGtId1p6NTFMeHZmbzNrYzMwSG1WMisKckpDaWRURnVu
d2U3RCtXeTQ0bktMaXAvQ0JLakt5N0hSRitxeFV5QkpMVnc1UDJVSXhhUXkrTGhKMVViSEdjMwpC
NVZpdE9pL1ZpV0xpL1BPaVJNaFhqMTA5V2hhZytpY0hsRHhteDllRnRXZE1DMDR1bjJoRDRMTTFO
Y2FhWWhICnlyZEUvcDZMbE1JYXoyY05GSmlER0gyejlVZ3NWUEMzQnFBNFlJZThicEVta2ZsWTJM
eUNiM1hCaGdIenAvOHAKQWhhNStKUStzNnRHMFRydzQ0VDE0dC8zTU0xbG14Qlc4NWNlVjZrTHJT
RkxzVXNvMERQZXFRdGt6WU9LaitNaAp1NzhHYnd1M3hob01LbEJpTTEvTQo9bDRGYQotLS0tLUVO
RCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============1502356377531476342==--

