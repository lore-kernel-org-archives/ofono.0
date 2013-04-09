Content-Type: multipart/mixed; boundary="===============6687032363211014121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] hfpmodem: Send AT+BAC with the supported codecs
Date: Tue, 09 Apr 2013 14:37:14 -0500
Message-ID: <51646DEA.3030400@gmail.com>
In-Reply-To: <1365460863-14645-5-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6687032363211014121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/08/2013 05:41 PM, Vinicius Costa Gomes wrote:
> Before, the AT+BAC command was being sent with fixed information,
> now we send the command (that inform the AG of the codecs supported by
> the HF) with the codecs supported by the registered Handsfree Audio
> Agent.
> ---
>   drivers/hfpmodem/slc.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============6687032363211014121==--

