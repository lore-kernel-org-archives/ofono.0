Content-Type: multipart/mixed; boundary="===============4613986177085853570=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] hfpmodem: Handle repeated held call indicator
Date: Tue, 12 Jan 2016 10:31:59 -0600
Message-ID: <56952A7F.7050001@gmail.com>
In-Reply-To: <1452611009-15781-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4613986177085853570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 01/12/2016 09:03 AM, Kuba Pawlak wrote:
> An issue with iPhone 5C iOS 9.2 triggers desynchronization in call
> states. When an active call is put on hold and another call arrives,
> it is in WAITING state. It should be possible to answer it by issuing
> AT+CHLD=3D2 but the phone changes its state to INCOMING so ATA should be
> used. This change is advertised by sending callheld:2 event, but it is
> not handled. This event can be used to trigger CLCC poll to synchronize
> call states.
>
> +CIEV: 3,1   <- first call arrives
> AT+CLCC
> +CLCC: 1,1,4,0,0,"01234567890",129
> OK
> RING
> +CLIP: "01234567890",129
> ATA
> OK
> +CIEV: 2,1
> +CIEV: 3,0.
> AT+CHLD=3D2.$  <- first call is put on hold
> OK
> +CIEV: 7,2   <- notification confirming that call #1 is on hold
> +CCWA: "09876543210",129,1     <- second call arrives
> +CIEV: 7,2
> +CIEV: 3,1
> AT+CLCC
> +CLCC: 1,1,1,0,0,"01234567890",129
> +CLCC: 2,1,5,0,0,"09876543210",129 <- new call is still in WAITING state
> OK
> +CIEV: 7,2 <- phone iternally promotes WAITING call to INCOMING
> AT+CHLD=3D2  <- there is no WAITING call anymore, ATA should be used
> +CME ERROR:3
> ---
>   drivers/hfpmodem/voicecall.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============4613986177085853570==--

