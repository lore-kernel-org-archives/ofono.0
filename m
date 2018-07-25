Content-Type: multipart/mixed; boundary="===============1972303840763981019=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem: Add gprs-context quirk for HUAWEI vendor
Date: Wed, 25 Jul 2018 14:12:22 -0500
Message-ID: <40d709e1-33c0-23a9-f804-133f79a04ff7@gmail.com>
In-Reply-To: <1532526314-32261-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1972303840763981019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 07/25/2018 08:45 AM, Christophe Ronco wrote:
> When ofono dies while connected using PPP, modem AT channel is not put
> back to command mode (tested with HUAWEI modems E3372 and MS2372).
> If ofono is restarted, it won't be able to connect as it gets no answer
> to AT commands on this AT channel.
> This patch adds a quirk to immediately send escape sequence on modem
> channel when gprs-context atom is removed.
> ---
>   drivers/atmodem/gprs-context.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> =


Both applied, thanks.

Regards,
-Denis


--===============1972303840763981019==--

