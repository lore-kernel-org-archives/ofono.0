Content-Type: multipart/mixed; boundary="===============2696953166831591053=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmimodem: fix sim file reading on MC7304
Date: Fri, 17 Feb 2017 11:18:12 -0600
Message-ID: <d73cc7da-a705-ce72-85b5-5f5475fe42b3@gmail.com>
In-Reply-To: <20170217150612.24137-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2696953166831591053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/17/2017 09:06 AM, Christophe Ronco wrote:
> Command read_file_info on MC7304 always fails.
> Using qmicli or AT command, I am able to read file info.
> Qmicli command is:
> qmicli -d /dev/cdc-wdm0 --uim-get-file-attributes=3D0x3f00,0x7fff,0x6fad
> [(null)] Successfully got file '/dev/cdc-wdm0' attributes from the UIM:
> Card result:
>         SW1: '0x90'
>         SW2: '0x00'
> File attributes:
>         File size: 4
>         File ID: 28589
>         File type: transparent
>         Record size: 0
>         Record count: 0
>         Read security attributes: (always) (null)
>         Write security attributes: (single) adm
>         Increase security attributes: (always) (null)
>         Deactivate security attributes: (single) adm
>         Activate security attributes: (single) adm
>         Raw:    62:17:82:02:41:21:83:02:6F:AD:8A:01:05:8B:...
>
> After a check of parameters sent by qmimodem driver and qmicli,
> the only difference is on parameter "Session Information".
> Session type sent by qmimodem driver is 'Card on slot 1'.
> Session type sent by qmicli command is 'primary-gw-provisioning'.
> Changing session type in qmimodem driver fixed problem (on this modem).
>
> Comparing with what is done by qmili command
> ---
>  drivers/qmimodem/sim.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============2696953166831591053==--

