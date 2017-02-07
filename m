Content-Type: multipart/mixed; boundary="===============4247942552001052751=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] plugins: telit: send AT&C0 on both channels
Date: Tue, 07 Feb 2017 11:08:28 -0600
Message-ID: <f7b5ef78-5f0e-ed15-f0d4-50bbfb112eeb@gmail.com>
In-Reply-To: <20170207112650.10222-1-git@andred.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4247942552001052751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On 02/07/2017 05:26 AM, Andr=C3=A9 Draszik wrote:
> At least firmware version 12.00.405 on the UE910-EUR otherwise
> closes the AT command port whenever the PPP connection is
> dropped, and we'd be left in a funny state.
>
> ---
> Changes in v2: Commit message updated
> ---
>  plugins/telit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============4247942552001052751==--

