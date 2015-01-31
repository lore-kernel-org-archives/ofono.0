Content-Type: multipart/mixed; boundary="===============8373490480862934838=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sierra: add sim state polling after CFUN enable
Date: Sat, 31 Jan 2015 10:21:27 -0600
Message-ID: <54CD0107.9000704@gmail.com>
In-Reply-To: <1422614072-23635-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8373490480862934838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 01/30/2015 04:34 AM, Cedric Jehasse wrote:
> From: Cedric Jehasse <cedric.jehasse@softathome.com>
>
> When pin is queried shortly after a Siera dongle is plugged in, "AT+CPIN?"
> responds with "CME ERROR 14: SIM".
> Poll the sim, as already done by several other vendor plugins.
> ---
>   plugins/sierra.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============8373490480862934838==--

