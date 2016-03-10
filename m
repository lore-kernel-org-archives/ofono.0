Content-Type: multipart/mixed; boundary="===============8812108093210762427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/19] plugins/udevng: support the U-Blox TOBY-L2 series
Date: Thu, 10 Mar 2016 08:00:32 -0600
Message-ID: <56E17E00.4030106@gmail.com>
In-Reply-To: <1457538300-7183-2-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8812108093210762427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dongsu,

On 03/09/2016 09:44 AM, Dragos Tatulea wrote:
> From: Dongsu Park <dongsu@endocode.com>
>
> The newest generation of U-Blox TOBY-L2 series can be detected with
> VID 0x1546 (the same as before), and one of the following PIDs:
>
> * "0x1146" : high throughput profile
> * "0x1141" : fairly back-compatible profile
> * "0x1143" : low/medium throughput profile
>
> This patch adds detection for high throughput mode.
> ---
>   plugins/udevng.c | 2 ++
>   1 file changed, 2 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============8812108093210762427==--

