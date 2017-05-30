Content-Type: multipart/mixed; boundary="===============6599904892305016882=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem/sms: don't check for free ME space on receive
Date: Tue, 30 May 2017 17:31:47 -0500
Message-ID: <fef79483-e071-5702-4657-fb69ec5807c0@gmail.com>
In-Reply-To: <20170530113238.15099-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6599904892305016882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/30/2017 06:32 AM, Alexander Couzens wrote:
> If the ME storage is full, the modem will reject new messages
> with a SMPP RP-Error 'Protocol error, unspecific'.
> It seems the qmimodem is first checking the ME storage for
> free space, then deliver the SMS via QMI and not saving it
> to the ME anyway.
> Using QMI_WMS_STORAGE_TYPE_NONE it doesn't check for free space.
>
> Tested-on: Quectel EC20
> ---
>  drivers/qmimodem/sms.c | 2 +-
>  drivers/qmimodem/wms.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============6599904892305016882==--

