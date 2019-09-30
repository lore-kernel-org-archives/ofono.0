Content-Type: multipart/mixed; boundary="===============9019487562817006971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] ublox: netreg: Also subscribe to UREG URC's
Date: Mon, 30 Sep 2019 16:10:48 -0500
Message-ID: <f4a94c0d-7a47-e5aa-5602-a19defcbec6c@gmail.com>
In-Reply-To: <20190930190411.23820-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9019487562817006971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/30/19 2:04 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> It turns out that both L2xx and L4xx modems are a bit
> buggy when it comes to send CREG URC's when the tech changes.
> Try to overcome this by subscribing to both UREG and CREG,
> and poll the other when any of the URC's are received.
> Protect from doing simultaneous polls though.
> ---
>   drivers/ubloxmodem/network-registration.c | 205 ++++++++++++++++------
>   1 file changed, 154 insertions(+), 51 deletions(-)
> =


Still no go:

denkenz(a)localhost ~/ofono-master $ git am --3way ~/merge/\[PATCH\ v2\]\ =

ublox\:\ netreg\:\ Also\ subscribe\ to\ UREG\ URC\'s.eml
Applying: ublox: netreg: Also subscribe to UREG URC's
Using index info to reconstruct a base tree...
error: patch failed: drivers/ubloxmodem/network-registration.c:28
error: drivers/ubloxmodem/network-registration.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 ublox: netreg: Also subscribe to UREG URC's
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


--===============9019487562817006971==--

