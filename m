Content-Type: multipart/mixed; boundary="===============5670368977801939812=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/9] atmodem: sms: add quectel m95 quirks
Date: Fri, 12 Jul 2019 10:18:46 -0500
Message-ID: <a6b77863-1fad-972c-1a3f-7c917e9673e8@gmail.com>
In-Reply-To: <20190710215148.78083-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5670368977801939812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/10/19 4:51 PM, Martin Hundeb=C3=B8ll wrote:
> CNMA isn't mentioned in the m95 documentation, but trial'n'error has
> revealed some details:
>   * the CSMS query returns the list (0,128) instead of a range
>   * CNMA is enabled by setting 128 as CSMS service
>   * once enabled, SMS deliveries are acked by sending AT+CNMA without a
>     value setting
> =

> Add m95 quirks to the atmodem driver, so that CNMA is correctly
> detected, configured, and used.
> ---
>   drivers/atmodem/sms.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> =


Patches 1-4 applied, thanks.

Regards,
-Denis


--===============5670368977801939812==--

