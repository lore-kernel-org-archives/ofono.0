Content-Type: multipart/mixed; boundary="===============7667905808236929950=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: data channel setup for xmm7modem
Date: Mon, 04 Mar 2019 13:37:44 -0600
Message-ID: <5b100962-7b9d-a95d-c5d8-802b76ba54bc@gmail.com>
In-Reply-To: <1551261802-31126-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7667905808236929950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/27/2019 04:03 AM, Antara Borwankar wrote:
> Added the implementation required to setup data channel
> in ifxmodem gprs-context driver for xmm7modem vendor
> ---
>   drivers/ifxmodem/gprs-context.c | 51 ++++++++++++++++++++++++++++++++++=
+++----
>   1 file changed, 47 insertions(+), 4 deletions(-)
> =


Yes, this approach was much simpler and more understandable than what I =

came up with.  So applied, thanks!

I did push a follow-up commit that refactored things slightly, mostly to =

address style issues.  Please review and make sure I didn't screw =

anything up.

Regards,
-Denis


--===============7667905808236929950==--

