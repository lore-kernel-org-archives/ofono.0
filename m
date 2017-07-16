Content-Type: multipart/mixed; boundary="===============6135714159384279848=="
MIME-Version: 1.0
From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: APN provisioning with connman (and duplicate profiles in MBPI)
Date: Sun, 16 Jul 2017 21:10:47 +0200
Message-ID: <20170716191047.GY10106@login.tika.stderr.nl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6135714159384279848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey folks,

I just tried Connman and oFono on a Debian stretch system for the first
time, hoping to get a more robust solution for keeping a cellular and/or
ethernet connection up. It seems the duo is quite capable of doing what
I need, but there were a few bumps in setting this up, where I think
things could be improved.

Some of these issues might be more connman issues, but they're mostly on
the cross-over area between the two, so I'll post them here for now.

In somewhat chronological order:
 - I could not find any documentation on how to get a cellular
   connection up. Plugging in a dongle made the "cellular" technology
   appear in connman, but no services, with no indication of what needed
   to happen next.
 - When provisioning in oFono fails, a single gprs context is created
   without an APN. Setting the APN manually made the profile show up in
   connman and (eventually) work.
   It might be better to cange connman to create a service for a context
   without an APN, and show an error when trying to connect it, instead
   of completely hiding the context.
 - There does not seem to be any official commandline interface to ofono
   to figure out what is happening. There are "test" python scripts in
   the source repo, but these are not shipped in the Debian package
   (reported here: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D8683=
77)
 - When mobile-broadband-provider-info provision finds multiple matches
   for the operator (that is, multiple apns all with the same usage
   type), provisioning fails, disregarding *all* apns found. I believe
   this even happens when there is just one type duplicate (e.g. if
   multiple mms profiles are available and just one internet profile,
   the internet one is not used). Not entirely sure, though.
 - When multiple profiles match, it would not make sense for oFono to
   just pick an arbitrary one to use. Ideally, it would just create
   a context for each, and let the user select the right context. For
   this to actually work, the user must be able to distinguish them, and
   see all the relevant details for profile/context to allow choosing
   the right one.

   I tried simply passing "allow_duplicates=3DTRUE" to ..., which does
   indeed create all contexts, but seems to show only the first two as
   aservices in connman (not sure why just these two), and there is no
   way to really distinguish them (the service name is just the
   currently connected network name).

 - When actually connecting from connman (or activating a context using
   the ofono test/activate-context script), the reported errors are very
   unclear. I only got a "Not implemented" error, which is very
   non-descriptive and, looking at the code, is returned in quite some
   different places. There's also nothing in the log to indicate what
   went wrong.
   The activation error in my case was due to a missing tun kernel
   module, I submitted a separate patch for that.

 - I also ran into an issue where my modem was not properly detected at
   startup, debug output showed it couldn't detect the USB vidpid for
   some subdevices. I suspect there might be a race condition involved
   there, but I'm still investigating.

Gr.

Matthijs

--===============6135714159384279848==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRSWNCQUVC
Q0FBR0JRSlphN28yQUFvSkVEZVlyeFdoVmxaWXhUUVFBSUQvRVo2UUNld1NzWDZRdmMrNEoyZCsK
SmFOWVRDTlBOaWxuZDRkMjQ4eGNVUFNKNGlQcHRUVFVETk12Sno4Wk04MzMzVy82TWZyVFExU2l0
R2FtNHVsRQpsUGgrdTdnRGEzRCtpRXFUcCtUNXJjNVNBK0xJTWc0QU9FUGYvYzZVejhRZE5ULzVu
RXdidFhyWUYxSmV3MW9lCno4eGZuSmEvRTJuOEtWdEtEVWdvM2ZudGZmSHZQSk43R3J3QlhncWRR
R3JScUFNdVNxczNBR0dhNEUrS1BUQVEKNVVZbjhLU0FzNE95ZzZWZjRtQy81RjhHQ2pWNG5ldHBM
bVJTeHd4MVJFLzR1MkpEbjRTMU1MTDY3VzYrcm4wUQp4ZnIrWGcxV2FvNjdiSVM4TkUvRU1jb3A3
UGs3UWJkZGIxR0ZqQU9kRWFxMXk2OEM0T1JNUTZKY1NPQTc3SnJZCmxLM3NvTFZyeU8yTm9JY29t
Zi9XV0JkWUwwelhIdDNiYWRrVzZxK2JoSm5DVlRWZHlKWDUzU2lSL0h0eEdzUEIKZ2xZR0dmckNo
Z2FleUd6cVhqZGloMkM0Z2lqVDNkbk5IRG9oekIyUExlYzZZUWEwQno2SmNDbXhEZ2lVekc1ZQpO
ZjdQT21ZZnBXZHdaNWpDS2xzNFZVOEdFRWNhWENZTE92cGNxZ0h1aW9BR3BZajlPZUhlMGhxUWJp
U29JUkNjCk50cXZTZVJyaHhCYWVVR2N5Z3hKUGxweUtESXhQL2tYODNDckc5enRRblhSU1VBcWU4
K3BBNDZuSHFZVngyVFMKNjAwdm00MnhtaTRjaEZVZlNjY0RLN2xsVTByM2xSMWViMVZxelFnSzRL
WStqbXEzV0pneXl3UG9vL0FDWUE3ZwpQUW5OSCtCWXNoSWxzcExYbWd0RAo9Q3VqTwotLS0tLUVO
RCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============6135714159384279848==--

