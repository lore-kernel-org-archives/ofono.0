Content-Type: multipart/mixed; boundary="===============2820556496050005476=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gatchat: Fix parsing fields with odd number of
 quotation marks
Date: Thu, 10 Nov 2016 10:18:54 -0600
Message-ID: <58249DEE.6040004@gmail.com>
In-Reply-To: <1478769765-9839-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2820556496050005476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 11/10/2016 03:22 AM, Kuba Pawlak wrote:
> Events like +CLCC and +CCWA can have contact name attached to the
> end of line. If this field contains odd number of quotation marks,
> parser will eventually reject such message as malformatted.
> ---
>   gatchat/gatsyntax.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>

Both applied, thanks.

Regards,
-Denis


--===============2820556496050005476==--

