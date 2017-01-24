Content-Type: multipart/mixed; boundary="===============0429258621185099188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add LTE to Telit #PSNT parser
Date: Tue, 24 Jan 2017 12:33:53 -0600
Message-ID: <b3830629-9b59-24b9-de5e-01f87f3fb6b0@gmail.com>
In-Reply-To: <c1435e38-d1f4-e8fb-ee5d-a3b067a7a536@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0429258621185099188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/24/2017 07:58 AM, Piotr Haber wrote:
> Network type of 4 in Telit #PSNT command response
> denotes LTE network.
> ---
>  drivers/atmodem/gprs.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Looks fine, but doesn't apply:
Applying: atmodem: add LTE to Telit #PSNT parser
fatal: corrupt patch at line 10
Patch failed at 0001 atmodem: add LTE to Telit #PSNT parser
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


Are you using git send-email?

Regards,
-Denis

--===============0429258621185099188==--

